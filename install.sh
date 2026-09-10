#!/usr/bin/env bash
# Copies the subagent templates from this repo into a target project's .claude/agents/ directory.
set -e

TARGET="${1:-.}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST="$TARGET/.claude/agents"

mkdir -p "$DEST"
cp "$SCRIPT_DIR/.claude/agents/"*.md "$DEST/"

echo "Telepítve: $DEST"
echo "Ne felejtsd el commitolni és pusholni a célprojektben, hogy telefonon és Remote Controllal is működjön."
