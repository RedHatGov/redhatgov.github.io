#!/usr/bin/env bash

function get_absolute_path() {
 local relative_path="$1"
 local get_absolute_path

 pushd "${relative_path}" >/dev/null
 relative_path="$( pwd )"
 if [[ -h "${relative_path}" ]]; then
  get_absolute_path="$( readlink "${relative_path}" )"
 else
  get_absolute_path="${relative_path}"
 fi
 popd >/dev/null

 echo "${get_absolute_path}"
}

function load_library() {
 local library="$1/hack/lib"; shift || return 1
 local library_files

 # Concatenate library files
 library_files=( $( find "${library}" -type f -name '*.sh' -not -path "*${library}/init.sh" ) )

 # Load libraries into current shell
 for library_file in "${library_files[@]}"; do
  source "${library_file}"
  libstr="${library_file##*\/}"
  # printf "load_library: %s\n" "${libstr%.*}"
 done

 unset library_files library_file
}
