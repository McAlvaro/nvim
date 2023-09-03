--[[ keys.lua ]]

local map = vim.api.nvim_set_keymap

-- Reasignar la clave utilizada para salir del modo de inserci√≥n
map('i', 'jk', '<Esc>', {})

-- Reasignar

map('n', '<Leader>dc',[[d$]], {})

map('n', '<Leader>css',[[ci"]], {})

map('n', '<Leader>cs',[[ci']], {})

map('n', '<Leader>ci',[[ci(]], {})

-- Select all
map('n', '<C-A>', [[gg<S-v>G]],{})

-- Copy selected
map('v', '<C-c>', [["+y]],{})

-- Command exit nvim
map('n', '<Leader>q', [[:q <CR>]], {} )

map('n', '<Leader>qq', [[:quitall <CR>]], {} )

-- Command save changes
map('n', '<Leader>w', [[:w <CR>]], {})

-- Command save and exit
map('n', '<Leader>wq', '[[:wq <CR>]]', {})

-- Move current line to up
map('n', '<C-k>', [[:m .-2 <CR>==]], {})

-- Move current line to boottom
map('n', '<C-j>', [[:m .+1 <CR>==]], {})

-- Move current line to boottom
map('i', '<C-j>', [[<Esc>:m .+1 <CR>==gi]], {})

-- Move current line to up
map('i', '<C-k>', [[<Esc>:m .-2 <CR>==gi]], {})

-- Move current line to up
map('v', '<C-j>', [[:m '>+1<CR>gv=gv]], {})

-- Move current line to up
map('v', '<C-k>', [[:m '<-2<CR>gv=gv]], {})

-- Navigate to Tabs
-- map('n', '<Leader><Right>', [[gt]], {})

-- map('n', '<Leader><Left>', [[:tabprevious <CR>]], {})

map('n', '<Leader>0', [[:tablast <CR>]], {})

map('n', '<Leader>1', [[1gt]], {})

map('n', '<Leader>2', [[2gt]], {})

map('n', '<Leader>3', [[4gt]], {})

map('n', '<Leader>4', [[4gt]], {})

map('n', '<Leader>5', [[5gt]], {})

map('n', '<Leader>6', [[6gt]], {})

map('n', '<Leader>7', [[7gt]], {})

map('n', '<Leader>8', [[8gt]], {})

map('n', '<Leader>9', [[9gt]], {})


-- Toggle vim-tree
map('n', 'n', [[:NvimTreeToggle]], {})
map('n', '<Leader>r', [[:NvimTreeRefresh <CR>]], {})
map('n', '<Leader>n', [[:NvimTreeFindFile <CR>]], {})

-- vim-tree move to nav files
map('n', '<Leader>h', [[<C-w>h]], {})
map('n', '<Leader>l', [[<C-w>l]], {})

map('n', '<Leader>j', [[<C-w>j]], {})
map('n', '<Leader>k', [[<C-w>k]], {})

-- Telescope
map('n', 'ff', [[:Telescope find_files <CR>]], {})

map('n', '<Leader>gs', [[:Telescope git_status <CR>]], {})          -- Git status

map('n', '<Leader>gc', [[:Telescope git_commits <CR>]], {})          -- Git Commits

map('n', '<Leader>gb', [[:Telescope git_branches <CR>]], {})          -- Git Branches

map('n', '<Leader>ss', [[:lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep for > ") }) <CR>]], {})

map('n', '<Leader>sl', [[ :lua require('telescope.builtin').live_grep() <CR> ]], {})

-- IdentLine
map('n', 'ii', [[:IndentLinesToggle <CR>]], {})

-- Open Float Terminal
map('n', '<Leader>t', [[:FloatermNew <CR>]], {})

-- Hide Terminal
-- map('n', '<Leader>h', [[:FloatermHide <CR>]], {})

-- Comment Line
map('n', '<Leader>cc', [[gcc]], {})

-- Undo History Changes File
map('n', '<Leader>uu', [[:UndotreeToggle <CR>]], {})

-- LSP Keymaps
-- map('n', '<Leader>gd', [[:lua vim.lsp.buf.definition() <CR>]], {})                   --Go Definition
map('n', '<Leader>gd', [[<C-]>]], {})                   --Go Definition

map('n', '<Leader>i', [[:lua vim.lsp.buf.hover() <CR>]], {})                         --Show Info

map('n', '<Leader>gr', [[:lua vim.lsp.buf.rename() <CR>]], {})                       -- Rename

map('n', '<Leader>gf', [[:lua vim.lsp.buf.format{ async = true} <CR>]], {})                   --Fomart

map('n', '<Leader>gn', [[:lua vim.diagnostic.goto_next() <CR>]], {})                 --Next

map('n', '<Leader>gp', [[:lua vim.diagnostic.goto_prev() <CR>]], {})                --Prev

map('n', '<Leader>gi', [[:lua vim.lsp.buf.implementation() <CR>]], {})              --Implementation

map('n', '<Leader>gh', [[:lua vim.lsp.buf.signature_help() <CR>]], {})              --Help

map('n', 'RR', [[:LspRestart <CR>]], {})        --Restart LSP

map('n', '<Leader>gtt', [[:Telescope lsp_type_definitions  <CR>]], {})             --Type Definition

map('n', '<Leader>rf', [[:lua vim.lsp.buf.references() <CR>]], {})                  --References

map('n', '<Leader>m', [[:MaximizerToggle <CR>]], {})                                --MaximizerToggle

-- [[Harpoon Command]]
map('n', '<Leader>aa', [[:lua require("harpoon.mark").add_file() <CR>]], {})        --Add file to harpoon

map('n', '<Leader>hh', [[:lua require("harpoon.ui").toggle_quick_menu() <CR>]], {}) --Show menu harpoon

map('n', '<Leader>nn', [[:lua require("harpoon.ui").nav_next() <CR>]], {})          --Next Harpoon File

map('n', '<Leader>pp', [[:lua require("harpoon.ui").nav_prev() <CR>]], {})          --Prev Harpoon File

map('t', '<Leader>qt', [[<C-\><C-N><CR>]], {})

map('t', '<Leader>qtt', [[<C-\><C-N><CR> :ToggleTerm <CR>]], {})

map('n', '<Leader>yt', [[:ToggleTerm <CR> ]], {})

map('n', '<Leader>mp', [[:MarkdownPreview <CR>]], {})                                        --Markdown Preview

map('n', '<Leader>ms', [[:MarkdownPreviewStop <CR>]], {})                                    --Markdown Preview Stop

-- Spectre keymaps - Search and Replace
map('n', '<Leader>sr', [[:lua require('spectre').open() <CR>]], {})                          -- Open Search and Replace

map('n', '<Leader>sw', [[:lua require('spectre').open_visual({select_word=true}) <CR>]], {}) -- Search Select Word

map('n', '<Leader>qf', [[:lua require('spectre.actions').send_to_qf() <CR>]], {})            -- send all item to quickfix

map('n', '<Leader>qs', [[:q <CR>]], {} )                                                     -- Close Search and Replace

map('n', '<Leader><CR>', [[:lua require('spectre.actions').run_current_replace() <CR>]], {}) -- Replace Current Ocurrence

map('n', '<Leader>sf', [[:lua require('spectre').open_file_search() <CR>]], {})              -- Search in Current File

map('n', '<Leader>jj', [[:set conceallevel=0 <CR>]], {})                                    -- Display quotes in json file

map('n', '<Leader>ji', [[:set conceallevel=1 <CR>]], {})                                    -- Hide the quotes in json file

map('n', '<Leader>wr', [[:%s/\s\+$//e <CR>]], {})                                           -- Remove whitespace at the end of a line

map('n', '<Leader>cx', [[:lua cht() <CR>]], {})                                             -- help from CheatSheet

map('n', '<Leader>ee', [[:vsp .env <CR>]], {})                                              -- Open .env File

map('n', '<Leader>gt', [[:tab Git <CR>]], {})                                               -- Open Git Tab

map('n', '<Leader>db', [[:tab DBUI <CR>]], {})                                              -- Open DBUI Tab

map('n', '<Leader>bn', [[:bn <CR>]], {})                                                    -- Move to Next Buffer

map('n', '<Leader>bb', [[:bp <CR>]], {})                                                    -- Move to Prev Buffer

map('n', '<Leader>cv', [[<C-w>v]], {})                                                      -- Vertical split current buffer

map('n', '<Leader>ch', [[<C-w>s]], {})                                                      -- Horizontal split current buffer

map('n', '<Leader>sx', [[:SwaggerPreviewToggle <CR>]], {})                                  -- Swagger Preview on port: 8000 and stop Preview  

map('n', '<Leader>nv', [[:Navbuddy <CR>]], {})                                              -- Open Navbuddy

map('n', '<Leader>wa', [[:lua SaveAs() <CR>]], {})                                          -- Save as current file

map('n', '<Leader>sa', [[:lua file_browser_relative() <CR>]], {})                           -- Save as current file with Telescope

map('n', '<Leader>gg', [[:LazyGit <CR>]], {})                                               -- Open LazyGit

map('n', '<Leader>xx', [[:RunCode <CR>]], {})                                                -- Run Current Code

map('n', '<Leader>xf', [[:RunFile <CR>]], {})                                               -- Run Current File

map('n', '<Leader>xt', [[:RunFile tab<CR>]], {})                                            -- Run Current File in Tab

map('n', '<Leader>xp', [[:RunProject tab<CR>]], {})                                            -- Run Current File in Tab

map('n', '<Leader>xc', [[:RunClose <CR>]], {})                                              -- Close Run Code


