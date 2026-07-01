#!/usr/bin/env bash
# One-shot bootstrap watcher (AUTOMATION doctrine: one-shot only, exits after firing or 30 min)
# Polls the lane; on first HTTP 200: stamps proof, pushes receipt, loads iframe to clipboard, exits.
set -u
cd "$(dirname "${BASH_SOURCE[0]}")/.."
URL="https://webpoint-mobile.onrender.com/"
LOG=/tmp/mobile_lane_watch.log
echo "[watch] started $(date -u +%FT%TZ) — polling $URL every 15s, max 30 min" >> "$LOG"
for i in $(seq 1 120); do
  CODE=$(curl -s -o /dev/null -w "%{http_code}" --max-time 10 "$URL" || echo 000)
  if [ "$CODE" = "200" ]; then
    echo "[watch] 200 at $(date -u +%FT%TZ) — completing bootstrap" >> "$LOG"
    sed -i '' "s/SHIPMENT 001 &middot; 2026-07-01 UTC &middot; prepped by Twin 2, RIGHT HAND Mac/LANE VERIFIED LIVE \&middot; $(date -u +%FT%TZ) \&middot; auto-completed by one-shot watcher/" public/proof.html
    git add public/proof.html && git commit -q -m "Shipment 005: lane verified live at $(date -u +%FT%TZ) (one-shot bootstrap watcher, RIGHT HAND Mac)" && git push -q origin main >> "$LOG" 2>&1
    ./pbcopy_iframe.sh >> "$LOG" 2>&1
    osascript -e 'display notification "webpoint-mobile is LIVE — iframe in clipboard" with title "Mobile Lane"' 2>/dev/null
    echo "[watch] done." >> "$LOG"; exit 0
  fi
  sleep 15
done
echo "[watch] expired without 200 at $(date -u +%FT%TZ) — rerun after Blueprint apply" >> "$LOG"
