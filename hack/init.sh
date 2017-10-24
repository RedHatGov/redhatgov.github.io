#!/usr/bin/env bash

# This script is meant to be the entrypoint for Bash scripts to import all of the support
# libraries at once in order to make Bash script preambles as minimal as possible. This script recur-
# sively `source`s *.sh files in this dirs tree. As such, no files should be `source`ed outside
# of this script to ensure that we do not attempt to overwrite read-only variables.

# Stop script on NZEC
set -e

# Stop script if unbound variable found (use ${var:-} if intentional)
set -u

# By default cmd1 | cmd2 returns exit code of cmd2 regardless of cmd1 success
# this is causing it to fail
set -o pipefail

# Checks if command in hash table exists before executing it
shopt -s checkhash

INSTALL_DOC="https://gohugo.io/getting-started/installing#step-2-download-the-tarball"
SCRIPT_NAME=$(basename "$0")
HUGO_BINARY=${HUGO_BINARY:-"hugo"}
HUGO_SEMVER="0.29"
__PLATFORM="unknown"
__MACHBITS="unknown"
__BASHPROF="unknown"
__UNAMESTR="$(uname)"
__MACHARCH="$(uname -m)"

# Verify supported system
if [[ "$__UNAMESTR" == "Linux" ]]; then
 __PLATFORM="Linux"
 __BASHPROF=".bashrc"
elif [[ "$__UNAMESTR" == "Darwin" ]]; then
 __PLATFORM="macOS"
 __BASHPROF=".bash_profile"
fi

if [[ "${__PLATFORM}" == "unknown" || "${__BASHPROF}" == "unknown" ]]; then
 echo "Unknown platform: script should exit" && exit 1
fi

if [[ "${__MACHARCH}" == "x86_64" ]]; then
 __MACHBITS="64bit"
fi

if [[ "$__MACHBITS" == "unknown" ]]; then
 echo "Unsupported architecture: stoping script" && exit 1
fi

# Resolve $SOURCE until the file is no longer a symlink
SOURCE="`test -L ${BASH_SOURCE[0]} \
&& readlink ${BASH_SOURCE[0]} \
|| echo ${BASH_SOURCE[0]}`"

while [ -h "$SOURCE" ]; do
 DIRPATH="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
 SOURCE="$(readlink "$SOURCE")"

 # If $SOURCE was a relative symlink, we need to resolve it relative to the path
 # where the symlink file was located.
 [[ $SOURCE != /* ]] && SOURCE="$DIRPATH/$SOURCE"
done

DIRPATH="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

source "$DIRPATH/lib/common.sh"

ABSPATH="$(get_absolute_path "$DIRPATH/..")"
PROJECT="${PROJECT:-"${ABSPATH}"}"
PROJECT_NAME="${PROJECT_NAME:-"${PROJECT##*/}"}"

# Helpers
load_library "${PROJECT:-"${ABSPATH}"}"

# Check if hugo exists, if not install locally
if ! hash hugo 2>/dev/null; then
 HUGO_GIT_USER="gohugoio"; HUGO_GIT_PROJ="hugo"; HUGO_GIT_VERS="${HUGO_SEMVER:-"0.20.7"}"
 HUGO_GIT_URIS="https://github.com/${HUGO_GIT_USER}/${HUGO_GIT_PROJ}/releases/download/v${HUGO_GIT_VERS}"
 HUGO_GIT_ARCS="${HUGO_GIT_PROJ}_${HUGO_GIT_VERS}_${__PLATFORM}-${__MACHBITS}.tar.gz"
 HUGO_GIT_RELS=${HUGO_GIT_RELS:-"${HUGO_GIT_URIS}/${HUGO_GIT_ARCS}"}
 HUGO_BIN_PATH="${PROJECT:-"${ABSPATH}"}/bin"
 HUGO_BIN_FILE="${HUGO_BIN_PATH}/${HUGO_BINARY}"
 HUGO_BIN_SYML="${HOME}/.local/bin/${HUGO_BINARY}"

 # Download and unpack release archive
 if [[ ! -f "${HUGO_BIN_FILE}" ]]; then
  unarchive-download "${HUGO_GIT_RELS}" "${HUGO_BIN_PATH}"
 fi

 # Create symbolic link to binary file
 ln -sf "${HUGO_BIN_FILE}" "${HUGO_BIN_SYML}"

 # Reload session
 source "${HOME}/${__BASHPROF}"
fi

if ! hash pip 2>/dev/null; then
 temp=$(mktemp -d) \
 && pushd ${temp} \
 && wget https://bootstrap.pypa.io/get-pip.py \
 && python get-pip.py --user \
 && popd && rm -rf ${temp}
fi

pip install -q -U --user pip Pygments
gem install -q --conservative --user-install asciidoctor
