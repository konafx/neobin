set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
set -g _neobin_config $XDG_CONFIG_HOME/neobin

if test ! -d $_neobin_config
    command mkdir -p $_neobin_config
end

set -g _neobin_cmds_file $_neobin_config/cmds

if test ! -e $_neobin_cmds_file
    touch $_neobin_cmds_file
end
