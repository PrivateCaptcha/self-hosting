# Private Captcha self-hosting

## Legal

Private Captcha is free for non-commercial use (community edition). Commercial use (enterprise edition) is a subject to [EULA](https://privatecaptcha.com/legal/eula/) and requires obtaining a license.

## Quick start

> <mark>**NOTE:** Please visit the [official quickstart docs](https://docs.privatecaptcha.com/docs/deployment/quickstart/) for detailed up-to-date instructions.</mark>

Clone this repository, create your `.env` file based on the example file (check [docs](https://docs.privatecaptcha.com/docs/deployment/configuration/) for all options) and start the stack.

```bash
git clone https://github.com/PrivateCaptcha/self-hosting.git private-captcha
cd private-captcha
cp .env.example .env && $EDITOR .env
docker compose up
```

Now you can open `$PC_PORTAL_BASE_URL` (e.g. `portal.yourdomain.com` or `http://portal.privatecaptcha.local:8080`) in browser and log in.

<details>
<summary><strong>Tips for local use</strong></summary>

To run Private Captcha only locally, use `privatecaptcha.local:8080` instead of `yourdomain.com`. To make it work, you need to add a few lines to `/etc/hosts` file:

```
127.0.0.1       portal.privatecaptcha.local
127.0.0.1       api.privatecaptcha.local
127.0.0.1       cdn.privatecaptcha.local
```

> NOTE: email with `.local` domain is **not** a valid RFC-5322 address, so for 2FA code (required for login) you will need to find "two factor code" from docker logs manually

</details>

## Updating

Please refer to the [official documentation](https://docs.privatecaptcha.com/docs/deployment/updating/) for applying updates.

## Enterprise edition

There are a few changes you will need to make using a `compose.override.yml` file, namely replace `privatecaptcha` image to `privatecaptcha-ee` and set an additional environment variable `EE_LICENSE_KEY` (which you should do in the `.env` file).

```yaml
services:
  privatecaptcha:
    image: ghcr.io/privatecaptcha/privatecaptcha-ee:latest
    environment:
      - EE_LICENSE_KEY=${EE_LICENSE_KEY}
  migration:
    image: ghcr.io/privatecaptcha/privatecaptcha-ee:latest
```
