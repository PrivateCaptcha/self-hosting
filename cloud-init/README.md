# Cloud-init config for Private Captcha

> This is a "starter pack". Do **not** treat it as a production-ready setup.

## Deployment

You can edit the supplied `userdata` file (which is a [cloud-init](https://cloud-init.io/) template) to set some required environment variables and then you can use it to deploy to your favorite VPS (all of them support cloud-init). This template will deploy this Docker-based setup to the server. 4GB RAM and 2 vCPU should be enough to get going.

## Local testing

If you'd like to, you can _optionally_ test this setup in [Vagrant](https://developer.hashicorp.com/vagrant) locally using a supplied Vagrantfile: just run `./create_local_userdata.sh && vagrant up` in this directory (you'd need to add `/etc/hosts` entries for `{portal,api,cdn}.privatecaptcha-vagrant.local` to see portal in browser.
