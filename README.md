# Private Captcha self-hosting

## Legal

Private Captcha is free for non-commercial use (community edition). Commercial use (enterprise edition) is a subject to [EULA](https://privatecaptcha.com/legal/eula/) and requires obtaining a license.

## Quick start

> <mark>**NOTE:** Please visit the [official quickstart docs](https://docs.privatecaptcha.com/docs/deployment/quickstart/) for detailed up-to-date instructions.</mark>

Clone this repository, create your `.env` file based on the [example file](./.env.prod.example) or [boostrap](./boostrap-env.sh) script (check [docs](https://docs.privatecaptcha.com/docs/deployment/configuration/) for all options) and start the stack.

```bash
git clone https://github.com/PrivateCaptcha/self-hosting.git private-captcha
cd private-captcha
./bootstrap-env.sh mydomain.com > .env
docker compose up
```

Now you can open `$PC_PORTAL_BASE_URL` (e.g. `portal.mydomain.com`) in browser and log in using admin email (e.g. `admin@mydomain.com`).

<details>
<summary><strong>Local-only use</strong></summary>

To run Private Captcha only locally, don't pass any arguments to the bootstrap script (or use `.env.local.example` instead of `.env.prod.example`). After startup, open `http://localhost:8080/portal` URL in browser and log in with `admin@privatecaptcha.local` email.

> NOTE: email with `.local` domain is **not** a valid RFC-5322 address, so for 2FA code (required for login) cannot be sent and you will need to find "two factor code" from docker logs manually

The difference between prod and local setup is mostly that prod is designed to run on 3 separate subdomains (`api.`, `cdn.` and `portal.`) for flexibility. You can easily emulate this locally too if you add a few lines to `/etc/hosts` file:

```
127.0.0.1       portal.privatecaptcha.local
127.0.0.1       api.privatecaptcha.local
127.0.0.1       cdn.privatecaptcha.local
```

</details>

## Updating

Please refer to the [official documentation](https://docs.privatecaptcha.com/docs/deployment/updating/) for applying updates.

## Licensed use

### Community edition

You need to add an additional environment variable `CE_LICENSE_KEY` via `compose.override.yml` file (which you should put in the `.env` file).

```yaml
services:
  privatecaptcha:
    environment:
      - CE_LICENSE_KEY=${CE_LICENSE_KEY}
```

### Enterprise edition

There are a few changes you will need to make using a `compose.override.yml` file, namely replace `privatecaptcha` image to `privatecaptcha-ee` and set an additional environment variable `EE_LICENSE_KEY` (which you should put in the `.env` file).

```yaml
services:
  privatecaptcha:
    image: ghcr.io/privatecaptcha/privatecaptcha-ee:latest
    environment:
      - EE_LICENSE_KEY=${EE_LICENSE_KEY}
  migration:
    image: ghcr.io/privatecaptcha/privatecaptcha-ee:latest
```
