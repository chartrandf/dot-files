#!/usr/bin/env bash
# quick-proxy <hostname> [--track] [--android]
# Open mitmweb intercepting only <hostname>; every other host passes through untouched.
# --track: stream flows to /tmp/quick-proxy/<hostname>.mitm, deleted when mitmweb exits.
# --android: point the adb-connected Android device at the proxy (via adb reverse), reset on exit.

set -euo pipefail

usage() { echo "Usage: quick-proxy <hostname> [--track] [--android]"; exit 1; }

host=""
track=false
android=false
android_proxy_set=false
proxy_started=false
for arg in "$@"; do
  case "$arg" in
    --track) track=true ;;
    --android) android=true ;;
    -h|--help) usage ;;
    -*) echo "🔴 Unknown option: $arg"; usage ;;
    *) if [ -z "$host" ]; then host="$arg"; else usage; fi ;;
  esac
done
[ -z "$host" ] && usage

if ! command -v mitmweb >/dev/null || ! command -v mitmdump >/dev/null; then
  command -v brew >/dev/null || { echo "🔴 mitmproxy missing and Homebrew not found"; exit 1; }
  read -p "mitmproxy is not installed. Install it with brew? (Y/n) " -n 1 -r
  echo
  [[ $REPLY =~ ^[Nn]$ ]] && exit 1
  brew install mitmproxy
fi

host_regex="^$(printf '%s' "$host" | sed 's/\./\\./g')(:[0-9]+)?$"
args=(--listen-port 9090 --set web_port=9091 --set "allow_hosts=$host_regex")

ip="$(ipconfig getifaddr en0 2>/dev/null || echo '<mac-ip>')"
echo "Intercepting: $host"
$android || echo "Device proxy: $ip:9090 (install the CA from http://mitm.it)"

if $track; then
  umask 077
  dir=/tmp/quick-proxy
  mkdir -p "$dir"
  capture="$dir/$host.mitm"
  args+=(--set "save_stream_file=$capture")
  echo "Tracking: $capture (deleted on exit)"
fi

cleanup() {
  $proxy_started && echo "Closing proxy..."
  if $android_proxy_set; then
    adb shell settings put global http_proxy :0 || echo "🔴 Failed to reset Android proxy, run: adb shell settings put global http_proxy :0"
    adb reverse --remove tcp:9090 2>/dev/null || true
    echo "Android proxy reset"
  fi
  if $track; then
    rm -f "$capture"
    echo "Capture deleted: $capture"
  fi
}
trap cleanup EXIT

if $android; then
  command -v adb >/dev/null || { echo "🔴 adb not found"; exit 1; }
  devices=()
  while read -r serial state; do
    case "$state" in
      device) devices+=("$serial") ;;
      unauthorized) echo "🔴 $serial: unauthorized, accept the USB debugging prompt on the device" ;;
      *) echo "🔴 $serial: $state" ;;
    esac
  done < <(adb devices | tail -n +2 | awk 'NF')
  if [ ${#devices[@]} -eq 0 ]; then
    echo "🔴 No Android device connected"
    exit 1
  fi
  if [ -z "${ANDROID_SERIAL:-}" ]; then
    if [ ${#devices[@]} -eq 1 ]; then
      ANDROID_SERIAL="${devices[0]}"
    else
      echo "Several Android devices connected, pick one:"
      select ANDROID_SERIAL in "${devices[@]}"; do [ -n "$ANDROID_SERIAL" ] && break; done
    fi
  fi
  [[ " ${devices[*]} " == *" $ANDROID_SERIAL "* ]] || { echo "🔴 Device $ANDROID_SERIAL not connected"; exit 1; }
  export ANDROID_SERIAL
  echo "Android device: $ANDROID_SERIAL"
  android_proxy_set=true
  adb reverse tcp:9090 tcp:9090 >/dev/null
  adb shell settings put global http_proxy 127.0.0.1:9090
  echo "Android proxy: 127.0.0.1:9090 via adb reverse (reset on exit)"
fi

proxy_started=true
mitmweb "${args[@]}"
