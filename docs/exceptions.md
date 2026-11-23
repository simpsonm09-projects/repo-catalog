# Exceptions

One row per rule this repository cannot meet yet. The reason and the revisit date
are required. The shared `standard` job reads this file.

| Rule | Reason | Revisit |
| --- | --- | --- |
| `C5.1` | The audit snapshot's median pull request run was 77 s. The roster validation job is a single `gh repo list` call plus the local checks, so the remaining time is runner setup and the shared jobs. | 2027-02-28 |
| `C7.3` | Biome still formats and gates complexity, and the `.mjs` helpers run on Node. The validator has no dependencies to install, so the repository has no `package.json` or `bun.lock` yet. The Bun toolchain (`bun fmt`, oxlint, `bun check`, `bun test`) migrates with the TypeScript port. | 2027-05-31 |
| `C7.4` | `scripts/` is still `.mjs` on Node. The validator and the policy tests port to Bun TypeScript one script at a time; this change adds the `fmt`, `fmt-check`, `check`, `hooks` and `agent-files` recipes without the Bun toolchain. | 2027-05-31 |
| `ci/coverage` | The repository has no executable code to measure; it validates JSON policy data. The coverage job is absent and the shared standard job reads this row. | 2027-05-31 |
