#!/usr/bin/env sh
# Single script to update add-on version and/or Dozzle version across the repo.
# Run with no args to show current versions (HA add-on + Dozzle, and Dozzle master).
# Run from repository root or from dozzle-agent/

set -e

# Script may live in dozzle-agent/ or at repo root
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
case "$SCRIPT_DIR" in
  *dozzle-agent)
    ADDON_DIR="$SCRIPT_DIR"
    REPO_ROOT="${SCRIPT_DIR%/*}"
    ;;
  *)
    REPO_ROOT="$SCRIPT_DIR"
    ADDON_DIR="$REPO_ROOT/dozzle-agent"
    ;;
esac

CONFIG="$ADDON_DIR/config.yaml"
DOCKERFILE="$ADDON_DIR/Dockerfile"
CHANGELOG="$ADDON_DIR/CHANGELOG.md"
README_ADDON="$ADDON_DIR/README.md"
README_ROOT="$REPO_ROOT/README.md"

ADDON_VER=""
DOZZLE_VER=""
DO_GIT=""
DO_PUSH=""

# Colors (disabled if not a TTY or NO_COLOR set)
if [ -t 1 ] && [ -z "${NO_COLOR-}" ]; then
  C_RESET="\033[0m"
  C_BOLD="\033[1m"
  C_RED="\033[31m"
  C_GREEN="\033[32m"
  C_YELLOW="\033[33m"
  C_CYAN="\033[36m"
  C_DIM="\033[2m"
else
  C_RESET=""; C_BOLD=""; C_RED=""; C_GREEN=""; C_YELLOW=""; C_CYAN=""; C_DIM=""
fi

usage() {
  printf "${C_CYAN}Usage:${C_RESET} %s [--addon X.Y.Z] [--dozzle X.Y.Z] [--git] [--push]\n" "$0"
  echo "  --addon   Update add-on version (config.yaml, READMEs, CHANGELOG)"
  echo "  --dozzle  Update Dozzle Docker version (config.yaml, Dockerfile, READMEs, CHANGELOG)"
  echo "  --git     After update: git add + commit (message auto)"
  echo "  --push    After update: git add + commit + push"
  printf "\n${C_YELLOW}Examples (run from repo root, copy-paste):${C_RESET}\n"
  echo "  # Bump Dozzle only (no git)"
  echo "  ./dozzle-agent/update_version.sh --dozzle 10.0.6"
  echo ""
  echo "  # Bump Dozzle + commit + push"
  echo "  ./dozzle-agent/update_version.sh --dozzle 10.0.6 --push"
  echo ""
  echo "  # Bump add-on only + commit"
  echo "  ./dozzle-agent/update_version.sh --addon 0.3.10 --git"
  echo ""
  echo "  # Bump add-on + Dozzle + commit + push"
  echo "  ./dozzle-agent/update_version.sh --addon 0.3.10 --dozzle 10.0.6 --push"
  printf "\n${C_DIM}At least one of --addon or --dozzle is required.${C_RESET}\n"
  exit 1
}

# Show current versions (addon + dozzle in config, dozzle master from GitHub)
show_versions() {
  [ -f "$CONFIG" ] || { printf "${C_RED}Missing: %s${C_RESET}\n" "$CONFIG"; exit 1; }
  CUR_ADDON="$(awk -F': ' '/^version:/ {gsub(/"/,""); print $2; exit}' "$CONFIG")"
  CUR_DOZZLE="$(awk -F': ' '/^dozzle.version:/ {gsub(/"/,""); print $2; exit}' "$CONFIG")"
  MASTER_DOZZLE=""
  if command -v curl >/dev/null 2>&1; then
    RAW_TAG="$(curl -sL 'https://api.github.com/repos/amir20/dozzle/releases/latest' 2>/dev/null | sed -n 's/.*"tag_name": *"\([^"]*\)".*/\1/p' | head -1)"
    [ -n "$RAW_TAG" ] && MASTER_DOZZLE="${RAW_TAG#v}"
  fi
  [ -z "$MASTER_DOZZLE" ] && MASTER_DOZZLE="(unable to fetch)"

  # Next add-on version (increment patch: 0.3.9 -> 0.3.10)
  NEXT_ADDON="$CUR_ADDON"
  if [ -n "$CUR_ADDON" ] && echo "$CUR_ADDON" | grep -qE '^[0-9]+\.[0-9]+\.[0-9]+$'; then
    NEXT_ADDON="$(echo "$CUR_ADDON" | awk -F. '{$NF++; print $1"."$2"."$3}')"
  fi
  DOZZLE_EXAMPLE="${MASTER_DOZZLE}"
  [ "$DOZZLE_EXAMPLE" = "(unable to fetch)" ] && DOZZLE_EXAMPLE="${CUR_DOZZLE:-10.0.6}"

  printf "\n${C_BOLD}${C_CYAN}  Dozzle Agent – versions${C_RESET}\n"
  printf "${C_CYAN}  ─────────────────────────${C_RESET}\n"
  printf "  ${C_DIM}HA add-on (this repo)${C_RESET}  ${C_GREEN}%s${C_RESET}\n" "${CUR_ADDON:-?}"
  printf "  ${C_DIM}Dozzle (in config)${C_RESET}    ${C_GREEN}%s${C_RESET}\n" "${CUR_DOZZLE:-?}"
  printf "  ${C_DIM}Dozzle master (upstream)${C_RESET} ${C_YELLOW}%s${C_RESET}\n" "$MASTER_DOZZLE"
  printf "${C_CYAN}  ─────────────────────────${C_RESET}\n"
  printf "\n${C_YELLOW}  Examples (run from repo root, copy-paste):${C_RESET}\n"
  printf "  ${C_DIM}# Bump Dozzle only (no git)${C_RESET}\n"
  printf "  ./dozzle-agent/update_version.sh --dozzle %s\n\n" "$DOZZLE_EXAMPLE"
  printf "  ${C_DIM}# Bump Dozzle + commit + push${C_RESET}\n"
  printf "  ./dozzle-agent/update_version.sh --dozzle %s --push\n\n" "$DOZZLE_EXAMPLE"
  printf "  ${C_DIM}# Bump add-on only + commit${C_RESET}\n"
  printf "  ./dozzle-agent/update_version.sh --addon %s --git\n\n" "$NEXT_ADDON"
  printf "  ${C_DIM}# Bump add-on + Dozzle + commit + push${C_RESET}\n"
  printf "  ./dozzle-agent/update_version.sh --addon %s --dozzle %s --push\n\n" "$NEXT_ADDON" "$DOZZLE_EXAMPLE"
  printf "  ${C_DIM}Help:${C_RESET} ./dozzle-agent/update_version.sh --help\n\n"
  exit 0
}

while [ $# -gt 0 ]; do
  case "$1" in
    --addon)  ADDON_VER="$2"; shift 2 ;;
    --dozzle) DOZZLE_VER="$2"; shift 2 ;;
    --git)    DO_GIT=1; shift ;;
    --push)   DO_PUSH=1; DO_GIT=1; shift ;;
    -h|--help) usage ;;
    *) printf "${C_RED}Unknown option: %s${C_RESET}\n" "$1"; usage ;;
  esac
done

# No version args: show current versions and exit
[ -n "$ADDON_VER" ] || [ -n "$DOZZLE_VER" ] || show_versions

# --- Update config.yaml ---
if [ -n "$ADDON_VER" ] || [ -n "$DOZZLE_VER" ]; then
  [ -f "$CONFIG" ] || { printf "${C_RED}Missing: %s${C_RESET}\n" "$CONFIG"; exit 1; }
  if [ -n "$ADDON_VER" ]; then
    sed -i.bak "s/^version: .*/version: \"$ADDON_VER\"/" "$CONFIG" 2>/dev/null || \
      sed -i '' "s/^version: .*/version: \"$ADDON_VER\"/" "$CONFIG"
    printf "${C_GREEN}  ✓${C_RESET} config.yaml version → ${C_GREEN}%s${C_RESET}\n" "$ADDON_VER"
  fi
  if [ -n "$DOZZLE_VER" ]; then
    sed -i.bak "s/^dozzle.version: .*/dozzle.version: \"$DOZZLE_VER\"/" "$CONFIG" 2>/dev/null || \
      sed -i '' "s/^dozzle.version: .*/dozzle.version: \"$DOZZLE_VER\"/" "$CONFIG"
    printf "${C_GREEN}  ✓${C_RESET} config.yaml dozzle.version → ${C_GREEN}%s${C_RESET}\n" "$DOZZLE_VER"
  fi
  rm -f "$CONFIG.bak"
fi

# --- Update Dockerfile (Dozzle only) ---
if [ -n "$DOZZLE_VER" ]; then
  [ -f "$DOCKERFILE" ] || { printf "${C_RED}Missing: %s${C_RESET}\n" "$DOCKERFILE"; exit 1; }
  sed -i.bak "s/ARG DOZZLE_VERSION=.*/ARG DOZZLE_VERSION=$DOZZLE_VER/" "$DOCKERFILE" 2>/dev/null || \
    sed -i '' "s/ARG DOZZLE_VERSION=.*/ARG DOZZLE_VERSION=$DOZZLE_VER/" "$DOCKERFILE"
  sed -i.bak "s/|| echo \"10\.[0-9]*\.[0-9]*\"/|| echo \"$DOZZLE_VER\"/" "$DOCKERFILE" 2>/dev/null || \
    sed -i '' "s/|| echo \"10\.[0-9]*\.[0-9]*\"/|| echo \"$DOZZLE_VER\"/" "$DOCKERFILE"
  rm -f "$DOCKERFILE.bak"
  printf "${C_GREEN}  ✓${C_RESET} Dockerfile DOZZLE_VERSION → ${C_GREEN}%s${C_RESET}\n" "$DOZZLE_VER"
fi

# --- Current version line in READMEs ---
for README in "$README_ADDON" "$README_ROOT"; do
  [ -f "$README" ] || continue
  if [ -n "$ADDON_VER" ]; then
    sed -i.bak "s/\`[0-9.]*\` (Dozzle/\`$ADDON_VER\` (Dozzle/" "$README" 2>/dev/null || sed -i '' "s/\`[0-9.]*\` (Dozzle/\`$ADDON_VER\` (Dozzle/" "$README"
  fi
  if [ -n "$DOZZLE_VER" ]; then
    sed -i.bak "s/(Dozzle \`)[0-9.]*(\`)/(Dozzle \`$DOZZLE_VER\`)/" "$README" 2>/dev/null || sed -i '' "s/(Dozzle \`)[0-9.]*(\`)/(Dozzle \`$DOZZLE_VER\`)/" "$README"
  fi
  rm -f "$README.bak"
done
printf "${C_GREEN}  ✓${C_RESET} READMEs (Current version)\n"

# --- Badges version and release link (addon version only) ---
if [ -n "$ADDON_VER" ]; then
  for README in "$README_ADDON" "$README_ROOT"; do
    [ -f "$README" ] || continue
    sed -i.bak "s/version-v[0-9.]*-blue/version-v$ADDON_VER-blue/" "$README" 2>/dev/null || sed -i '' "s/version-v[0-9.]*-blue/version-v$ADDON_VER-blue/" "$README"
    sed -i.bak "s|/releases/tag/v[0-9.]*|/releases/tag/v$ADDON_VER|" "$README" 2>/dev/null || sed -i '' "s|/releases/tag/v[0-9.]*|/releases/tag/v$ADDON_VER|" "$README"
    rm -f "$README.bak"
  done
  printf "${C_GREEN}  ✓${C_RESET} READMEs (badges, release link)\n"
fi

# --- CHANGELOG ---
if [ -f "$CHANGELOG" ]; then
  if [ -n "$ADDON_VER" ] && ! grep -q "^## $ADDON_VER" "$CHANGELOG"; then
    LINE="- Bump Dozzle to ${DOZZLE_VER:-<dozzle version>}"
    [ -n "$DOZZLE_VER" ] || LINE="- Version bump"
    { echo ""; echo "## $ADDON_VER"; echo ""; echo "### Added"; echo "$LINE"; echo ""; sed -n '2,$p' "$CHANGELOG"; } > "$CHANGELOG.new"
    mv "$CHANGELOG.new" "$CHANGELOG"
    printf "${C_GREEN}  ✓${C_RESET} CHANGELOG section for ${C_GREEN}%s${C_RESET}\n" "$ADDON_VER"
  elif [ -n "$DOZZLE_VER" ] && [ -z "$ADDON_VER" ]; then
    # Only --dozzle: add line under first version's ### Added
    if ! grep -q "Bump Dozzle to $DOZZLE_VER" "$CHANGELOG"; then
      awk -v ver="$DOZZLE_VER" '
        /^### Added$/ && !done { print; print "- Bump Dozzle to " ver; done=1; next }
        { print }
      ' "$CHANGELOG" > "$CHANGELOG.new" && mv "$CHANGELOG.new" "$CHANGELOG"
      printf "${C_GREEN}  ✓${C_RESET} CHANGELOG (Dozzle %s)\n" "$DOZZLE_VER"
    fi
  fi
fi

# --- Git: add + commit (and optionally push) ---
if [ -n "$DO_GIT" ]; then
  if ! git -C "$REPO_ROOT" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    printf "${C_YELLOW}Not a git repo, skip --git/--push.${C_RESET}\n"
  else
    cd "$REPO_ROOT"
    git add dozzle-agent/config.yaml dozzle-agent/Dockerfile dozzle-agent/CHANGELOG.md dozzle-agent/README.md README.md dozzle-agent/update_version.sh
    if [ -n "$ADDON_VER" ] && [ -n "$DOZZLE_VER" ]; then
      MSG="Release $ADDON_VER, Dozzle $DOZZLE_VER"
    elif [ -n "$ADDON_VER" ]; then
      MSG="Release $ADDON_VER"
    else
      MSG="Bump Dozzle to $DOZZLE_VER"
    fi
    git commit -m "$MSG"
    printf "${C_GREEN}  ✓${C_RESET} Committed: ${C_CYAN}%s${C_RESET}\n" "$MSG"
    if [ -n "$DO_PUSH" ]; then
      BRANCH="$(git rev-parse --abbrev-ref HEAD)"
      git push origin "$BRANCH"
      printf "${C_GREEN}  ✓${C_RESET} Pushed to ${C_CYAN}origin %s${C_RESET}\n" "$BRANCH"
    fi
  fi
fi

printf "\n${C_BOLD}${C_GREEN}Done.${C_RESET}\n"
