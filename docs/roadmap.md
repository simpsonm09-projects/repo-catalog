# Fleet roadmap

The intent the roster does not carry: what the fleet is building next. State lives on
GitHub; this page holds goals and open work.

The 2026-10-15 roster review read local tracking refs, not a live GitHub fetch, and found
the local, fork, and organization `main` refs agreeing in all 17 catalog repositories. A
later inventory, dated 2026-10-16 UTC, read local tracking refs again and found all sixteen
repositories that pin repo-standard on `5da7073`, the current standard `main`, so the
consumer pin rollout is complete. `simpsonm09-maxstack`'s update in pull request #83 merged
at `2026-10-16T02:51:54Z` as `0d17ea0`, with all 17 checks reporting SUCCESS for the exact
head `8b4a283`, and the local, fork, and organization `main` refs all read `0d17ea0`. The
standard's own caller CI template, `templates/caller-ci.yml`, still pins `a9bbf9e`, a
separate onboarding gap, so full fleet alignment is not complete. These are dated snapshots,
not live counts.

## Goals

1. Every repository ships code a reviewer trusts: real linting, tests that gate, and a
   proof of behavior on the real artifact.
2. A change lands through one pull request that runs the same checks locally and in CI.
3. An agent can work in any repository from its `just` entry points and its docs alone.
4. No secret, credential, or machine path is ever committed, and every public repository
   carries branch protection and security scanning.

## Done

- The standard, the reusable workflows, the rulesets, and the two checkers.
- The gates: signed commits and the `test` check are required, and a definition of done
  backs the pull request checklist.
- A report-only Trivy license scan.
- Dependabot as the single updater.
- Kotlin and Java in the shared lint table, so a JVM repository lints through the same job.
- A generated-OpenAPI contract rule: an API repository emits its document from annotations, and the checker fails a hand edit or a missing `spec` recipe.
- The standard's committed `protect-main.json` requires no approval and carries no bypass
  actors. The merge gate is the required checks and the required signature. Live ruleset
  deployment is not recorded here.

## Open

- Language linting. Pin the per-language linters and formatters in each repository's
  `mise.toml` and run them through the shared lint job. See the standard's
  [`linting`](https://github.com/simpsonm09-projects/repo-standard/blob/main/docs/linting.md).
- CodeQL. A repository uses CodeQL default setup when it has executable source in a
  language CodeQL supports. It carries no `codeql.yml`, and it is never a required check.
  At the latest inventory review, CodeQL was present on maxstack, dev-setup, and all four
  language fixtures. `repo-template` relies on default setup. See the standard's
  [`automation`](https://github.com/simpsonm09-projects/repo-standard/blob/main/docs/automation.md#codeql).
- Coverage. A repository with a coverage job requires `coverage / coverage`. `repo-catalog`
  has no coverage job and declares `ci/coverage` in its own [`exceptions.md`](exceptions.md).
  `simpsonm09-maxstack` and `dev-setup` still need a coverage pilot because their Node code
  can be measured. A repository without a coverage job declares the exception locally in
  `docs/exceptions.md`; the standard's
  [`exceptions.json`](https://github.com/simpsonm09-projects/repo-standard/blob/main/docs/exceptions.json)
  remains the fallback.
- Verification. Audit which repositories have a verification skill, image build smoke job,
  and end-to-end checks before defining the remaining gaps. Release workflows are present
  on browser-calculator, Postman test utils, and Playwright API wrapper; this does not by
  itself establish the scope of their verification or end-to-end checks.
- Releases. The release workflow and a changelog are adopted in `browser-calculator`,
  `postman-test-utils`, and `playwright-api-wrapper`. The other
  feature repositories and the fixtures have neither yet.
- Plugin identifiers. Align the OpenCode plugin ids with the repository names.
- Agent access. Agent access is intent in this catalog, not a ruleset entry. The identity
  is defined in `repo-standard`: the App manifest, the `just create-agent-app` flow, and the
  drift check `check-agent-access`. On 2026-10-15, the live drift check exited 0 for all 17
  repositories in the catalog roster. The check is local and is not part of CI, so run it
  again when rulesets change. Private-key storage remains unverified. Do not infer storage
  from the drift check. The committed `protect-main.json` has no bypass actors, so no level
  grants a push to `main`; `merge` works through the App's repository-scoped token and the
  required checks.

## How open work lands

The standard changes in `repo-standard` first, then roll out to the fleet
through same-repo pull requests on the organization. Each wave ends in a verified state,
checked by each repository's own `standard` job, which runs `check-repo`. A maintainer
may also run the standard's local `audit-fleet` over sibling checkouts. This local audit
does not run in a consuming repository's CI and does not query another repository
through the API.
