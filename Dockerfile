ARG BASE_IMAGE=ghcr.io/catthehacker/ubuntu:act-24.04
FROM ${BASE_IMAGE}

ARG PLAYWRIGHT_VERSION
ARG BROWSERS="firefox"

# Only the apt packages browsers need, not the browsers themselves,
# so projects can still download the browser build matching their own playwright version.
RUN test -n "${PLAYWRIGHT_VERSION}" \
    && npx -y "playwright@${PLAYWRIGHT_VERSION}" install-deps ${BROWSERS} \
    && npm cache clean --force \
    && rm -rf /var/lib/apt/lists/*

LABEL org.opencontainers.image.source="https://github.com/sneakers-the-rat/ubuntu-playwright" \
      org.opencontainers.image.description="Forgejo/act runner image with playwright's firefox system deps preinstalled" \
      dev.playwright.version="${PLAYWRIGHT_VERSION}"
