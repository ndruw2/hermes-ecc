#!/bin/bash
# SessionStart hook for hermes-ecc.
# Installs ECC (this repo) into the session container's ~/.claude/
# so slash commands like /ecc-guide, /plan, /code-review are available
# when running Claude Code on the web.
set -euo pipefail

# Only run in Claude Code remote (web) environments. Local Mac/Linux
# users install once via `./install.sh` and don't need this hook.
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

REPO_ROOT="${CLAUDE_PROJECT_DIR:-$(cd "$(dirname "$0")/../.." && pwd)}"
cd "$REPO_ROOT"

echo "[hermes-ecc] session-start: installing ECC into ~/.claude/"

# Install npm deps if not already present (container state is cached, so
# subsequent sessions skip this).
if [ ! -d node_modules ]; then
  echo "[hermes-ecc] installing npm dependencies"
  npm install --omit=dev --no-audit --no-fund --silent
fi

# Apply the full ECC install profile to ~/.claude/.
# The installer is idempotent — safe to run on every session start.
echo "[hermes-ecc] applying ECC install profile: full"
node scripts/install-apply.js --profile full >/tmp/hermes-ecc-install.log 2>&1 || {
  echo "[hermes-ecc] install failed, see /tmp/hermes-ecc-install.log"
  tail -20 /tmp/hermes-ecc-install.log >&2
  exit 1
}

CMD_COUNT=$(ls "${HOME}/.claude/commands/" 2>/dev/null | wc -l | tr -d ' ')
AGENT_COUNT=$(ls "${HOME}/.claude/agents/" 2>/dev/null | wc -l | tr -d ' ')
SKILL_COUNT=$(ls "${HOME}/.claude/skills/ecc/" 2>/dev/null | wc -l | tr -d ' ')
echo "[hermes-ecc] ready: ${CMD_COUNT} commands, ${AGENT_COUNT} agents, ${SKILL_COUNT} skills"
