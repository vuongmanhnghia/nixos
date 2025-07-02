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

### Text Movement

| Phím tắt | Chế độ | Mô tả                               |
| -------- | ------ | ----------------------------------- |
| `J`      | Visual | Di chuyển dòng được chọn xuống dưới |
| `K`      | Visual | Di chuyển dòng được chọn lên trên   |

### Paste Operations

| Phím tắt    | Chế độ | Mô tả                                              |
| ----------- | ------ | -------------------------------------------------- |
| `<leader>p` | Visual | Paste nội dung mà không làm mất clipboard hiện tại |

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

## Quản lý Files (Oil)

### Oil File Manager

| Phím tắt     | Chế độ | Mô tả                                         |
| ------------ | ------ | --------------------------------------------- |
| `<leader>vv` | Normal | Mở Oil file manager                           |
| `<leader>vf` | Normal | Mở Oil trong floating window                  |
| `<leader>vi` | Normal | Hiển thị thông tin chi tiết file              |
| `<leader>vt` | Normal | Hiển thị directory tree trong floating window |

### Oil Internal Navigation

| Phím tắt | Chế độ | Mô tả (trong Oil)            |
| -------- | ------ | ---------------------------- |
| `g?`     | Normal | Hiển thị help                |
| `Enter`  | Normal | Mở file/directory            |
| `Ctrl+t` | Normal | Mở trong tab mới             |
| `Ctrl+p` | Normal | Preview file                 |
| `Ctrl+c` | Normal | Đóng Oil                     |
| `R`      | Normal | Refresh                      |
| `-`      | Normal | Lên parent directory         |
| `_`      | Normal | Mở current working directory |
| `` ` ``  | Normal | CD vào directory             |
| `~`      | Normal | CD vào directory (tab scope) |
| `gs`     | Normal | Thay đổi sort order          |
| `gx`     | Normal | Mở bằng external program     |
| `H`      | Normal | Toggle hidden files          |
| `g\`     | Normal | Toggle trash                 |

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
