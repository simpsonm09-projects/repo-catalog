# Fleet policy

The catalog answers which repositories the framework covers and what each one owes.
The normative standard is
[`.github/standards/owner.md`](https://github.com/simpsonm09-projects/.github/blob/main/standards/owner.md),
with [`core.md`](https://github.com/simpsonm09-projects/.github/blob/main/standards/core.md)
applying in full.
[`repo-standard`](https://github.com/simpsonm09-projects/repo-standard) holds the
implementation: the reusable workflows, the checkers and the apply scripts. This page
records the intent that GitHub cannot report, so the checks have something to check
against.

## Tiers

| Tier | Owes |
| --- | --- |
| `standard` | The standard, the checkers, the reusable workflows, and the rulesets. |
| `template` | A reference implementation of the standard. Its community files, `.aislop/config.yml`, `.github/config/flint.toml`, `trivy.yaml`, `CODEOWNERS`, and `pin-update.yml` match the standard's copies byte for byte. Its `ci.yml`, `dependabot.yml`, `mise.toml`, `justfile`, and `.gitattributes` differ by design. |
| `catalog` | This roster and policy. |
| `plugin` | A published plugin layer that consumes the standard. |
| `tooling` | Developer and machine tooling that consumes the standard. |
| `feature` | An application that consumes the standard. |
| `fixture` | A conformance repository used to validate the framework, not a product. |
| `legacy` | A repository kept for reference but outside the fleet. |

## Expectations

Every non-legacy repository carries the standard's community files, the docs layout,
the pinned caller CI, a `protect-main` ruleset, the owner topic, and public-repo
secret scanning and push protection. A repository's own CI runs the `standard` check,
which covers the tree-local files plus the settings, topics, and ruleset the
repository can read about itself. No repository audits another.

A repository may add a second test job named `test-<suffix>`. maxstack runs its installer
suite as `test-node` and its POSIX fixture lifecycle as `test-linux`, both on Linux, in
addition to `test`.

## Membership

Every organization repository is either in `repos.json` or in `ignore.json` with a
reason. `scripts/validate.mjs` fails when the roster and the organization disagree,
so a new repository cannot appear unnoticed.

## What does not belong here

Visibility, settings, topics, ruleset names, and CI conclusions are state. Read them
live from GitHub. A second copy of state in this repository would rot.
