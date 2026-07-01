#!/usr/bin/env bash
# One-time hook wiring (DEP method, both stores). Value never printed, never leaves this machine except to GitHub secrets.
# Usage: paste hook into deploy/.deploy.env (RENDER_DEPLOY_HOOK_URL=...) then run: ./deploy/SET_HOOK.sh
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/.."
source deploy/.deploy.env
[ -n "${RENDER_DEPLOY_HOOK_URL:-}" ] || { echo "[err] RENDER_DEPLOY_HOOK_URL empty in deploy/.deploy.env"; exit 1; }
printf '%s' "$RENDER_DEPLOY_HOOK_URL" | gh secret set RENDER_DEPLOY_HOOK_URL --repo webpointllc-com/mobile
echo "[ok] Hook stored as GitHub Actions secret. Local copy stays gitignored. Test: ./deploy/TRIGGER_DEPLOY.sh"
