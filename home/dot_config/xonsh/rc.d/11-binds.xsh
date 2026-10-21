if $XONSH_INTERACTIVE:
    from prompt_toolkit.key_binding.key_processor import KeyPressEvent
    from prompt_toolkit.filters import Condition, vi_insert_mode, emacs_insert_mode
    from prompt_toolkit.application.current import get_app
    from xonsh.events import events

    @events.on_ptk_create
    def custom_keybindings(bindings, **kw):
        E = KeyPressEvent

        @Condition
        def suggestion_available() -> bool:
            app = get_app()
            buf = app.current_buffer
            return (
                buf.suggestion is not None
                and len(buf.suggestion.text) > 0
                and buf.document.is_cursor_at_the_end
            )

        insert_mode = vi_insert_mode | emacs_insert_mode

        @bindings.add('c-\\', filter=suggestion_available)
        def _accept_full_suggestion(event: E) -> None:
            b = event.current_buffer
            if b.suggestion:
                b.insert_text(b.suggestion.text)

        @bindings.add('c-p', filter=insert_mode)
        def _prev(event: E) -> None:
            b = event.current_buffer
            if b.complete_state:
                b.complete_previous()
            else:
                b.history_backward()

        @bindings.add('c-n', filter=insert_mode)
        def _next(event: E) -> None:
            b = event.current_buffer
            if b.complete_state:
                b.complete_next()
            else:
                b.history_forward()

        @bindings.add('c-@', filter=insert_mode)
        def _complete(event: E) -> None:
            b = event.current_buffer
            if b.complete_state is None:
                b.start_completion(select_first=False)
