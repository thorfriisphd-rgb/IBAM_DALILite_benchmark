#!/usr/bin/env bash
set -euo pipefail

log() {
    echo "[DALI-PARSE] $*"
}

die() {
    echo "[DALI-PARSE ERROR] $*" >&2
    exit 1
}

RUN_ROOT="${1:-}"
OUT_TSV="${2:-}"

[[ -n "$RUN_ROOT" ]] || die "Missing <run_root>"
[[ -n "$OUT_TSV" ]] || die "Missing <out_tsv>"
[[ -d "$RUN_ROOT" ]] || die "Run directory not found: $RUN_ROOT"

mkdir -p "$(dirname "$OUT_TSV")"

TMP="$(mktemp)"
trap 'rm -f "$TMP"' EXIT

printf "project\tquery\tsubject\tz\trmsd\tlali\tnres\tpid\tdescription\ttxt_file\n" > "$TMP"

shopt -s nullglob
for proj in "$RUN_ROOT"/dali_*; do
    [[ -d "$proj" ]] || continue
    project="$(basename "$proj")"

    txt_files=("$proj"/*.txt)
    [[ ${#txt_files[@]} -gt 0 ]] || continue

    txt="${txt_files[0]}"

    row="$(awk '
        BEGIN{FS="[[:space:]]+"}
        /^[[:space:]]*[0-9]+:[[:space:]]/ {
            hit=1
            query=$3
            z=$4
            rmsd=$5
            lali=$6
            nres=$7
            pid=$8
            $1=$2=$3=$4=$5=$6=$7=$8=""
            sub(/^[ \t]+/, "", $0)
            desc=$0
            print query "\t" z "\t" rmsd "\t" lali "\t" nres "\t" pid "\t" desc
            exit
        }
    ' "$txt")"

    if [[ -n "$row" ]]; then
        query="$(echo "$row" | cut -f1)"
        z="$(echo "$row" | cut -f2)"
        rmsd="$(echo "$row" | cut -f3)"
        lali="$(echo "$row" | cut -f4)"
        nres="$(echo "$row" | cut -f5)"
        pid="$(echo "$row" | cut -f6)"
        desc="$(echo "$row" | cut -f7-)"
    else
        query=""
        z=""
        rmsd=""
        lali=""
        nres=""
        pid=""
        desc="PARSE_FAILURE"
    fi

    subject=""
    if [[ "$project" =~ ^dali_(.+)_vs_(.+)$ ]]; then
        query_name="${BASH_REMATCH[1]}"
        subject="${BASH_REMATCH[2]}"
    else
        query_name="$project"
    fi

    printf "%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n" \
        "$project" "$query_name" "$subject" "$z" "$rmsd" "$lali" "$nres" "$pid" "$desc" "$txt" >> "$TMP"
done

mv "$TMP" "$OUT_TSV"
log "Wrote summary: $OUT_TSV"