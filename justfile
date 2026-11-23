# Cross-platform task runner for humans and agents. `just --list` shows every
# recipe. Keep each recipe a thin call to a portable tool or a script under
# scripts/. See https://github.com/simpsonm09-projects/repo-standard/blob/main/docs/task-runner.md
set windows-shell := ["powershell.exe", "-NoLogo", "-NoProfile", "-Command"]

# List the recipes.
default:
    @just --list

# Install the pinned tools.
install:
    mise install

# Format JavaScript, JSON and the test files with Biome.
fmt:
    mise exec -- biome format --write .

# Check formatting with Biome.
fmt-check:
    mise exec -- biome format .

# Run every linter over the tracked files.
lint:
    mise exec -- flint run --full

# Fix what the linters can fix.
lint-fix:
    mise exec -- flint run --fix

# Run the Biome complexity gate over the repository.
complexity:
    mise exec -- biome lint .

# Run the AI-slop gate.
aislop:
    npx --yes aislop@0.16.1 ci

# Validate the roster against the organization. `mise run test` holds the command.
test:
    mise run test

# Run the local policy and agent-file tests without querying GitHub.
test-policy:
    mise exec -- node --test test/owned-forks.test.mjs test/owned-repositories.test.mjs scripts/agent-files.test.mjs

# Everything CI requires.
check: fmt-check lint test test-policy

# Historical alias for `check`, kept for the support template.
verify: check

# Install the guarded git hook.
hooks:
    git config --local core.hooksPath .githooks

# Check the .agents/skills tree and its .claude/skills links.
agent-files:
    mise exec -- node scripts/agent-files.mjs

# Prune remote-tracking refs and delete local branches merged into main.
prune:
    mise exec -- node scripts/prune.mjs
