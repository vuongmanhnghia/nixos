# Neovim C++ Development Guide

## 🚀 Tổng quan
Cấu hình Neovim đã được tối ưu hóa cho C++ development với các tính năng:
- **Clangd LSP** với các tùy chọn tối ưu
- **Debugging** với nvim-dap + GDB
- **CMake integration** 
- **Auto-formatting** với clang-format
- **Inlay hints** và type information
- **Advanced completion** và code navigation

## 📦 Cài đặt
Sau khi cập nhật cấu hình, chạy:
```bash
sudo nixos-rebuild switch --flake /etc/nixos
```

## ⌨️ Keybindings Chính

### LSP Features
| Keybinding | Chức năng | Mô tả |
|------------|-----------|-------|
| `gd` | Go to definition | Nhảy đến định nghĩa |
| `gr` | Go to references | Tìm tất cả references |
| `gI` | Go to implementation | Nhảy đến implementation |
| `gt` | Go to type definition | Nhảy đến type definition |
| `K` | Hover documentation | Hiển thị documentation |
| `<leader>rn` | Rename symbol | Đổi tên symbol |
| `<leader>ca` | Code action | Hiển thị code actions |
| `<leader>f` | Format code | Format code với clang-format |

### Debugging (F-keys như Visual Studio)
| Keybinding | Chức năng | Mô tả |
|------------|-----------|-------|
| `<F5>` | Continue/Start Debug | Bắt đầu hoặc tiếp tục debug |
| `<F10>` | Step Over | Thực hiện step over |
| `<F11>` | Step Into | Thực hiện step into |
| `<F12>` | Step Out | Thực hiện step out |
| `<leader>b` | Toggle Breakpoint | Đặt/xóa breakpoint |
| `<leader>B` | Conditional Breakpoint | Đặt breakpoint có điều kiện |
| `<leader>dr` | Debug REPL | Mở debug console |
| `<leader>du` | Toggle Debug UI | Bật/tắt debug interface |

### CMake Integration
| Keybinding | Chức năng | Mô tả |
|------------|-----------|-------|
| `<leader>cg` | CMake Generate | Generate build files |
| `<leader>cb` | CMake Build | Build project |
| `<leader>cr` | CMake Run | Run executable |
| `<leader>cd` | CMake Debug | Debug executable |
| `<leader>cc` | CMake Clean | Clean build |

### File Navigation (Telescope)
| Keybinding | Chức năng | Mô tả |
|------------|-----------|-------|
| `<leader>ff` | Find Files | Tìm files |
| `<leader>fg` | Live Grep | Tìm text trong files |
| `<leader>fb` | Find Buffers | Tìm trong buffers |
| `<leader>fh` | Help Tags | Tìm help |

## 🔧 Cấu hình C++ Specific

### Clangd Settings
- **Background indexing**: Tự động index code
- **Clang-tidy**: Static analysis
- **Header insertion**: Tự động insert headers
- **Function placeholders**: Hiển thị parameter hints
- **Inlay hints**: Type hints trong code

### Auto-formatting
- Tự động format khi save file
- Sử dụng `.clang-format` file nếu có
- Fallback style: LLVM

### Debugging Setup
- **GDB integration**: Debug với GDB
- **Auto UI**: Debug UI tự động mở/đóng
- **Virtual text**: Hiển thị variable values inline
- **Breakpoint management**: Quản lý breakpoints dễ dàng

## 📁 Cấu trúc Project Recommended

### CMake Project
```
my_cpp_project/
├── CMakeLists.txt
├── src/
│   ├── main.cpp
│   └── ...
├── include/
│   └── ...
├── build/           # Build directory
└── .clang-format    # Formatting rules (optional)
```

### Sample CMakeLists.txt
```cmake
cmake_minimum_required(VERSION 3.16)
project(MyProject)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Export compile commands for clangd
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

add_executable(${PROJECT_NAME} 
    src/main.cpp
)

target_include_directories(${PROJECT_NAME} PRIVATE include)
```

### Sample .clang-format
```yaml
BasedOnStyle: LLVM
IndentWidth: 4
ColumnLimit: 120
UseTab: Never
```

## 🚀 Workflow Ví dụ

### 1. Tạo project mới
```bash
mkdir my_cpp_project && cd my_cpp_project
```

### 2. Tạo CMakeLists.txt và source files
```bash
nvim CMakeLists.txt  # Tạo CMake config
nvim src/main.cpp    # Tạo main file
```

### 3. Generate và build
```
<leader>cg  # Generate CMake
<leader>cb  # Build project
```

### 4. Debug
```
<leader>cd  # Start debugging
<F5>        # Continue
<leader>b   # Set breakpoints
```

### 5. Code navigation
```
gd          # Go to definition
gr          # Find references
<leader>rn  # Rename symbol
```

## 🔍 Troubleshooting

### Clangd không hoạt động
1. Đảm bảo có `compile_commands.json`:
   ```bash
   cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 .
   ```

2. Restart LSP:
   ```vim
   :LspRestart
   ```

### Debugging không hoạt động
1. Đảm bảo compile với debug symbols:
   ```cmake
   set(CMAKE_BUILD_TYPE Debug)
   ```

2. Kiểm tra GDB có sẵn:
   ```bash
   which gdb
   ```

### Format không hoạt động
1. Kiểm tra clang-format:
   ```bash
   which clang-format
   ```

2. Tạo `.clang-format` file trong project root

## 🎯 Tips & Tricks

### 1. Inlay Hints
- Type hints tự động hiển thị
- Có thể toggle với `:ClangdToggleInlayHints`

### 2. Code Completion
- `<Tab>` để select completion
- `<C-Space>` để trigger completion
- `<C-e>` để cancel

### 3. CMake Integration
- Tự động detect CMake projects
- Build directory: `build/`
- Compile commands export tự động

### 4. Performance
- Background indexing không block editor
- Fast completion với clangd
- Optimized for large codebases

## 📚 Tài liệu tham khảo
- [Clangd Documentation](https://clangd.llvm.org/)
- [nvim-dap Documentation](https://github.com/mfussenegger/nvim-dap)
- [CMake Tools Documentation](https://github.com/Civitasv/cmake-tools.nvim)

---
*Cấu hình này được tối ưu cho C++ development trên NixOS với Neovim* 