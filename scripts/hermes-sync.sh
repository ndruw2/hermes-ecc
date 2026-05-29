#!/usr/bin/env bash
set -euo pipefail

UPSTREAM_URL="https://github.com/affaan-m/ECC.git"
UPSTREAM_BRANCH="main"

if ! git remote get-url upstream >/dev/null 2>&1; then
  echo "[hermes-sync] adding upstream remote -> $UPSTREAM_URL"
  git remote add upstream "$UPSTREAM_URL"
fi

echo "[hermes-sync] fetching upstream/$UPSTREAM_BRANCH"
git fetch upstream "$UPSTREAM_BRANCH"

echo "[hermes-sync] merging upstream/$UPSTREAM_BRANCH into $(git branch --show-current)"
git merge "upstream/$UPSTREAM_BRANCH" "$@"

echo "[hermes-sync] done. Re-run ./install.sh to apply updates to ~/.claude/"
