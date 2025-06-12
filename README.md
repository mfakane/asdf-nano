# asdf-nano [![GitHub Actions Status](https://github.com/mfakane/asdf-nano/actions/workflows/build.yml/badge.svg?branch=master)](https://github.com/mfakane/asdf-nano/actions)

[GNU nano](https://www.nano-editor.org/) plugin for [asdf](https://github.com/asdf-vm/asdf) version manager.

Forked from [tsuyoshicho/asdf-vim](https://github.com/tsuyoshicho/asdf-vim).

## Usage

### Install

The plugin can be install using the following command.

```sh
asdf plugin add nano
# or asdf plugin add nano https://github.com/mfakane/asdf-nano.git
asdf install nano <version>
```

### Installation Variable

- `ASDF_NANO_CONFIG`: nano configuration arguments. See [install](bin/install) for default configurations.

### .tool-versions file

You can specify the version to install with a line like so in your .tool-versions file:
`nano <version>`

### Using the CLI

You can then set the local/global version to your new version with `asdf set <version>` or `asdf set -u nano <version>`.

## Use

Check [asdf](https://github.com/asdf-vm/asdf) readme for instructions on how to install & manage versions of GNU nano.
