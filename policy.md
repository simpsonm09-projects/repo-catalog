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

## Agent access

Each repository states how much an AI agent may do against the organization
repository. The value is intent. GitHub has no such setting, and enforcement lives in
[`repo-standard`](https://github.com/simpsonm09-projects/repo-standard), not
here. Until an agent runs as an identity separate from the maintainer, the value is a
documented policy, not a control.

`repos.json` sets a default per tier in `agentAccessDefaults`, and a repository may
override it with `agentAccess`. The effective level is `agentAccess` when present,
otherwise the tier default.

| Level | Agent may | Mechanism once enforced |
| --- | --- | --- |
| `none` | Nothing. No credential reaches the organization repository. | No identity grant. |
| `read` | Clone, fetch, read. | No agent App installation. The standard gives `none` and `read` no installation. |
| `propose` | Push a branch and open a pull request, never merge. | Write access, and the agent absent from every ruleset. |
| `merge` | Merge its own green pull request through the API, with no direct push to `main`. | The App's repository-scoped token. Every required check and signature still applies. |
| `full` | Nothing. Retired. | Not available to an agent, because it would need a `protect-main` bypass. A `full` entry is read as `merge`. |

`protect-main` has no bypass actors, so no level grants a push to `main`, a merge of a
red pull request, or a settings change. The committed
[`protect-main.json`](https://github.com/simpsonm09-projects/repo-standard/blob/main/rulesets/protect-main.json)
sets `required_approving_review_count` to `0` and carries an empty `bypass_actors` list.
The merge gate is the required checks and the required signature, not a review count. The
fleet App installation supplies a repository-scoped token for `propose` and `merge`; it
requests no `administration` permission and appears in no ruleset. The standard's
[`governance guide`](https://github.com/simpsonm09-projects/repo-standard/blob/main/docs/governance.md)
and its [`agent-access guide`](https://github.com/simpsonm09-projects/repo-standard/blob/main/docs/features/agent-access.md)
describe the App and the drift check.

## Personally owned forks

`owned-forks.json` records repositories owned by `simpsonm09` and the upstream repository
each fork came from. It does not add a repository to the `simpsonm09-projects` roster or change
the organization membership reconciliation. Each entry names both repositories as
fully qualified `owner/repository` identities. The target must belong to `simpsonm09`.
The upstream records provenance and never grants write access.

Those repositories are governed by the
[`simpsonm09` owner standard](https://github.com/simpsonm09/simpsonm09/blob/main/.github/standards/owner.md),
not by this organization's standard, which excludes personal repositories. The entry
records provenance and agent intent only. It grants nothing.

The collection accepts only `propose`. For a personally owned target, `propose` means an
agent may push a branch and open a pull request. It does not allow merging or pushing to
`main`. A third-party upstream never receives pull requests or writes from this policy.
A missing policy file or malformed, duplicate, or unsupported entry fails local
validation. This validator checks policy data only. It does not grant access in the
installed gate.

Deployment is staged. The repo-standard resolver must read `owned-forks.json`, and the
organization plugin must add a target-aware adapter before this policy can affect gate
decisions. The adapter must keep upstreams read-only and restrict `propose` to the owned
target. Update pinned standard versions and apply the workspace after those changes land.
Until then, pstack writes remain denied.

## Personally owned repositories

`owned-repositories.json` records exact `owner/repository` identities owned by
`simpsonm09` that have no upstream repository. It is separate from `owned-forks.json`,
which requires upstream provenance. Each record accepts only `repository` and
`agentAccess`, and the only supported access level is `propose`. The validator rejects
other owners, malformed identities, duplicates, unknown fields, and identities that
collide with an owned-fork target or upstream. The
[`simpsonm09` owner standard](https://github.com/simpsonm09/simpsonm09/blob/main/.github/standards/owner.md)
is the authority for these repositories. This organization's standard does not govern
them, and the entry grants nothing.

The committed policy grants `propose` to the exact identity `simpsonm09/simpsonm09`.
That grant permits non-default branch pushes and pull requests within that same
repository. It denies default-branch pushes, force pushes, deletions, tag pushes,
merges, and administration. Local validation checks the record shape before the
validator queries the organization roster. The record affects no installed gate until
the runtime consumer uses the reviewed standard resolver and loads this policy from
committed `upstream/main`. Catalog validation does not prove that an installed consumer
has adopted that resolver or policy. See
[the owned-repository reference](docs/features/owned-repositories.md) for the file
shape and validation errors.

The tier defaults.

| Tier | Default |
| --- | --- |
| `standard` | `merge` |
| `template` | `merge` |
| `catalog` | `merge` |
| `plugin` | `merge` |
| `tooling` | `merge` |
| `feature` | `merge` |
| `fixture` | `read` |
| `legacy` | `none` |

## What does not belong here

Visibility, settings, topics, ruleset names, and CI conclusions are state. Read them
live from GitHub. A second copy of state in this repository would rot.
