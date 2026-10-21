if $XONSH_INTERACTIVE:
    from xonsh.built_ins import XSH

    XSH.env['fzf_history_binding'] = "c-r"
    XSH.env['fzf_ssh_binding'] = "c-s"
    XSH.env['fzf_file_binding'] = "c-t"
    XSH.env['fzf_dir_binding'] = "c-g"

    xontrib load fzf-completions

    execx($(zoxide init xonsh), 'exec', __xonsh__.ctx, filename='zoxide')
    execx($(atuin init xonsh --disable-ctrl-r --disable-ai))
