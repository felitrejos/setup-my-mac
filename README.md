# setup-my-mac

A one-command setup script to get a fresh macOS machine ready with everyday tools and apps.

## Usage

On a fresh Mac, open Terminal and run:

```bash
git clone https://github.com/felitrejos/setup-my-mac.git
cd setup-my-mac
./setup.sh
```

Or as a single command:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/felitrejos/setup-my-mac/main/setup.sh)"
```

The script is safe to re-run — it skips anything that's already installed.

## What it does

1. Installs the **Xcode Command Line Tools** (compilers, git)
2. Installs **[Homebrew](https://brew.sh)** if it isn't already present
3. Installs every CLI tool and app listed in the [`Brewfile`](Brewfile)
4. Installs a couple of global **npm** packages (`pnpm`, `vercel`)
5. Optionally sets your **git** name and email

## What gets installed

**Command-line tools & languages**
Node.js, Bun, Go, Zig, Python (3.12 & 3.13), uv, Poetry, CMake, Ninja, gh, wget, tree, nmap, Ollama, and more — see the [`Brewfile`](Brewfile) for the full list.

**Apps**
Ghostty, Zed, Raycast, 1Password, Notion, Linear, Zoom, Docker Desktop, Claude, Alcove, Wispr Flow.

## Installed manually

A few apps aren't on Homebrew. Install these by hand if you want them:

- [Dia](https://www.diabrowser.com) — browser

## Customizing

Edit the [`Brewfile`](Brewfile) to add or remove tools, then re-run `./setup.sh`.
