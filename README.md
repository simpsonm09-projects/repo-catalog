# repo-catalog

The fleet roster and policy for the `simpsonm09-projects` organization.

This repository lives in `simpsonm09-projects/repo-catalog`. Work happens on a branch
with a pull request into `main`.
See [`repo-standard`](https://github.com/simpsonm09-projects/repo-standard)
for the branch model and the protection rules.

## What it does

It holds the repositories tracked under the fleet framework, the tier of each one,
the adoption status, and the policy for the tiers. The standard holds the checks.
This repository holds only the intent that GitHub cannot report.

The normative policy is the
[`simpsonm09-projects` owner standard](https://github.com/simpsonm09-projects/.github/blob/main/standards/owner.md),
with [`core.md`](https://github.com/simpsonm09-projects/.github/blob/main/standards/core.md)
applying in full. [`repo-standard`](https://github.com/simpsonm09-projects/repo-standard)
holds the implementation. Personal repositories in `simpsonm09` are governed by the
[`simpsonm09` owner standard](https://github.com/simpsonm09/simpsonm09/blob/main/.github/standards/owner.md).

## Layout

- `repos.json` is the roster.
- `ignore.json` lists the organization repositories that are out of the fleet.
- `owned-forks.json` records personally owned forks and their upstream repositories.
- `owned-repositories.json` records exact personal repository identities without upstreams.
- `policy.md` describes the tiers and the expectations.
- `scripts/validate.mjs` validates both owned-target policies locally, then checks the roster against the organization.

## Quick start

```bash
just install    # install the pinned tools with mise
just check      # everything CI requires
```

## Commands

| Recipe | Does |
| --- | --- |
| `just` | Lists the recipes. |
| `just install` | Installs the pinned tools with `mise install`. |
| `just fmt` | Formats with Biome. |
| `just fmt-check` | Checks formatting with Biome. |
| `just lint` | Runs flint over the tracked files. |
| `just complexity` | Runs the Biome complexity gate. |
| `just test` | Validates the roster against the organization. |
| `just test-policy` | Runs the local policy and agent-file tests without querying GitHub. |
| `just check` | Runs everything CI requires. |
| `just hooks` | Installs the guarded git hook. |
| `just agent-files` | Checks `.agents/skills/` against `.claude/skills/`. |
| `just prune` | Deletes local branches merged into `main`. |

`just verify` stays as an alias for `just check`, because the shared `SUPPORT.md`
names it.

## Documentation

Read [`docs/README.md`](docs/README.md).

## License

MIT. See [`LICENSE`](LICENSE).

## Related repositories

- [`repo-standard`](https://github.com/simpsonm09-projects/repo-standard) owns the shared CI, linting, security, and governance.
- [`repo-template`](https://github.com/simpsonm09-projects/repo-template) is the reference implementation.
