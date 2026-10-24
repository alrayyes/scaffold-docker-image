## Context

release-please decides a release from commit types. Its `exclude-paths` option
could look at files, but the schema doesn't say how.

## Decisions

- Use both levers. `exclude-paths` for the tooling directories it can express,
  a check on the commit type for everything else. Evidence: in
  `src/util/commit-exclude.ts` a file matches a path when
  `file.indexOf(path + '/') === 0`. Run against release-please 17.11.2, which
  release-please-action v5.0.0 uses, a directory skips a commit, while
  `README.md`, `*.md` and `**/*.md` do not, and a commit mixing an excluded
  directory with another file releases.
- The check is the one on the Forgejo scaffolds (`.ci/check-release-type`),
  adapted to this repo's logic paths and run from GitHub Actions.
- `package.json` and `bun.lock` are not logic here: they are dev tooling and
  never enter the image.
