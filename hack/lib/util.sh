#!/usr/bin/env bash

function unarchive-download() {
 local archive=$1
 local targdir=$2; shift 2 || return 1
 local arcname="$(printf "%s" "${archive##*/}")"
 local arctype

 if [[ ! -z "${arcname}" ]]; then
  arctype="$(echo "${arcname}" | egrep -o "tar.gz")"
 fi

 if [[ "${arctype}" == "tar.gz" ]]; then
  wget "${archive}" \
  && mkdir -p "${targdir}" &>/dev/null \
  && tar -xzf "${arcname}" -C "${targdir}" \
  && rm -rf "${arcname}"
 fi
}
