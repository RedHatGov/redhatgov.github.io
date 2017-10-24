# RedHatGov.io

[![Build Status](https://travis-ci.org/RedHatGov/redhatgov.github.io.svg?branch=docs)](https://travis-ci.org/RedHatGov/redhatgov.github.io)

--------------------------------------------------------------------------------

[RedHatGov.io][redhatgov] is an open source collection of workshop materials that cover various topics relating to Red Hat's product portfolio.

--------------------------------------------------------------------------------

## Getting Started

To use this project, you'll need (at minimum):

- [Hugo] >=0.20.7

### Install

#### GNU/Linux, or macOS

```sh
#!/bin/bash

git clone https://github.com/RedHatGov/redhatgov.github.io
cd redhatgov.github.io
```

##### No `git`? No problem!

```sh
#!/bin/bash

DIRPATH="${HOME}/Downloads/redhatgov.io"; GITUSER="RedHatGov"
GITREPO="https://github.com/${GITUSER}/redhatgov.github.io/archive/docs.zip"
ARCHIVE="$(printf "%s" "${GITREPO##*/}")"

# Download and extract
wget $GITREPO \
&& temp="$(mktemp -d)" \
&& unzip -d $temp $ARCHIVE \
&& mkdir -p $DIRPATH \
&& mv $temp/*/* $DIRPATH \
&& rm -rf $temp $ARCHIVE \
&& cd $DIRPATH \
&& unset DIRPATH GITUSER GITREPO ARCHIVE temp
```

### Setup

```sh
#!/bin/bash

source hack/init.sh
hugo server
```

## Contributing

If you have content that you'd like to contribute, check out our [contribution guidelines for this project](CONTRIBUTING.md).

[hugo]: https://gohugo.io/overview/introduction/
[redhatgov]: http://redhatgov.io/
