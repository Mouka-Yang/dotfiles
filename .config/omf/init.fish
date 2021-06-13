#!/usr/bin/env fish

set OMF_CONFIG_INIT "$OMF_CONFIG/init.fish"

if not set -q OMF_PLUGIN_UPDATED
    # download missing plugins or themes only at the first time
    omf install
    omf reload
end
set -Ux OMF_PLUGIN_UPDATED 1

# unset fish greeting message
set -U fish_greeting

# for fish config
alias refish ". $OMF_CONFIG_INIT"
alias vifish "vim $OMF_CONFIG_INIT"
alias cafish "cat $OMF_CONFIG_INIT"
# compatitable with bash
alias unset "set -e"


source $OMF_CONFIG/custom-alias

# enable vi-mode
function fish_user_key_bindings
    fish_default_key_bindings -M insert

    if type fzf_key_bindings 2&>/dev/null
        fzf_key_bindings
    end

    fish_vi_key_bindings --no-erase insert
    set -gx fish_cursor_default block
    set -gx fish_cursor_insert line
    set -gx fish_cursor_replace underscore
end
fish_user_key_bindings

# load .profile use fenv
if type fenv 2&>/dev/null
    fenv source ~/.profile
end

# use nvm
function nvm
    bass source $HOME/.nvm/nvm.sh --no-use ';' nvm $argv
end
