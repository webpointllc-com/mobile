#!/usr/bin/env bash
# Usage: ./pbcopy_iframe.sh [url]  — puts a mic-enabled responsive iframe in the Mac clipboard
U="${1:-https://webpoint-mobile.onrender.com/}"
printf '%s' "<iframe src=\"$U\" style=\"width:100%;height:820px;border:0;border-radius:12px;overflow:hidden;background:#0A0A0C;\" allow=\"microphone; autoplay\" allowfullscreen title=\"Webpoint Mobile Lane\"></iframe>" | pbcopy
echo "iframe for $U -> clipboard"
