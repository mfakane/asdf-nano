#!/usr/bin/env bash

check_requirements() {
	local missing_deps=()

	for command in \
		"autoconf" \
		"automake" \
		"autopoint" \
		"gcc" \
		"gettext" \
		"git" \
		"groff" \
		"make" \
		"pkg-config"; do
		if ! type $command >& /dev/null; then
			missing_deps+=($command)
		fi
	done

	if [[ ${#missing_deps[*]} -gt 0 ]]; then
		echo "ERROR: missing dependency: ${missing_deps[@]}"
		exit 1
	fi
}

build_nano() {
	local version=$1
	local install_path=${2%/bin}
	local concurrency=$3
    local source_path=$4

	local default_config="--enable-utf8"
	local config="${ASDF_NANO_CONFIG:-${default_config}}"

    echo "Building nano version: $version"
    echo "Source path: $source_path"
    echo "Install path: $install_path"
    echo "Concurrency: $concurrency"

	# running this in subshell
	# we don't want to disturb current working dir
	(
		if ! type "git" &> /dev/null; then
			echo "ERROR: git not found"
			exit 1
		fi
		
		cd "$source_path" || exit 1

        # If the source is acquired from the git repository, we need to generate the configure script.
		[[ -x ./autogen.sh ]] && ./autogen.sh

		if [[ "${version}" =~ ^[0-9]+\.* ]] ; then
			# if version is a release number, remove specific files to prevent showing the git revision as the nano's version.
			rm -rf .git roll-a-release.sh
		fi

		local configure_option="--prefix=${install_path} $config"
		echo "configure option: $configure_option"

		./configure $configure_option || exit 1

		make -j "$concurrency"

        # Check if the build was successful
        if [[ ! -f "$source_path"/src/nano ]]; then
			echo "ERROR: build failed"
			exit 1
		fi

		make install || exit 1
		make clean all
	)
}
