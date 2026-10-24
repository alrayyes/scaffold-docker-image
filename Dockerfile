# Digest-pinned, so a rebuild reproduces what was scanned. Dependabot's Docker
# updater reads this line and raises the pull request when either moves.
FROM alpine:3.24.2@sha256:294b683cb724975bec92580e1e685676bd4b50bda910ddb8c51d4cabeaec77e6

# Replace this with what the image is for. Deliberately unpinned: an apk version
# belongs to the Alpine branch the base is built on, and only the digest above gets
# bumped when the branch moves. The reasoning is in .hadolint.yaml.
RUN apk --no-cache add \
        ca-certificates && \
    addgroup -g 1000 app && \
    adduser -D -u 1000 -G app -h /home/app app

# Non-root, per rules/containers.md. An image built to be a CI job's own
# `container:` is the one exception, because actions/checkout breaks under a
# non-root user; if that is what this becomes, delete the line and say why here.
USER 1000:1000

# No HEALTHCHECK: this image runs nothing long-lived. A service image adds one
# pointed at its readiness endpoint, with --interval, --timeout, --start-period and
# --retries all set.
