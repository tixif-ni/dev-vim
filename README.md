vim-radyz
=========

## Install

1. Symlink .vimrc to $HOME/.vimrc
2. Install [vim-plug](https://github.com/junegunn/vim-plug)
3. Symlink $HOME/.vim/colors/hybrid/colors/hybrid.vim to $HOME/.vim/colors/hybrid.vim
4. If planning to use [ctags](http://ctags.sourceforge.net) follow its instructions
5. If planning to use [virtualenvwrapper](http://virtualenvwrapper.readthedocs.org/en/latest/) follow its instructions

## Key mappings

The local leader is `\`.

### SQL

Queries run through [vim-dadbod](https://github.com/tpope/vim-dadbod) and
[vim-dadbod-wrapper](https://github.com/radyz/vim-dadbod-wrapper). Connections
come from `DADBOD_<NAME>` environment variables, or from the keychain with
`:DBLoadSecret <label>`.

In `.sql` buffers:

| Key  | Mode   | Action                                                        |
| ---- | ------ | ------------------------------------------------------------- |
| `\r` | normal | Pick a connection and run the query under the cursor          |
| `\r` | visual | Pick a connection and run the selected lines                  |
| `\c` | normal | Pick the connection used for completion, without running      |

In the query result window:

| Key        | Action                                   |
| ---------- | ---------------------------------------- |
| `\<space>` | Preview the row under the cursor         |

Commands:

| Command              | Action                                                  |
| -------------------- | ------------------------------------------------------- |
| `:DBExec <name>`     | Run the whole buffer, or a line range, on a connection  |
| `:DBUse [name]`      | Point completion at a connection; no name opens a picker |
| `:DBLoadSecret <label>` | Load connections from the keychain for this session  |
| `:DBCompletionClearCache` | Refetch the schema after tables or columns change  |

Completion follows the last connection a query ran on in that buffer, and
starts on `local`.

### C# tests

Tests run through [neotest](https://github.com/nvim-neotest/neotest) with the
[neotest-vstest](https://github.com/nsidorenco/neotest-vstest) adapter. These
work in C# buffers:

| Key   | Action                                                  |
| ----- | ------------------------------------------------------- |
| `\tm` | Run the nearest test; on a class line, the whole class  |
| `\ta` | Run all tests in the file                               |
| `\tp` | Run everything under the current working directory      |
| `\tl` | Re-run the last run                                     |
| `\tx` | Stop a run                                              |
| `\to` | Show the output of the test under the cursor            |
| `\ts` | Toggle the summary tree                                 |

Stopping kills the test host, so the stopped test shows as failed and its
teardown does not run.

The summary tree and `\tp` only cover test files you have opened. The test
runner processes are shut down a minute after the last run and start again on
the next one.

Inside the summary tree:

| Key           | Action                                          |
| ------------- | ----------------------------------------------- |
| `i`           | Jump to the test, class or file                 |
| `<CR>`        | Expand or collapse the node                     |
| `e`           | Expand everything under the node                |
| `r`           | Run the node under the cursor                   |
| `u`           | Stop it                                         |
| `o`           | Show the full output for that test              |
| `O`           | Show the short output (the failure message)     |
| `J` / `K`     | Jump to the next / previous failed test         |
| `m`, then `R` | Mark several tests, then run the marked ones    |
| `w`           | Watch: re-run when the files change             |
| `?`           | Show the full list of mappings                  |
