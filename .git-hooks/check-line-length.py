#!/usr/bin/env python3
"""Check that LaTeX files don't have overly long lines."""
import sys

MAX_LINE_LENGTH = 100
exit_code = 0

for filepath in sys.argv[1:]:
    with open(filepath, 'r') as f:
        for line_num, line in enumerate(f, 1):
            line_len = len(line.rstrip())
            if line_len > MAX_LINE_LENGTH:
                print(f"{filepath}:{line_num}: Line too long ({line_len} > {MAX_LINE_LENGTH})")
                exit_code = 1

sys.exit(exit_code)
