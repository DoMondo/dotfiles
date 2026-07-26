#!/usr/bin/env python3
import sys
import subprocess
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

    uris = [p.as_uri() for p in valid_paths]
    
    # 1. text/uri-list
    uri_list_data = "\r\n".join(uris) + "\r\n"

    # 2. x-special/gnome-copied-files
    gnome_data = "copy\n" + "\n".join(uris)

    # 3. text/plain (Fallback)
    text_data = "\n".join(str(p) for p in valid_paths)

    # Calculate HTML representation with indicators on the same line for CopyQ display
    html_lines = []
    for p in valid_paths:
        if p.is_dir():
            ind = "DIR"
        else:
            ind = p.suffix[1:].upper() if p.suffix else "FILE"
        html_lines.append(f"<b>[{ind}]</b> {p}")
    html_data = "<br/>".join(html_lines)

    import json

    # Call copyq to add the item atomically to history and clipboard using JSON serialization
    try:
        item_data = {
            "text/uri-list": uri_list_data,
            "x-special/gnome-copied-files": gnome_data,
            "text/plain": text_data,
            "text/html": html_data
        }
        js_script = f"add({json.dumps(item_data)})"
        
        subprocess.run(
            ["copyq", "eval", "-"],
            input=js_script,
            text=True,
            check=True,
            capture_output=True
        )
        print(f"Copied {len(valid_paths)} file(s) to clipboard and history.")
    except subprocess.CalledProcessError as e:
        print(f"Error running copyq: {e.stderr.strip() if e.stderr else e}", file=sys.stderr)
        sys.exit(1)
    except FileNotFoundError:
        print("Error: copyq command not found. Please make sure copyq is installed and running.", file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    main()
