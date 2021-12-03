autocmd BufRead,BufEnter,BufNewFile Cargo.toml,Cargo.lock,*.rs compiler cargo2
autocmd BufRead,BufEnter,BufNewFile Cargo.toml,Cargo.lock,*.rs setlocal makeprg=cargo
