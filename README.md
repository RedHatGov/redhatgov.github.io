# RedHatGov.io

[![Build Status](https://travis-ci.org/RedHatGov/redhatgov.github.io.svg?branch=docs)](https://travis-ci.org/RedHatGov/redhatgov.github.io)


----

[RedHatGov.io][redhatgov] is a great open source collection of workshop materials that
cover various topics relating to Red Hat's product portfolio.

----

## Initial start towards developing

If you want to build RedHatGov.io right away:

- You have a working [Hugo environment][hugo] - and *probably* at the correct version.
  - we keep a current working version in the `./bin/` folder
- You have Ruby and the asciidoctor gem installed (*yum install asciidoctor* or *gem install asciidoctor*)

    `$ git clone https://github.com/RedHatGov/redhatgov.github.io`

    `$ cd redhatgov.github.io`

    `$ hugo server`

### Building a working Hugo environment in a container

The following instructions for building a Hugo environment in a container have been tested on Fedora 32 with podman.

Grab the code and deploy the container as an unprivileged user:
```
git clone git@github.com:RedHatGov/redhatgov.github.io.git
cd redhatgov.github.io
podman run --rm -dt  -v $(pwd):/src:Z -p 1313:1313 docker.io/klakegg/hugo:asciidoctor server  --baseURL=http://example.com
```
Note: Please change the base URL to match the FQDN of your container host (example.com used above)

Enable the appropriate firewall port as root:
```
sudo -i
firewall-cmd --zone=FedoraServer --permanent --add-port=1313/tcp
```
Note: Change the firewall zone to what is required/defined on your host.

Access the web site as follows: https://example.com:1313 (replacing example.com with the FQDN of your container host)

## Contributing

If you have content that you'd like to contribute, check out our
[contribution guidelines for this project](CONTRIBUTING.md).

[redhatgov]: http://redhatgov.io/
[hugo]: https://gohugo.io/overview/introduction/
