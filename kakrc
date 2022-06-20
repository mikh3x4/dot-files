
evaluate-commands %sh{
        plugins="$kak_config/plugins"
            mkdir -p "$plugins"
                [ ! -e "$plugins/plug.kak" ] && \
                        git clone -q https://github.com/andreyorst/plug.kak.git "$plugins/plug.kak"
                            printf "%s\n" "source '$plugins/plug.kak/rc/plug.kak'"
}

plug "andreyorst/plug.kak" noload

plug "danr/kakoune-easymotion"
map global normal <space> :easy-motion-w<ret>

plug "andreyorst/fzf.kak"
map global normal <c-p> ': fzf-mode<ret>'


#set-option global fzf_terminal_command 'terminal kak -c %val{session} -e "%arg{@}"'

plug 'NNBnh/clipb.kak' config %{
    clipb-detect
    clipb-enable
}

colorscheme solarized-dark

hook global InsertChar k %{ try %{
    exec -draft hH <a-k>jk<ret> d
    exec <esc>
}}

map global normal <ret> <a-i>w*

hook global InsertCompletionShow .* %{
    try %{
        # this command temporarily removes cursors preceded by whitespace;
        # if there are no cursors left, it raises an error, does not
        # continue to execute the mapping commands, and the error is eaten
        # by the `try` command so no warning appears.
        execute-keys -draft 'h<a-K>\h<ret>'
        map window insert <tab> <c-n>
        map window insert <s-tab> <c-p>
        hook -once -always window InsertCompletionHide .* %{
            unmap window insert <tab> <c-n>
            unmap window insert <s-tab> <c-p>
        }
    }
}

plug "kkga/ui.kak"

hook global WinCreate .* %{
    ui-line-numbers-toggle
    ui-matching-toggle
    ui-search-toggle
    ui-todos-toggle
    oui-cursorline-toggle
}

