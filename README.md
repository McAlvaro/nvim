## Neovim configuration

This repository is my personal configuration of neovim using Lua.

## Installation

Once neovim is installed, clone the repository to a directory of your choice.

- Go into the `.config` directory and create a symbolic link from the `nvim` directory to the path `/home/user/.config`
```shell
    ln -s path/nvim .
```
- Open neovim and run the command `:PackerInstall`

## Addtional
To use functions such as search for a string or Find and Replace you need to install `ripgrep` and `gnu-sed`
```Shell
#Mac Os
brew install ripgrep

#Linux
sudo apt-get install ripgrep

```

```Shell
#Mac Os
brew install gnu-sed

```
## Shortcut


| Comando               | Modo     | Acción                                                         |
| --------------------- | -------- | ---------------------------------------------------------------|
| `space`               |          | Leader                                                         |
| `jk`                  | `Insert` | Exit `Insert` Mode                                             |
| `w`                   | `Normal` | Jump to the beginning of the next word                         |
| `b`                   | `Normal` | Realize the inverse function of `w`                            |
| `e`                   | `Normal` | Jump to the end of the next word                               |
| `ge`                  | `Normal` | Realize the inverse function of `e`                            |
| `dw`                  | `Normal` | Delete Word                                                    |
| `x`                   | `Normal` | Delete Character                                               |
| `$`                   | `Normal` | Go to end of line                                              |
| `0`                   | `Normal` | Go to top of line                                              |
| `}`                   | `Normal` | Skips entire paragraphs from top to bottom                     |
| `{`                   | `Normal` | Realize the inverse function of `}`                            |
| `<C-D>`               | `Normal` | Move the file view half a page down                            |
| `<C-U>`               | `Normal` | Move the file view half page up                                |
| `gg`                  | `Normal` | Move the cursor to the beginning of the file                   |
| `{#line}gg`           | `Normal` | Move the cursor to the indicated line                          |
| `{#line}j`            | `Normal` | Move the cursor to the lower relative line number indicated    |
| `{#line}k`            | `Normal` | Move the cursor to the upper relative line number indicated    |
| `G`                   | `Normal` | Move the course to the end of the file                         |
| `{#word}w`            | `Normal` | Move cursor to beginning of word number                        |
| `{#word}e`            | `Normal` | Move cursor to end of word number                              |
| `{#word}y`            | `Normal` | Copy the number of following words                             |
| `y$`                  | `Normal` | Copy to end of line                                            |
| `yw`                  | `Normal` | Copy the current word                                          |
| `d{#word}w`           | `Normal` | Delete the number of following words                           |
| `d{#lines}j`          | `Normal` | Delete the number of lines down                                |
| `d{#lines}k`          | `Normal` | Delete the number of lines up                                  |
| `d`                   | `Normal` | Delete current line                                            |
| `.`                   | `Normal` | Repeat the last change made                                    |
| `da"`                 | `Normal` | Delete something between double quotes                         |
| `o`                   | `Normal` | Inserts a new line below the cursor location                   |
| `O`                   | `Normal` | Inserts a new line above the current line                      |
| `a`                   | `Normal` | Insert cursor after character                                  |
| `A`                   | `Normal` | Insert cursor at end of line                                   |
| `gi`                  | `Normal` | Starts the insertion mode at the last place where you left off |
| `<C-h>`               | `Insert` | Delete the last character typed                                |
| `<C-w>`               | `Insert` | Delete the last word written                                   |
| `<C-u>`               | `Insert` | Delete the last line written                                   |
| `v`                   | `Normal` | Starts the visual mode by character                            |
| `V`                   | `Normal` | Start line-by-line visual mode                                 |
| `u`                   | `Normal` | Undo last change                                               |
| `U`                   | `Normal` | Redo last change                                               |
| `r`                   | `Normal` | Replace the current character                                  |
| `ce`                  | `Normal` | Replace the current word                                       |
| `<Leader>cs`          | `Normal` | Change something between single quotes                         |
| `<Leader>css`         | `Normal` | Change something between double quotes                         |
| `<Leader>dc`          | `Normal` | Delete to end of line                                          |
| `<Leader> q`          | `Normal` | Exit Neovim                                                    |
| `<Leader> w`          | `Normal` | Save Changes                                                   |
| `<Leader> wq`         | `Normal` | Save and exit Neovim                                           |
| `<Leader> <Right>`    | `Normal` | Go to next Tab                                                 |
| `<Leader> <Left>`     | `Normal` | Go to previus Tab                                              |
| `<Leader> 1`          | `Normal` | Go to Tab 1                                                    |
| `<Leader> 2`          | `Normal` | Go to Tab 2                                                    |
| `<Leader> 3`          | `Normal` | Go to Tab 3                                                    |
| `<Leader> 4`          | `Normal` | Go to Tab 4                                                    |
| `<Leader> 5`          | `Normal` | Go to Tab 5                                                    |
| `<Leader> 6`          | `Normal` | Go to Tab 6                                                    |
| `<Leader> 7`          | `Normal` | Go to Tab 7                                                    |
| `<Leader> 8`          | `Normal` | Go to Tab 8                                                    |
| `<Leader> 9`          | `Normal` | Go to Tab 9                                                    |
| `n`                   | `Normal` | Open file explorer                                             |
| `<Leader>n`           | `Normal` | Open file explorer with focus on the open file                 |
| `<Leader>wr`          | `Normal` | Remove whitespace at the end of a line                         |
| `<Leader> r`          | `Normal` | Reload browser                                                 |
| `<Leader> h`          | `Normal` | Move cursor to left buffer                                     |
| `<Leader> l`          | `Normal` | Move cursor to right buffer                                    |
| `<Leader> k`          | `Normal` | Move cursor to Top buffer                                      |
| `<Leader> j`          | `Normal` | Move cursor to bottom buffer                                   |
| `ff`                  | `Normal` | Find files in the Project                                      |
| `<Leader> ss`         | `Normal` | Find a string                                                  |
| `sl`                  | `Normal` | real-time search                                               |
| `<Leader> gs`         | `Normal` | Git status                                                     |
| `<Leader> gc`         | `Normal` | Show commits                                                   |
| `<Leader> gb`         | `Normal` | Show branches                                                  |
| `<Leader> t`          | `Normal` | Open floating terminal                                         |
| `<Leader> cc`         | `Normal` | comment line                                                   |
| `<Leader> uu`         | `Normal` | View change history of a file                                  |
| `<Leader> gd`         | `Normal` | Go to function definition                                      |
| `<Leader> gi`         | `Normal` | Show function information                                      |
| `<Leader> gr`         | `Normal` | Rename function                                                |
| `<Leader> gf`         | `Normal` | Format the file                                                |
| `<Leader> gn`         | `Normal` | Go to next occurrence                                          |
| `<Leader> gp`         | `Normal` | Go to previous occurrence                                      |
| `<Leader> gi`         | `Normal` | Go to implementation                                           |
| `<Leader> gt`         | `Normal` | show definition type                                           |
| `<Leader> m`          | `Normal` | Maximize and minimize buffer                                   |
| `<Leader> aa`         | `Normal` | Add file to harpoon                                            |
| `<Leader> hh`         | `Normal` | show menu harpoon                                              |
| `<Leader> nn`         | `Normal` | Go to next file pinned in harpoon                              |
| `<Leader> pp`         | `Normal` | Go to previous pinned file in harpoon                          |
| `<Leader> qt`         | `Normal` | Exit integrated terminal                                       |
| `<Leader> qtt`        | `Normal` | Exit and close integrated terminal                             |
| `<Leader> yt`         | `Normal` | Open integrated terminal                                       |
| `<Leader> mp`         | `Normal` | View Markdown Preview                                          |
| `<Leader> ms`         | `Normal` | View Markdown Preview Stop                                     |
| `<C-bottom>` `<C-up>` | `Normal` | Multiple cursor                                                |
| `<Leader> sr`         | `Normal` | Open Search and Replace                                        |
| `<Leader> sw`         | `Normal` | Search Select Word                                             |
| `<Leader> qf`         | `Normal` | Send all item to quickfix                                      |
| `<Leader> qs`         | `Normal` | Close Search and Replace                                       |
| `<Leader> <CR>`       | `Normal` | Replace Current Ocurrence                                      |
| `<Leader> sf`         | `Normal` | Search in Current File                                         |
| `<Leader> ee`         | `Normal` | Open .env file                                                 |
| `<C-k>`               | `Normal` | Move current line to Up                                        |
| `<C-j>`               | `Normal` | Move current line to Bottom                                    |
| `<C-k>`               | `Insert` | Move current line to Up                                        |
| `<C-j>`               | `Insert` | Move current line to Bottom                                    |
| `<C-k>`               | `Visual` | Move current line to Up                                        |
| `<C-j>`               | `Visual` | Move current line to Bottom                                    |
| `<Leader>bn`          | `Normal` | Go to next Buffer                                              |
| `<Leader>bb`          | `Normal` | Go to previus Buffer                                           |
| `<Leader>cv`          | `Normal` | Split current buffer in Vertical                               |
| `<Leader>ch`          | `Normal` | Split current buffer in Horizontal                             |
| `<Leader>sx`          | `Normal` | Start/Stop Swagger live preview                                |
| `<Leader>nv`          | `Normal` | Open Navbuddy in current file                                  |
| `<Leader>sa`          | `Normal` | Save as current file with Telescope                            |
| `<Leader>gg`          | `Normal` | Open LazyGit                                                   |
| `<Leader>xx`          | `Normal` | Run current code                                               |
| `<Leader>xf`          | `Normal` | Run current File                                               |
| `<Leader>xt`          | `Normal` | Run current File in new Tab                                    |
| `<Leader>xp`          | `Normal` | Run current Project in new Tab                                 |
| `<Leader>xc`          | `Normal` | Close Run Code Terminal                                        |


