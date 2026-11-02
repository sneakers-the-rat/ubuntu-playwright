# ubuntu-playwright

A Forgejo/act runner image (`ghcr.io/catthehacker/ubuntu:act-24.04`) with the system packages
playwright's firefox needs already installed, so CI jobs can skip `playwright install-deps`.

```
ghcr.io/sneakers-the-rat/ubuntu-playwright:latest
ghcr.io/sneakers-the-rat/ubuntu-playwright:<playwright version>
```

The playwright version comes from [sciop](https://codeberg.org/safeguarding/sciop)'s `pdm.lock`
on `main`. The build checks it daily and builds a new image when the version changes, and also
rebuilds weekly to pick up base image updates.

The browser itself is not included. Jobs should still run `playwright install firefox`, which
downloads the browser build matching their lockfile.

Local build:

```
docker build --build-arg PLAYWRIGHT_VERSION=1.55.0 -t ubuntu-playwright .
```

Build args: `PLAYWRIGHT_VERSION` (required), `BROWSERS` (default `firefox`), `BASE_IMAGE`.
