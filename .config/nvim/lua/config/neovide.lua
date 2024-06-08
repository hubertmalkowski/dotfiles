if vim.g.neovide then
    vim.g.neovide_cursor_animation_length = 0.08
    vim.g.neovide_cursor_trail_size = 0.1
    vim.o.guifont = "JetBrainsMonoNL Nerd Font:h15"

    vim.g.neovide_padding_left = 8
    vim.g.neovide_padding_right = 8
    vim.g.neovide_padding_top = 8
    vim.g.neovide_padding_bottom = 8
    vim.g.neovide_floating_shadow = false

    vim.g.neovide_floating_blur_amount_x = 5.0
    vim.g.neovide_floating_blur_amount_y = 5.0

    -- vim.g.neovide_show_border = false
    vim.g.neovide_transparency = 1
    vim.g.transparency = 1

    vim.cmd [[
    " system clipboard
      nmap <c-c> "+y
      vmap <c-c> "+y
      nmap <c-V> "+p
      inoremap <c-V> <c-r>+
      cnoremap <c-V> <c-r>+
      " use <c-r> to insert original character without triggering things like auto-pairs
      inoremap <c-r> <c-V>
    ]]
end
