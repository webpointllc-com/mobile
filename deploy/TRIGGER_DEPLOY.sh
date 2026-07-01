#!/usr/bin/env bash
# Mobile Lane — TRIGGER_DEPLOY (cloned mechanism: AUTODEPLOY_VARIABLE precedent; precedent untouched)
# Hook-first -> API fallback -> push-note fallback. Health check before declaring live.
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/.."

[[ -f deploy/.deploy.env ]] && { set -a; source deploy/.deploy.env; set +a; }

if [[ -n "${RENDER_DEPLOY_HOOK_URL:-}" ]]; then
  echo "[hook] POST Render deploy hook…"
  curl -fsS -X POST "${RENDER_DEPLOY_HOOK_URL}" && echo && echo "[ok] Hook accepted (build ~30s)."
elif [[ -n "${RENDER_API_KEY:-}" && -n "${RENDER_SERVICE_ID:-}" ]]; then
  echo "[api] POST deploys for ${RENDER_SERVICE_ID}…"
  HTTP=$(curl -sS -o /tmp/mobile_deploy_resp.txt -w "%{http_code}" \
    -X POST "https://api.render.com/v1/services/${RENDER_SERVICE_ID}/deploys" \
    -H "Authorization: Bearer ${RENDER_API_KEY}" -H "Content-Type: application/json" -d '{}')
  [[ "$HTTP" == 20* ]] && echo "[ok] Deploy triggered (HTTP $HTTP)." || { echo "[err] HTTP $HTTP"; cat /tmp/mobile_deploy_resp.txt; exit 1; }
else
  echo "[skip] No hook/key in deploy/.deploy.env — push to main triggers autoDeploy anyway."
fi

BASE="${MOBILE_URL:-https://webpoint-mobile.onrender.com}"
echo "[health] GET ${BASE%/}/"
curl -fsS --connect-timeout 15 --max-time 45 -o /dev/null -w "HTTP %{http_code}\n" "${BASE%/}/" \
  && echo "[ok] Lane reachable." || { echo "[warn] Not reachable — may still be building or bootstrap pending."; exit 1; }
