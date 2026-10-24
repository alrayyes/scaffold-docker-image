# scaffold-docker-image

[![CI](https://github.com/alrayyes/scaffold-docker-image/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/alrayyes/scaffold-docker-image/actions/workflows/ci.yml)
[![licence](https://img.shields.io/badge/licence-GPL--3.0--or--later-blue)](LICENSE)

A template for a Docker image published to `ghcr.io`. Click "Use this template",
or clone it, and replace the Dockerfile with the image you mean to ship.

## What you get

- An Alpine `Dockerfile` on a digest-pinned base, running as a non-root user.
- hadolint and a plain `docker build` in the hooks and in CI, plus a smoke test
  that runs the built image.
- release-please cutting the version from Conventional Commits, then building
  the image, pushing it to `ghcr.io` and attesting its provenance.
- Dependabot for the base image, the dev tooling and the workflows, with
  auto-merge for its pull requests.
- Prose and style linting (Prettier, markdownlint, LTeX, Vale), commitlint
  and a dependency-advisory scan.
- OpenSpec, issue and pull request templates, `SECURITY.md` and
  `CONTRIBUTING.md`.

## Requirements

[bun](https://bun.sh) (the version in `.bun-version`) for the tooling, and
Docker to build the image and run hadolint. See [CONTRIBUTING.md](CONTRIBUTING.md).

## Using it

1. Create the repository from this template.
2. Search for `scaffold-docker-image` and replace it with the new name: in
   `package.json`, `bun.lock`, the badges here, `SECURITY.md`,
   `CODE_OF_CONDUCT.md` and the `ci.yml` build step.
3. Replace the `Dockerfile`, then the smoke test in `ci.yml` and this README.
4. Push a `0.1.0` tag on the first commit `main` can reach. Without a baseline
   tag, release-please's first release is `1.0.0` whatever the commits say.
5. Add the `RELEASE_TOKEN` secret, turn on branch protection, and mark the
   package public once it exists.

## Releasing

Nobody picks a version. release-please reads the Conventional Commits that land
on `main` and keeps a release pull request open carrying the next version and
the changelog entry. Merging it tags the release, and the same run builds the
image, pushes it and attests it. Tags are bare semver, `0.2.0` and not `v0.2.0`.

A base image bump raises `fix(deps):` on purpose. A patched Alpine has to cut a
release, or the fix never becomes an image anyone pulls.

Verify where an image came from:

```sh
gh attestation verify oci://ghcr.io/alrayyes/scaffold-docker-image:latest --repo alrayyes/scaffold-docker-image
```

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). Security reports go through
[SECURITY.md](SECURITY.md), not the issue tracker.

## Licence

GPL-3.0-or-later. See [LICENSE](LICENSE).
