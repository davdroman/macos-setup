#!/usr/bin/env bash

SCRIPT_PATH=$(dirname "$(realpath -s "$0")")

"$SCRIPT_PATH/install_cli_tools.sh"
"$SCRIPT_PATH/install_apps.sh"
"$SCRIPT_PATH/install_ql_plugins.sh"
"$SCRIPT_PATH/install_fonts.sh"
"$SCRIPT_PATH/set_defaults.sh"
