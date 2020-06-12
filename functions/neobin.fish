function _neobin_error_handler -a error -d "error handler"
    switch "$error"
        case not_exist
            echo "Neo Commands file is not exist"
        case not_set_cmds_file_variable
            echo "Var: _neobin_cmds_file is not set"
        case not_installed_cmd
            echo "$argv is not installed"
    end
    exit 1
end

function _neobin_help -d "help"
    echo "Hello neobin"
end

function _neobin_add -d "add neo-command" -a src dst
    echo "$src $dst" >> $_neobin_cmds_file
end

function _neobin_remove -d "remove neo-command" -a query
    command -qs fzf; and set -l FILTER fzf
    command -qs peco; and set -l FILTER peco

    set -q FILTER
    and set -l delete_query (command grep $query $_neobin_cmds_file | $FILTER)
    or set -l delete_query $query

    command sed -i "/\b$delete_query\b/d" $_neobin_cmds_file
end

function _neobin_list -d "list neo-command"
    cat $_neobin_cmds_file
end

function _neobin_init -d "neobin"
    while read -la cmds
        # ignore comment
        string match -q -r '^#.*' $cmds; and continue

        set -l src $cmds[1]
        set -l dst $cmds[2]
        echo $src' -> '$dst
    end < $_neobin_cmds_file
end

function neobin -d "neobin command"
    set -q _neobin_cmds_file; or _neobin_error_handler not_set_cmds_file_variable
    test ! -e $_neobin_cmds_file; and _neobin_error_handler not_exist

    set -l subcommand $argv[1]
    set -e argv[1]

    switch "$subcommand"
        case init
            _neobin_init
        case list
            _neobin_list
        case add
            _neobin_add $argv
        case remove
            _neobin_remove $argv
        case '*'
            _neobin_help
    end
end
