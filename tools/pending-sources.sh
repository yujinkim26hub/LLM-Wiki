#!/usr/bin/env bash
# List sources in 00-Sources/ that don't yet have a summary in 10-Summaries/.
#
# A source is "covered" if any 10-Summaries/*.md has a frontmatter line
#   source: "[[00-Sources/<subdir>/<filename>]]"
# pointing at it (basename match, case-insensitive).
#
# This replaces the older slug-match logic, which produced false positives
# whenever a summary used the project's author-year slug convention
# (e.g. summary `creyghton-2010-h3k27ac-enhancers.md` vs source
# `Histone H3K27ac separates active from poised enhancers...md`).

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VAULT="$(cd "$SCRIPT_DIR/.." && pwd)"
SOURCES="$VAULT/00-Sources"
SUMMARIES="$VAULT/10-Summaries"

cd "$VAULT"

python3 - "$SOURCES" "$SUMMARIES" <<'PY'
import os, re, sys, glob

sources_dir, summaries_dir = sys.argv[1], sys.argv[2]

# 1. Index every summary's `source:` frontmatter reference (basename, lowercased)
covered = set()  # set of lowercased source basenames (no .md)
for sm in glob.glob(os.path.join(summaries_dir, '*.md')):
    try:
        with open(sm, encoding='utf-8') as f:
            head = f.read(4096)
    except Exception:
        continue
    # match: source: "[[00-Sources/.../Filename]]" or source: [[...]]
    for m in re.finditer(r'source:\s*"?\[\[([^\]\"]+)\]\]', head):
        ref = m.group(1).strip()
        base = os.path.basename(ref)
        base = re.sub(r'\.md$', '', base, flags=re.IGNORECASE)
        covered.add(base.lower())

# 2. Walk all source files; flag those whose basename is not covered.
#    Skip hidden directories (e.g. stray .moai/ scratch state inside 00-Sources/).
total = 0
pending = []
for root, dirs, files in os.walk(sources_dir):
    dirs[:] = [d for d in dirs if not d.startswith('.')]
    for fn in files:
        if fn.startswith('.'):
            continue
        total += 1
        base = re.sub(r'\.[^.]+$', '', fn)
        if base.lower() not in covered:
            rel = os.path.relpath(os.path.join(root, fn), os.path.dirname(sources_dir))
            pending.append((rel, base))

pending.sort()
for rel, _ in pending:
    print(f"PENDING  {rel}")
print()
print(f"{len(pending)} pending of {total} total source file(s).")
PY
