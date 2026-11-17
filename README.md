# scaffold-docker-image

[![CI](https://github.com/alrayyes/scaffold-docker-image/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/alrayyes/scaffold-docker-image/actions/workflows/ci.yml)
[![licence](https://img.shields.io/badge/licence-GPL--3.0--or--later-blue)](LICENSE)

A template for a Docker image published to `ghcr.io`. Click "Use this template",
or clone it, and replace the Dockerfile with the image you mean to ship.

## What you get

- An Alpine `Dockerfile` on a digest-pinned base, running as a non-root user.
- hadolint and a plain `docker build` in the hooks and in CI, plus a smoke test
  that runs the built image. A weekly scheduled build repeats both, so a base
  image or package index change that breaks the build shows up within a week.
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
   `CODE_OF_CONDUCT.md` and the build action in
   `.github/actions/build-and-smoke/`.
3. Replace the `Dockerfile`, then the smoke test in
   `.github/actions/build-and-smoke/action.yml` and this README.
4. Push a `0.1.0` tag on the first commit `main` can reach. Without a baseline
   tag, release-please's first release is `1.0.0` whatever the commits say.
5. Add the `RELEASE_TOKEN` secret, turn on branch protection, allow
   auto-merge, allow squash merging only, and mark the package public once it
   exists.

## Running the image

This repo ships an image and owns no run command, so whoever runs it sets these:

```sh
docker run --rm \
  --cap-drop=ALL \
  --security-opt=no-new-privileges \
  --read-only \
  --memory=256m --cpus=1 \
  ghcr.io/alrayyes/scaffold-docker-image:latest
```

Add `--cap-add` for a capability the image genuinely needs, and a `--tmpfs`
mount for any path it must write. Raise the limits to fit.

## Releasing

Nobody picks a version. release-please reads the Conventional Commits that land
on `main` and keeps a release pull request open carrying the next version and
the changelog entry. Merging it tags the release, and the same run builds the
image, pushes it and attests it. Tags are bare semver, `0.2.0` and not `v0.2.0`.

Only a change to what the image ships releases: a `feat:`, `fix:` or `perf:`
commit has to touch the `Dockerfile` or another logic path, and a check on the
commit and the pull request title fails otherwise. See
[CONTRIBUTING.md](CONTRIBUTING.md).

A base image bump raises `fix(deps):` on purpose. A patched Alpine has to cut a
release, or the fix never becomes an image anyone pulls.

Verify where an image came from:

```sh
gh attestation verify oci://ghcr.io/alrayyes/scaffold-docker-image:latest --repo alrayyes/scaffold-docker-image
```

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). Security reports go through
[SECURITY.md](SECURITY.md), not the issue tracker.

## Actions event policy

The workflows here use `pull_request_target`. GitHub's default Actions policy
blocks that event on public repositories, and enforcement starts on 2026-12-02
for repositories relying on the default. A public repository made from this
template needs its own policy allowing the events its workflows use, or those
workflows end in `startup_failure`:

```sh
gh api -X POST repos/<owner>/<repo>/actions/policies --input - <<'JSON'
{"name":"allow-pull_request_target","enforcement":"active",
 "rules":[{"type":"restrict_action_events",
           "parameters":{"allowed_events":["pull_request_target","pull_request","push","schedule","workflow_dispatch"]}}]}
JSON
```

`allowed_events` is an allow-list, so any event left out stops firing. Trim or
extend the example to match the `on:` of the repository's own workflows. Changing
an existing policy through the API (`PUT`) returned 404 for the owner's token, so
edit it in the UI under Settings > Actions > Policies. See the
[GitHub docs](https://docs.github.com/en/actions/reference/security/securely-using-pull_request_target).

## Licence

GPL-3.0-or-later. See [LICENSE](LICENSE).
