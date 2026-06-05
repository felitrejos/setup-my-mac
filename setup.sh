#!/usr/bin/env bash
set -euo pipefail

# setup-my-mac — bootstrap a fresh macOS machine with everyday tools and apps.

REPO_RAW="https://raw.githubusercontent.com/felitrejos/setup-my-mac/main"

echo "==> Setting up your Mac..."

# 1. Xcode Command Line Tools (git, compilers — required by Homebrew)
if ! xcode-select -p >/dev/null 2>&1; then
  echo "==> Installing Xcode Command Line Tools..."
  xcode-select --install || true
  echo "    Finish the Command Line Tools installer, then re-run this script."
  exit 1
fi

# 2. Homebrew
if ! command -v brew >/dev/null 2>&1; then
  echo "==> Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Make brew available in this shell
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# 3. Install everything from the Brewfile
echo "==> Installing formulae & casks (this is the long part)..."
brew update

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" 2>/dev/null && pwd || echo "")"
if [ -n "$SCRIPT_DIR" ] && [ -f "$SCRIPT_DIR/Brewfile" ]; then
  BREWFILE="$SCRIPT_DIR/Brewfile"
else
  # Running straight from curl — fetch the Brewfile to a temp file
  BREWFILE="$(mktemp -t Brewfile.XXXXXX)"
  curl -fsSL "$REPO_RAW/Brewfile" -o "$BREWFILE"
fi
brew bundle --file="$BREWFILE"

# 4. Global npm packages
if command -v npm >/dev/null 2>&1; then
  echo "==> Installing global npm packages..."
  npm install -g pnpm vercel
fi

# 5. Git identity (interactive — nothing personal is stored in this repo)
if [ -z "$(git config --global user.name || true)" ]; then
  read -rp "Git user.name (leave blank to skip): " GIT_NAME
  [ -n "${GIT_NAME:-}" ] && git config --global user.name "$GIT_NAME"
  read -rp "Git user.email (leave blank to skip): " GIT_EMAIL
  [ -n "${GIT_EMAIL:-}" ] && git config --global user.email "$GIT_EMAIL"
fi

cat <<'EOF'

==> Done with the automated part! 🎉

A few apps aren't on Homebrew. Install these by hand if you want them:
  • Dia       https://www.diabrowser.com

EOF
