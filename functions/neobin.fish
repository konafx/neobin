function _neobin_help -d "help"
    echo "Hello neobin"
end

function _neobin_add -d "add neobin command" -a src dst
    set -q $_neobin_cmds_file; or echo "commands file is not set"; return

    echo "$src $dst" >> $_neobin_cmds_file
end

function _neobin_remove -d "remove neobin command" -a query
    set -q $_neobin_cmds_file; or echo "commands file is not set"; return

    set -l delete_query (grep $query $_neobin_cmds_file | fzf)
    sed -i "/\b\$delete_query\b/d" $_neobin_cmds_file
end

function _neobin_init -d "neobin"
    set -q $_neobin_cmds_file; or echo "commands file is not set";  return
    test ! -e $_neobin_cmds_file

    while read -la cmds
        # ignore comment
        string match -q -r '^#.*' $cmds; and continue

        set -l src $cmds[1]
        set -l dst $cmds[2]
        echo $src' -> '$dst
    end < $_neobin_cmds_file
end

function neobin -d "neobin"
    set -l subcommand $argv[1]
    set -e subcommand $argv[1]

    switch "$subcommand"
        case init
            _neobin_init $argv
        case add
            _neobin_add $argv
        case remove
            _neobin_remove $argv
        case '*'
            _neobin_help
    end
end

