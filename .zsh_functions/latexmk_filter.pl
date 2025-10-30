#!/usr/bin/env perl

use strict;
use warnings;
use Term::ANSIColor qw(:constants);

my $nobox = 0; # Should box warning be excluded
my $nextlines = 0;
while (<>) {
    if ($nextlines > 0) { $nextlines--; print STDERR $_; }
    elsif (/^(!\s+)?LaTeX (?:Warning|Error)/i) { 
       print BRIGHT_RED BOLD $_, RESET; 
    }
    elsif (/^! Undefined control sequence\./i) { 
       chomp; print BRIGHT_RED BOLD $_, ": "; $nextlines = 1, RESET; 
    }
    elsif (/^! Use of .* doesn't match its definition\./i) {
       print BRIGHT_RED BOLD $_; $nextlines = 3; 
    }
    elsif (/^!/i) {
       print BRIGHT_RED BOLD $_, RESET; 
    }
    elsif (!$nobox && /(overfull|underfull|badbox)/i) { 
       print BRIGHT_YELLOW BOLD $_, RESET; 
    }
    else {
       print $_;
    }
}
