# hermes-ecc

Personal fork of [affaan-m/ECC](https://github.com/affaan-m/ECC) — used as my Claude Code config.

The full ECC tree (agents, skills, hooks, rules, MCP configs, plugin manifest, installers) is vendored in via `upstream` remote. To pull new ECC releases, run a sync script then re-run the installer.

## Prerequisites

- **Node.js 18+** and **git**
- macOS / Linux: a POSIX shell (bash / zsh)
- Windows: PowerShell 5.1+ (built into Windows 10/11) or PowerShell 7

## Install (first time)

### macOS / Linux

```bash
git clone https://github.com/ndruw2/hermes-ecc.git
cd hermes-ecc
./install.sh
```

This runs ECC's installer (`scripts/install-apply.js`), which populates `~/.claude/` with skills, agents, hooks, and rules.

### Windows (PowerShell)

```powershell
git clone https://github.com/ndruw2/hermes-ecc.git
cd hermes-ecc
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

This populates `%USERPROFILE%\.claude\` with the same content.

After install, open Claude Code in any project — ECC skills like `/code-review`, `/security-review`, `/init`, `/verify` should be available.

## Update (sync with upstream ECC)

### macOS / Linux

```bash
./scripts/hermes-sync.sh
./install.sh
```

### Windows

```powershell
.\scripts\hermes-sync.ps1
.\install.ps1
```

The sync script:
1. Adds the `upstream` remote (`https://github.com/affaan-m/ECC.git`) if missing
2. Fetches `upstream/main`
3. Merges it into the current branch

If a merge conflict happens, resolve it manually and commit.

## Adding personal customization

Keep your own agents/skills in dedicated subfolders so upstream merges stay clean. Examples:

- `agents/hermes-*.md`
- `skills/hermes-*/SKILL.md`
- `rules/hermes-*.md`

Don't edit ECC's own files unless you're prepared to resolve conflicts on every sync.

## License

Upstream ECC is MIT-licensed (see `LICENSE`). This fork inherits the same license.
