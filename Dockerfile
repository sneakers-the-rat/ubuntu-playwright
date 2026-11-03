ARG BASE_IMAGE=ghcr.io/catthehacker/ubuntu:act-24.04
FROM ${BASE_IMAGE}

ARG PLAYWRIGHT_VERSION
ARG BROWSERS="firefox"

# Only the apt packages browsers need, not the browsers themselves,
# so projects can still download the browser build matching their own playwright version.
# Uses the python package, so the list of packages comes from the same playwright build
# that python projects run. Ubuntu doesn't allow system-wide pip installs, so it's in a
# temporary venv.
RUN test -n "${PLAYWRIGHT_VERSION}" \
    && python3 -m venv /tmp/playwright \
    && /tmp/playwright/bin/pip install --no-cache-dir "playwright==${PLAYWRIGHT_VERSION}" \
    && /tmp/playwright/bin/playwright install-deps ${BROWSERS} \
    && rm -rf /tmp/playwright /var/lib/apt/lists/*

LABEL org.opencontainers.image.source="https://github.com/sneakers-the-rat/ubuntu-playwright" \
      org.opencontainers.image.description="Forgejo/act runner image with playwright's firefox system deps preinstalled" \
      dev.playwright.version="${PLAYWRIGHT_VERSION}"
