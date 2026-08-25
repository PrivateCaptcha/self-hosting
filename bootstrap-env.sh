#!/usr/bin/env bash

domain="${1:-}"

if [ -n "$domain" ]; then
  portal_base_url="portal.$domain"
  api_base_url="api.$domain"
  cdn_base_url="cdn.$domain"
  admin_email="admin@$domain"
  email_from="no-reply@$domain"
else
  portal_base_url="localhost:8080/portal"
  api_base_url="localhost:8080/api"
  cdn_base_url="localhost:8080/cdn"
  admin_email="admin@privatecaptcha.local"
  email_from="no-reply@privatecaptcha.local"
fi

cat <<EOF
# Required
STAGE=prod
PC_PORTAL_BASE_URL=$portal_base_url
PC_API_BASE_URL=$api_base_url
PC_CDN_BASE_URL=$cdn_base_url
PC_ADMIN_EMAIL=$admin_email
PC_EMAIL_FROM=$email_from
PC_USER_FINGERPRINT_KEY=$(openssl rand -hex 64)
PC_API_SALT=$(openssl rand -hex 64)
PC_XSRF_KEY=$(openssl rand -hex 64)
PC_ID_HASH_SALT=$(openssl rand -hex 64)

# Replace these values with your SMTP provider settings in production.
SMTP_ENDPOINT=localhost:1025
SMTP_USERNAME=
SMTP_PASSWORD=

# Optional
PC_REGISTRATION_ALLOWED=false
PC_VERBOSE=false
# PC_LOCAL_ADDRESS=localhost:9090
# PC_LOCAL_API_KEY=$(openssl rand -hex 64)
# PC_RATE_LIMIT_HEADER=X-Real-Ip
# PC_COUNTRY_CODE_HEADER=CDN-RequestCountryCode
# PC_FINGERPRINT_HEADER=CDN-JA4
EOF
