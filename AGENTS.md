# repo-catalog working agreements

The fleet roster and policy. It holds intent, not state.

## Ground rules

- A roster entry is intent. Never store a value here that GitHub can report, such as visibility, settings, topics, or ruleset names. Read those live.
- Every organization repository is either in `repos.json` or in `ignore.json` with a reason. `scripts/validate.mjs` enforces this.
- The standard's checks live in `repo-standard`. This repository does not own a checker.
- No secret, credential, or machine path is committed.

## Commands

- `just fmt-check`, `just lint`, `just test`, `just test-policy`, `just check`, `just agent-files`.

## Repo facts

- Language and toolchain: Node for the validator and the `.mjs` helpers, pinned in `mise.toml`. Biome formats and gates complexity until the Bun toolchain migration recorded in `docs/exceptions.md`.
- `repos.json` is the roster. `ignore.json` is the exclusion list. `policy.md` is the tier policy.

## Skills

No repo-local skills. General best practices and integration come from the plugins.
