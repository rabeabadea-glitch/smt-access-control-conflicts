#!/usr/bin/env bash
# Download the two policy files the article takes from the XPA repository of Xu et al.
# (github.com/dianxiangxu/XPA) at a fixed commit and check their SHA-256.
# XPA publishes no licence for its policy files, so they are fetched here, not redistributed.
# Run from the repository root:  bash v3/fetch_xpa.sh
set -euo pipefail
COMMIT=89c000495d81a1a82ca8de2ab0fc73fecfc4e440
BASE=https://raw.githubusercontent.com/dianxiangxu/XPA/$COMMIT/Experiments
OUT=v3/data/xpa
mkdir -p "$OUT"
fetch() {   # <path under Experiments> <sha256>
  local file="$OUT/$(basename "$1")"
  [ -f "$file" ] || curl -fsSL -o "$file" "$BASE/$1"
  echo "$2  $file" | sha256sum -c -
}
fetch pluto3/pluto3.xml             77d62814299990dfec5fd5b37057a143da3d13e839c3f8be76ef87b01499bd76
fetch fedora-rule3/fedora-rule3.xml c5fc93c477b7b56b028b4f079a7d1858520ea3ea43ed6608266444d3a36f8677
