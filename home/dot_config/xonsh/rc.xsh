if $XONSH_INTERACTIVE:
    if 'FISH__BIND_MODE' in __xonsh__.env:
        del __xonsh__.env['FISH__BIND_MODE']

    $VI_MODE = True
