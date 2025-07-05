# Hướng dẫn phím tắt Neovim

> **Leader Key**: `Space` (` `)

## 📚 Mục lục

-  [Cơ bản](#cơ-bản)
-  [Di chuyển và Chỉnh sửa](#di-chuyển-và-chỉnh-sửa)
-  [LSP (Language Server Protocol)](#lsp-language-server-protocol)
-  [Tìm kiếm Files (FZF)](#tìm-kiếm-files-fzf)
-  [Quản lý Files (Oil)](#quản-lý-files-oil)
-  [Git Operations](#git-operations)
-  [Terminal](#terminal)
-  [Testing (Neotest)](#testing-neotest)
-  [Debugging](#debugging)
-  [Autocompletion](#autocompletion)
-  [AI/LLM](#aillm)
-  [Java Development](#java-development)
-  [Text Manipulation](#text-manipulation)
-  [Utilities](#utilities)

---

## Cơ bản

### Diagnostics & Error Navigation

| Phím tắt     | Chế độ | Mô tả                                             |
| ------------ | ------ | ------------------------------------------------- |
| `<leader>e`  | Normal | Mở floating window hiển thị diagnostic tại cursor |
| `<leader>ne` | Normal | Đi đến lỗi tiếp theo                              |
| `<leader>pe` | Normal | Đi đến lỗi trước đó                               |
| `<leader>ce` | Normal | Copy message diagnostic vào clipboard             |

### Copy & File Operations

| Phím tắt     | Chế độ | Mô tả                                      |
| ------------ | ------ | ------------------------------------------ |
| `<leader>cp` | Normal | Copy đường dẫn tuyệt đối của file hiện tại |
| `<leader>ob` | Normal | Mở file hiện tại trong browser             |

---

## Di chuyển và Chỉnh sửa

### Copy, Cut, Paste Operations

| Phím tắt     | Chế độ | Mô tả                                          |
| ------------ | ------ | ---------------------------------------------- |
| `yy`         | Normal | Copy (yank) toàn bộ dòng hiện tại              |
| `y`          | Visual | Copy (yank) text được chọn                     |
| `yw`         | Normal | Copy word từ cursor                            |
| `y$`         | Normal | Copy từ cursor đến cuối dòng                   |
| `y0`         | Normal | Copy từ đầu dòng đến cursor                    |
| `yG`         | Normal | Copy từ cursor đến cuối file                   |
| `gg` `y` `G` | Normal | Copy toàn bộ file                              |
| `dd`         | Normal | Cut (delete) toàn bộ dòng hiện tại             |
| `d`          | Visual | Cut (delete) text được chọn                    |
| `dw`         | Normal | Cut word từ cursor                             |
| `d$` / `D`   | Normal | Cut từ cursor đến cuối dòng                    |
| `d0`         | Normal | Cut từ đầu dòng đến cursor                     |
| `dG`         | Normal | Cut từ cursor đến cuối file                    |
| `p`          | Normal | Paste sau cursor/dòng hiện tại                 |
| `P`          | Normal | Paste trước cursor/dòng hiện tại               |
| `gp`         | Normal | Paste và để cursor ở cuối text vừa paste       |
| `gP`         | Normal | Paste trước và để cursor ở cuối text vừa paste |

### Undo & Redo

| Phím tắt | Chế độ | Mô tả                                   |
| -------- | ------ | --------------------------------------- |
| `u`      | Normal | Undo thay đổi trước đó                  |
| `Ctrl+r` | Normal | Redo thay đổi đã undo                   |
| `U`      | Normal | Undo tất cả thay đổi trên dòng hiện tại |

### Selection & Visual Mode

| Phím tắt    | Chế độ          | Mô tả                                           |
| ----------- | --------------- | ----------------------------------------------- |
| `v`         | Normal          | Vào Visual mode (character-wise)                |
| `V`         | Normal          | Vào Visual Line mode                            |
| `Ctrl+v`    | Normal          | Vào Visual Block mode                           |
| `gv`        | Normal          | Re-select vùng text được chọn trước đó          |
| `o`         | Visual          | Di chuyển đến đầu/cuối của selection            |
| `aw`        | Visual/Operator | Select "a word" (bao gồm spaces)                |
| `iw`        | Visual/Operator | Select "inner word" (không bao gồm spaces)      |
| `as`        | Visual/Operator | Select "a sentence"                             |
| `is`        | Visual/Operator | Select "inner sentence"                         |
| `ap`        | Visual/Operator | Select "a paragraph"                            |
| `ip`        | Visual/Operator | Select "inner paragraph"                        |
| `a"`        | Visual/Operator | Select text trong quotes (bao gồm quotes)       |
| `i"`        | Visual/Operator | Select text trong quotes (không bao gồm quotes) |
| `a'`        | Visual/Operator | Select text trong single quotes                 |
| `i'`        | Visual/Operator | Select text trong single quotes (inner)         |
| `a)` / `ab` | Visual/Operator | Select text trong parentheses                   |
| `i)` / `ib` | Visual/Operator | Select text trong parentheses (inner)           |
| `a]`        | Visual/Operator | Select text trong square brackets               |
| `i]`        | Visual/Operator | Select text trong square brackets (inner)       |
| `a}` / `aB` | Visual/Operator | Select text trong curly braces                  |
| `i}` / `iB` | Visual/Operator | Select text trong curly braces (inner)          |
| `at`        | Visual/Operator | Select HTML/XML tag                             |
| `it`        | Visual/Operator | Select inner HTML/XML tag                       |

### Find & Replace

| Phím tắt  | Chế độ | Mô tả                                   |
| --------- | ------ | --------------------------------------- |
| `/`       | Normal | Tìm kiếm forward                        |
| `?`       | Normal | Tìm kiếm backward                       |
| `n`       | Normal | Đi đến match tiếp theo                  |
| `N`       | Normal | Đi đến match trước đó                   |
| `*`       | Normal | Tìm word dưới cursor (forward)          |
| `#`       | Normal | Tìm word dưới cursor (backward)         |
| `f{char}` | Normal | Tìm character trong dòng (forward)      |
| `F{char}` | Normal | Tìm character trong dòng (backward)     |
| `t{char}` | Normal | Tìm đến trước character (forward)       |
| `T{char}` | Normal | Tìm đến sau character (backward)        |
| `;`       | Normal | Lặp lại lệnh f/F/t/T cuối               |
| `,`       | Normal | Lặp lại lệnh f/F/t/T cuối (ngược hướng) |

**Commands:**

-  `:s/old/new/` - Replace first occurrence trong dòng hiện tại
-  `:s/old/new/g` - Replace all occurrences trong dòng hiện tại
-  `:%s/old/new/g` - Replace all occurrences trong toàn file
-  `:%s/old/new/gc` - Replace với confirmation

### Text Movement

| Phím tắt | Chế độ | Mô tả                               |
| -------- | ------ | ----------------------------------- |
| `J`      | Visual | Di chuyển dòng được chọn xuống dưới |
| `K`      | Visual | Di chuyển dòng được chọn lên trên   |

### Paste Operations

| Phím tắt    | Chế độ | Mô tả                                              |
| ----------- | ------ | -------------------------------------------------- |
| `<leader>p` | Visual | Paste nội dung mà không làm mất clipboard hiện tại |

### Indentation

| Phím tắt | Chế độ | Mô tả                               |
| -------- | ------ | ----------------------------------- |
| `>>`     | Normal | Indent dòng hiện tại sang phải      |
| `<<`     | Normal | Indent dòng hiện tại sang trái      |
| `>`      | Visual | Indent các dòng được chọn sang phải |
| `<`      | Visual | Indent các dòng được chọn sang trái |
| `=`      | Visual | Auto-indent các dòng được chọn      |
| `==`     | Normal | Auto-indent dòng hiện tại           |
| `gg=G`   | Normal | Auto-indent toàn bộ file            |

### Character & Line Operations

| Phím tắt  | Chế độ | Mô tả                                         |
| --------- | ------ | --------------------------------------------- |
| `x`       | Normal | Xóa character tại cursor                      |
| `X`       | Normal | Xóa character trước cursor                    |
| `s`       | Normal | Substitute character (xóa và vào Insert mode) |
| `S`       | Normal | Substitute line (xóa dòng và vào Insert mode) |
| `C`       | Normal | Change từ cursor đến cuối dòng                |
| `cc`      | Normal | Change toàn bộ dòng                           |
| `cw`      | Normal | Change word từ cursor                         |
| `r{char}` | Normal | Replace character tại cursor                  |
| `R`       | Normal | Vào Replace mode                              |
| `~`       | Normal | Toggle case của character                     |
| `g~`      | Visual | Toggle case của text được chọn                |
| `gu`      | Visual | Chuyển thành lowercase                        |
| `gU`      | Visual | Chuyển thành UPPERCASE                        |

### Navigation & Movement

| Phím tắt    | Chế độ | Mô tả                                      |
| ----------- | ------ | ------------------------------------------ |
| `h`         | Normal | Di chuyển trái                             |
| `j`         | Normal | Di chuyển xuống                            |
| `k`         | Normal | Di chuyển lên                              |
| `l`         | Normal | Di chuyển phải                             |
| `w`         | Normal | Di chuyển đến đầu word tiếp theo           |
| `W`         | Normal | Di chuyển đến đầu WORD tiếp theo           |
| `e`         | Normal | Di chuyển đến cuối word hiện tại           |
| `E`         | Normal | Di chuyển đến cuối WORD hiện tại           |
| `b`         | Normal | Di chuyển đến đầu word trước đó            |
| `B`         | Normal | Di chuyển đến đầu WORD trước đó            |
| `0`         | Normal | Di chuyển đến đầu dòng                     |
| `^`         | Normal | Di chuyển đến ký tự đầu tiên (non-blank)   |
| `$`         | Normal | Di chuyển đến cuối dòng                    |
| `g_`        | Normal | Di chuyển đến ký tự cuối cùng (non-blank)  |
| `gg`        | Normal | Di chuyển đến đầu file                     |
| `G`         | Normal | Di chuyển đến cuối file                    |
| `{number}G` | Normal | Di chuyển đến dòng số {number}             |
| `:{number}` | Normal | Di chuyển đến dòng số {number}             |
| `Ctrl+f`    | Normal | Page down (forward)                        |
| `Ctrl+b`    | Normal | Page up (backward)                         |
| `Ctrl+d`    | Normal | Half page down                             |
| `Ctrl+u`    | Normal | Half page up                               |
| `Ctrl+e`    | Normal | Scroll down một dòng                       |
| `Ctrl+y`    | Normal | Scroll up một dòng                         |
| `H`         | Normal | Di chuyển đến top của screen               |
| `M`         | Normal | Di chuyển đến middle của screen            |
| `L`         | Normal | Di chuyển đến bottom của screen            |
| `zt`        | Normal | Scroll screen để cursor ở top              |
| `zz`        | Normal | Scroll screen để cursor ở center           |
| `zb`        | Normal | Scroll screen để cursor ở bottom           |
| `%`         | Normal | Di chuyển đến matching bracket/parentheses |
| `[[`        | Normal | Di chuyển đến đầu function trước           |
| `]]`        | Normal | Di chuyển đến đầu function tiếp theo       |
| `{`         | Normal | Di chuyển đến paragraph trước              |
| `}`         | Normal | Di chuyển đến paragraph tiếp theo          |

### Insert Mode

| Phím tắt | Chế độ | Mô tả                                |
| -------- | ------ | ------------------------------------ |
| `i`      | Normal | Vào Insert mode tại cursor           |
| `I`      | Normal | Vào Insert mode tại đầu dòng         |
| `a`      | Normal | Vào Insert mode sau cursor           |
| `A`      | Normal | Vào Insert mode tại cuối dòng        |
| `o`      | Normal | Tạo dòng mới dưới và vào Insert mode |
| `O`      | Normal | Tạo dòng mới trên và vào Insert mode |
| `Esc`    | Insert | Thoát Insert mode về Normal mode     |
| `Ctrl+c` | Insert | Thoát Insert mode (alternative)      |
| `Ctrl+[` | Insert | Thoát Insert mode (alternative)      |

### Word Deletion in Insert Mode

| Phím tắt         | Chế độ | Mô tả                                    |
| ---------------- | ------ | ---------------------------------------- |
| `Ctrl+Backspace` | Insert | Xóa word phía trước cursor               |
| `Ctrl+Delete`    | Insert | Xóa word phía sau cursor                 |
| `Ctrl+h`         | Insert | Xóa word phía trước cursor (alternative) |
| `Ctrl+w`         | Insert | Xóa word phía trước cursor (Vim default) |

### Jumps & Marks

| Phím tắt         | Chế độ | Mô tả                                   |
| ---------------- | ------ | --------------------------------------- |
| `Ctrl+o`         | Normal | Jump back (older position)              |
| `Ctrl+i` / `Tab` | Normal | Jump forward (newer position)           |
| `m{a-zA-Z}`      | Normal | Set mark tại cursor                     |
| `'{a-zA-Z}`      | Normal | Jump đến mark (đầu dòng)                |
| `\`{a-zA-Z}`     | Normal | Jump đến mark (exact position)          |
| `''`             | Normal | Jump đến position trước jump cuối       |
| `\`\``           | Normal | Jump đến exact position trước jump cuối |
| `'.`             | Normal | Jump đến last change                    |
| `\`.`            | Normal | Jump đến exact position của last change |

---

## LSP (Language Server Protocol)

### Code Navigation

| Phím tắt | Chế độ | Mô tả                      |
| -------- | ------ | -------------------------- |
| `K`      | Normal | Hiển thị hover information |
| `gd`     | Normal | Đi đến definition          |
| `gD`     | Normal | Đi đến declaration         |
| `gi`     | Normal | Đi đến implementation      |
| `gr`     | Normal | Hiển thị references        |

### Code Actions

| Phím tắt     | Chế độ        | Mô tả                                       |
| ------------ | ------------- | ------------------------------------------- |
| `<leader>rn` | Normal        | Rename symbol                               |
| `<leader>ca` | Normal/Visual | Code actions                                |
| `<leader>fm` | Normal        | Liệt kê tất cả methods/functions trong file |

---

## Tìm kiếm Files (FZF)

### Basic Search

| Phím tắt     | Chế độ | Mô tả                          |
| ------------ | ------ | ------------------------------ |
| `<leader>ff` | Normal | Tìm kiếm files                 |
| `<leader>pf` | Normal | Tìm kiếm Git files             |
| `<leader>fg` | Normal | Live grep (tìm kiếm nội dung)  |
| `<leader>fG` | Normal | Live grep bao gồm hidden files |
| `<leader>fb` | Normal | Hiển thị danh sách buffers     |
| `<leader>fh` | Normal | Tìm kiếm help tags             |
| `<leader>fs` | Normal | FZF grep với input prompt      |

### FZF Navigation

| Phím tắt | Chế độ | Mô tả                |
| -------- | ------ | -------------------- |
| `Ctrl+q` | FZF    | Select all và accept |

---

## Quản lý Files (Neo-tree)

### Neo-tree File Explorer

| Phím tắt     | Chế độ   | Mô tả                                |
| ------------ | -------- | ------------------------------------ |
| `<leader>v`  | Normal   | Mở Neo-tree ở bên trái               |
| `<leader>xx` | Normal   | Đóng Neo-tree                        |
| `<Tab>`      | Neo-tree | Preview file (trong cửa sổ Neo-tree) |
| `P`          | Neo-tree | Preview file (trong cửa sổ Neo-tree) |

### Một số phím mặc định của Neo-tree

| Phím tắt | Chế độ   | Mô tả                             |
| -------- | -------- | --------------------------------- |
| `Enter`  | Neo-tree | Mở file/directory                 |
| `o`      | Neo-tree | Mở file/directory                 |
| `a`      | Neo-tree | Tạo file/directory mới            |
| `d`      | Neo-tree | Xóa file/directory                |
| `r`      | Neo-tree | Đổi tên file/directory            |
| `yy`     | Neo-tree | Copy file/directory               |
| `p`      | Neo-tree | Paste file/directory              |
| `c`      | Neo-tree | Copy file/directory               |
| `x`      | Neo-tree | Cắt file/directory                |
| `s`      | Neo-tree | Split window và mở file           |
| `v`      | Neo-tree | Vertical split và mở file         |
| `H`      | Neo-tree | Toggle hiện/ẩn file ẩn (dotfiles) |
| `R`      | Neo-tree | Refresh                           |
| `q`      | Neo-tree | Đóng Neo-tree                     |
| `?`      | Neo-tree | Hiển thị help                     |

---

## Git Operations

### Git Signs (Hunks)

| Phím tắt     | Chế độ        | Mô tả                     |
| ------------ | ------------- | ------------------------- |
| `]h`         | Normal        | Đi đến hunk tiếp theo     |
| `[h`         | Normal        | Đi đến hunk trước đó      |
| `<leader>hs` | Normal/Visual | Stage hunk                |
| `<leader>hr` | Normal/Visual | Reset hunk                |
| `<leader>hS` | Normal        | Stage toàn bộ buffer      |
| `<leader>hR` | Normal        | Reset toàn bộ buffer      |
| `<leader>hb` | Normal        | Blame line (full)         |
| `<leader>hB` | Normal        | Toggle current line blame |
| `<leader>hd` | Normal        | Diff this                 |
| `<leader>hD` | Normal        | Diff this ~               |
| `<leader>dv` | Normal        | Toggle Diffview           |

### Git Text Objects

| Phím tắt | Chế độ          | Mô tả                   |
| -------- | --------------- | ----------------------- |
| `ih`     | Operator/Visual | Select hunk text object |

---

## Terminal

### Floating Terminal

| Phím tắt    | Chế độ          | Mô tả                    |
| ----------- | --------------- | ------------------------ |
| `<leader>T` | Normal/Terminal | Toggle floating terminal |

### Tmux Navigation

| Phím tắt | Chế độ | Mô tả                 |
| -------- | ------ | --------------------- |
| `C-h`    | Normal | Navigate left (Tmux)  |
| `C-j`    | Normal | Navigate down (Tmux)  |
| `C-k`    | Normal | Navigate up (Tmux)    |
| `C-l`    | Normal | Navigate right (Tmux) |

---

## Testing (Neotest)

### Test Execution

| Phím tắt     | Chế độ | Mô tả                         |
| ------------ | ------ | ----------------------------- |
| `<leader>tr` | Normal | Chạy test tại cursor          |
| `<leader>tb` | Normal | Chạy test với debugging       |
| `<leader>ts` | Normal | Dừng test đang chạy           |
| `<leader>tp` | Normal | Chạy tất cả tests trong file  |
| `<leader>tt` | Normal | Chạy specific test (Go suite) |

### Test UI

| Phím tắt     | Chế độ | Mô tả                      |
| ------------ | ------ | -------------------------- |
| `<leader>to` | Normal | Mở test output             |
| `<leader>tO` | Normal | Mở và jump vào test output |
| `<leader>tv` | Normal | Toggle test summary        |

---

## Debugging

### Debug Controls

| Phím tắt     | Chế độ | Mô tả              |
| ------------ | ------ | ------------------ |
| `<leader>dt` | Normal | Toggle breakpoint  |
| `<leader>dc` | Normal | Continue debugging |

---

## Autocompletion

### Completion Navigation

| Phím tắt     | Chế độ | Mô tả                |
| ------------ | ------ | -------------------- |
| `Ctrl+b`     | Insert | Scroll docs lên      |
| `Ctrl+f`     | Insert | Scroll docs xuống    |
| `Ctrl+Space` | Insert | Trigger completion   |
| `Ctrl+e`     | Insert | Abort completion     |
| `Enter`      | Insert | Confirm selection    |
| `Ctrl+k`     | Insert | Select previous item |
| `Ctrl+j`     | Insert | Select next item     |

---

## AI/LLM

### Chat Operations

| Phím tắt          | Chế độ | Mô tả                 |
| ----------------- | ------ | --------------------- |
| `Ctrl+g` `c`      | Normal | New AI chat           |
| `Ctrl+g` `f`      | Normal | Chat finder           |
| `Ctrl+g` `Ctrl+t` | Normal | New chat trong tab    |
| `Ctrl+g` `Ctrl+v` | Normal | New chat trong vsplit |
| `Ctrl+g` `Ctrl+x` | Normal | New chat trong split  |

### AI Generation

| Phím tắt     | Chế độ        | Mô tả               |
| ------------ | ------------- | ------------------- |
| `Ctrl+g` `a` | Normal/Visual | Append AI response  |
| `Ctrl+g` `b` | Normal/Visual | Prepend AI response |
| `Ctrl+g` `r` | Visual        | Rewrite selection   |
| `Ctrl+g` `i` | Visual        | Implement selection |
| `Ctrl+g` `n` | Normal        | Next AI agent       |
| `Ctrl+g` `s` | Normal        | Stop AI generation  |

### AI Windows

| Phím tắt         | Chế độ        | Mô tả                     |
| ---------------- | ------------- | ------------------------- |
| `Ctrl+g` `g` `e` | Normal/Visual | Generate trong new buffer |
| `Ctrl+g` `g` `n` | Normal/Visual | Generate trong new window |
| `Ctrl+g` `g` `v` | Normal/Visual | Generate trong vnew       |
| `Ctrl+g` `g` `t` | Normal/Visual | Generate trong tabnew     |
| `Ctrl+g` `g` `p` | Normal/Visual | Generate trong popup      |

### Whisper (Voice)

| Phím tắt         | Chế độ | Mô tả                    |
| ---------------- | ------ | ------------------------ |
| `Ctrl+g` `w` `w` | Visual | Whisper transcription    |
| `Ctrl+g` `w` `a` | Visual | Whisper append           |
| `Ctrl+g` `w` `b` | Visual | Whisper prepend          |
| `Ctrl+g` `w` `r` | Visual | Whisper rewrite          |
| `Ctrl+g` `w` `e` | Visual | Whisper trong new buffer |
| `Ctrl+g` `w` `n` | Visual | Whisper trong new window |
| `Ctrl+g` `w` `v` | Visual | Whisper trong vnew       |
| `Ctrl+g` `w` `t` | Visual | Whisper trong tabnew     |
| `Ctrl+g` `w` `p` | Visual | Whisper trong popup      |

---

## Java Development

### Java Refactoring

| Phím tắt      | Chế độ        | Mô tả            |
| ------------- | ------------- | ---------------- |
| `<leader>co`  | Normal        | Organize imports |
| `<leader>crv` | Normal/Visual | Extract variable |
| `<leader>crc` | Normal/Visual | Extract constant |
| `<leader>crm` | Visual        | Extract method   |

---

## Text Manipulation

### Surround Operations

| Phím tắt     | Chế độ | Mô tả                            |
| ------------ | ------ | -------------------------------- |
| `<leader>s`  | Visual | Surround selection               |
| `<leader>sw` | Normal | Surround word                    |
| `<leader>sr` | Normal | Remove/change surround word      |
| `<leader>ts` | Visual | Toggle/change surround selection |

---

## Utilities

### Undo Tree

| Phím tắt     | Chế độ | Mô tả            |
| ------------ | ------ | ---------------- |
| `<leader>ut` | Normal | Toggle undo tree |
| `<leader>uf` | Normal | Focus undo tree  |

### Arrow (Quick Navigation)

| Phím tắt | Chế độ | Mô tả             |
| -------- | ------ | ----------------- |
| `Tab`    | Normal | Arrow leader key  |
| `m`      | Normal | Buffer leader key |

### Pomodoro Timer

Commands: `:TimerStart`, `:TimerRepeat`, `:TimerSession`

---

## 🔧 Plugin Management

### Lazy.nvim Commands

-  `:Lazy` - Mở Lazy plugin manager
-  `:Lazy update` - Update plugins
-  `:Lazy sync` - Sync plugins
-  `:Lazy clean` - Clean unused plugins

---

## 📝 Ghi chú

1. **Leader key** được thiết lập là `Space`
2. Một số keymaps chỉ hoạt động trong context cụ thể (VD: Oil keymaps chỉ hoạt động trong Oil buffer)
3. AI/LLM features yêu cầu có API key được cấu hình
4. Java keymaps yêu cầu `nvim-jdtls` và Java development environment
5. Whisper features yêu cầu OpenAI API key và audio recording tools
6. Debugging features yêu cầu debug adapters được cài đặt (VD: `delve` cho Go)

---

## 🚀 Mẹo sử dụng

-  Sử dụng `<leader>ff` để nhanh chóng tìm files
-  `<leader>fg` để tìm kiếm nội dung trong project
-  `<leader>vv` để browse files với Oil
-  `Ctrl+g c` để bắt đầu chat với AI
-  `<leader>tr` để chạy tests
-  `<leader>dt` để toggle breakpoints khi debugging
