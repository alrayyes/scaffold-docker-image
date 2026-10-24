## ADDED Requirements

### Requirement: Only logic changes release

A change SHALL cut a release only when it changes what the image ships. Logic
paths are the `Dockerfile` and `.dockerignore`, plus any file the `Dockerfile`
copies in. Prose, tests, CI and hook config, linter config, `styles/`,
`scripts/`, `openspec/` and `.claude/` are not logic paths.

#### Scenario: Docs-only fix is refused

- **WHEN** a commit or pull request title is typed `feat:`, `fix:` or `perf:`
  and the change touches no logic path
- **THEN** the release-type check fails and names `docs:`, `test:`, `ci:`,
  `build:` and `chore:` as the types to use

#### Scenario: Logic change is accepted

- **WHEN** a `fix:` change touches the `Dockerfile`
- **THEN** the release-type check passes

#### Scenario: Non-releasing types pass anywhere

- **WHEN** a `docs:`, `ci:` or `chore:` commit touches any path
- **THEN** the release-type check passes

#### Scenario: Squash merge lands the title

- **WHEN** a pull request is opened or its title edited
- **THEN** the title is checked against every file the pull request changes

#### Scenario: Tooling directories never release

- **WHEN** a commit touches only `.github/`, `.claude/`, `openspec/`,
  `scripts/` or `styles/`
- **THEN** release-please skips it, whatever its type
