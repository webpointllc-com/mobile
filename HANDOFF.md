# ✦ WEBPOINT MOBILE LANE — AGENT HANDOFF (iOS-portable)
Pattern: AUTODEPLOY_VARIABLE · Lane owner: Bill McCreary (Workplace Technologies / Webpoint)
This file travels: readable in the GitHub iOS app, in Claude iOS (paste or share), and live at
https://webpoint-mobile.onrender.com/HANDOFF.md once deployed. It is the wiring diagram AND the prompt.

## WHAT THIS LANE IS
- Repo: webpointllc-com/mobile (public) · branch: main
- Render: free static service "webpoint-mobile" · render.yaml Blueprint at repo root · autoDeploy: true
- LAW: /public is published as-is. NO build step. Every file in /public = a live URL in ~30s after push.
  public/tool.html  ->  https://webpoint-mobile.onrender.com/tool.html
- ONE-TIME PENDING: operator applies Blueprint at https://dashboard.render.com/blueprints/new -> select "mobile".

## SHIP FROM THE IPHONE (the whole loop)
1. Generate the tool/page with Claude iOS (single self-contained .html — inline CSS/JS, CDN fonts OK).
2. GitHub app -> webpointllc-com/mobile -> public/ -> ⋯ -> Create new file -> paste -> commit to main.
3. ~30s later it is live. Add a link on public/index.html when convenient.
Edits are the same loop: open the file in the GitHub app -> pencil -> commit.

## CREATE A NEW SERVICE (when a tool outgrows a static page)
1. New Webpoint repo (never realtime-tax; production ships from workplace-technologies via promotion gates).
2. Copy this repo's render.yaml, change `name:` (unique) and, for a backend, runtime/start command.
3. Operator applies the Blueprint once. autoDeploy is permanent after that.
4. Backends point at custom Workplace Technologies servers via VITE_API_BASE_URL — never wire metered third parties without operator approval.

## HARD GATES (any agent operating this lane)
1. Per-action, same-session operator approval for every push, deploy, or config publication. Never store approvals, tokens, or passcodes.
2. Secrets never in this repo, never in generated files, never in logs. Env values live only in the Render dashboard, set by the operator.
3. Precedent deployments and the private repos are READ-ONLY reference. Clone mechanisms, never touch sources.
4. Substrate stays out: no memory files, twin channels, or operator notes ship here (workshop ≠ product).
5. A URL is not "live" until it returns 200. Verify before declaring.

## REPORT-BACK
- Commit messages are receipts: "Shipment NNN: <what> (<device>)".
- Anything needing Twin 2 / Desktop follow-up: say it in chat AND note it in the commit body.

## CURRENT STATE (2026-07-01, prepped by Twin 2 on RIGHT HAND Mac)
- Scaffold + proof page shipped. Blueprint apply pending (operator's one click).
- webpoint-shipyard repo = superseded twin of this lane; mobile is canonical.
