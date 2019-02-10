" Run NeoMake on read and write operations
autocmd! BufReadPost,BufWritePost * Neomake

let g:neomake_error_sign = { 'text': '✖', 'texthl': 'NeomakeErrorSign' }
let g:neomake_warning_sign = { 'text': '⚠', 'texthl': 'NeomakeWarningSign' }
let g:neomake_message_sign = { 'text': '➤', 'texthl': 'NeomakeMessageSign' }
let g:neomake_info_sign = { 'text': 'ℹ', 'texthl': 'NeomakeInfoSign' }

let g:neomake_clojure_enabled_makers = ['check']
