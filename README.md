# Private Captcha self-hosting

## Legal

Private Captcha is free for non-commercial use (community edition). Commercial use (enterprise edition) is a subject to [EULA](https://privatecaptcha.com/legal/eula/) and requires obtaining a license.

## Quick start

> **NOTE:** Please visit the [official quickstart docs](https://docs.privatecaptcha.com/docs/deployment/quickstart/) for up-to-date instructions.

### 1. Clone the repo

```bash
git clone https://github.com/PrivateCaptcha/self-hosting.git private-captcha
cd private-captcha
```

### 2. Create `.env` file

```bash
cp .env.example .env
```

Some notes on environment variables:

- `PC_USER_FINGERPRINT_KEY` you can generate using `openssl rand -hex 64`
- `PC_ADMIN_EMAIL` will be used to create actual admin account (see note for local use below)
- `PC_RATE_LIMIT_HEADER` should be the header containing actual client IP (comes from your CDN or reverse proxy)

You can find full documentation about environment variables [here](https://docs.privatecaptcha.com/docs/deployment/configuration/).

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

### 3. (optional) Expose port

If you want to use use Docker networking directly (which is not recommended) instead of reverse proxy like Nginx or Caddy, you can create a `compose.override.yml` file like this:

```yaml
services:
  privatecaptcha:
    ports:
      - 8080:8080
```

### 4. Done! - navigate to the Portal

Now you can open `$PC_PORTAL_BASE_URL` (e.g. `portal.yourdomain.com`) in browser and log in.

## Advanced configuration

Please refer to the [official documentation](https://docs.privatecaptcha.com) which contains descriptions of all configuration options.

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
