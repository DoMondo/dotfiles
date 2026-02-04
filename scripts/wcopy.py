#!/usr/bin/env python3
import sys
import os
import signal
from pathlib import Path

def main():
    if len(sys.argv) < 2:
        print("Usage: wcopy <file> [files...]", file=sys.stderr)
        sys.exit(1)

    files = sys.argv[1:]
    valid_paths = []
    for f in files:
        p = Path(f).resolve()
        if not p.exists():
            print(f"Error: File not found: {f}", file=sys.stderr)
            sys.exit(1)
        valid_paths.append(p)

    # Initial validation passed
    print(f"Copying {len(valid_paths)} file(s) to clipboard...")

    # Daemonize to detach from shell
    try:
        pid = os.fork()
        if pid > 0:
            sys.exit(0)
    except OSError as e:
        print(f"Fork failed: {e}", file=sys.stderr)
        sys.exit(1)

    os.setsid()

    try:
        pid = os.fork()
        if pid > 0:
            sys.exit(0)
    except OSError as e:
        sys.exit(1)

    # Grandchild process
    # Redirect standard file descriptors
    sys.stdout.flush()
    sys.stderr.flush()
    si = open(os.devnull, 'r')
    so = open(os.devnull, 'a+')
    se = open(os.devnull, 'a+')
    os.dup2(si.fileno(), sys.stdin.fileno())
    os.dup2(so.fileno(), sys.stdout.fileno())
    os.dup2(se.fileno(), sys.stderr.fileno())

    # Singleton logic: Kill previous instance
    pid_file = Path("/tmp/wcopy_active.pid")
    if pid_file.exists():
        try:
            old_pid = int(pid_file.read_text().strip())
            if old_pid != os.getpid():
                try:
                    os.kill(old_pid, signal.SIGTERM)
                except ProcessLookupError:
                    pass
        except Exception:
            pass
            
    # Write current (grandchild) PID
    # We need to do this AFTER the second fork in the grandchild
    
    run_clipboard(valid_paths)

def run_clipboard(paths):
    from PyQt5.QtWidgets import QApplication
    from PyQt5.QtCore import QMimeData, QByteArray, QTimer
    
    # Update PID file with current process ID
    Path("/tmp/wcopy_active.pid").write_text(str(os.getpid()))

    # Ensure we use flexible encoding
    def encode(s):
        return s.encode('utf-8')

    # Create App
    app = QApplication([])
    
    clipboard = app.clipboard()
    mime = QMimeData()

    uris = [p.as_uri() for p in paths]
    
    # 1. text/uri-list
    uri_list_data = "\r\n".join(uris) + "\r\n"
    mime.setData("text/uri-list", QByteArray(encode(uri_list_data)))

    # 2. x-special/gnome-copied-files
    gnome_data = "copy\n" + "\n".join(uris)
    mime.setData("x-special/gnome-copied-files", QByteArray(encode(gnome_data)))

    # 3. text/plain (Fallback)
    text_data = "\n".join(str(p) for p in paths)
    mime.setText(text_data)
    
    clipboard.setMimeData(mime)

    # We do NOT quit on changed event anymore because it's fragile with watchers.
    # We stay alive until killed by the next wcopy instance or system shutdown.
    # Optional: We could add a timeout (e.g., 1 hour) to auto-quit.
    
    # Run
    app.exec_()

if __name__ == "__main__":
    main()
