## Why

A docs-only commit typed `fix:` cuts an image release, because release-please
reads the commit type and nothing else. A release should mean the image changed
(https://github.com/alrayyes/scaffold-docker-image/issues/4).

## What Changes

- A `feat:`, `fix:` or `perf:` commit, and a pull request title of that type,
  must touch a logic path (`Dockerfile`, `.dockerignore`). A check enforces it
  in the commit-msg hook, in CI on the commits and in CI on the pull request
  title.
- release-please skips a commit that touches only `.github/`, `.claude/`,
  `openspec/`, `scripts/` or `styles/`. `exclude-paths` takes directory
  prefixes only, so root files such as `README.md` rely on the commit type.

## Capabilities

### New Capabilities

- `release`: when a change releases.

### Modified Capabilities

None.

## Impact

`.ci/`, `lefthook.yml`, `.github/workflows/`, `release-please-config.json`,
`CONTRIBUTING.md`, `README.md`.

## Sources

- https://github.com/googleapis/release-please/blob/main/schemas/config.json
- https://github.com/googleapis/release-please/blob/main/src/util/commit-exclude.ts
