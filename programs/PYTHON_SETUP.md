### 1. Rebuild NixOS

```bash
# Rebuild system với cấu hình mới
sudo nixos-rebuild switch
```

### 2. Kiểm tra cài đặt

```bash
# Kiểm tra Python version
python3 --version

# Kiểm tra các packages đã cài
pip3 list

# Kiểm tra pytest
pytest --version

# Kiểm tra black
black --version
```

### 3. Tạo virtual environment

```bash
# Tạo virtual environment
python3 -m venv .venv

# Kích hoạt (sẽ tự động kích hoạt khi vào thư mục)
source .venv/bin/activate

# Hoặc sử dụng virtualenv
virtualenv venv
source venv/bin/activate
```

### 4. Sử dụng trong Neovim

#### Testing

-  `<Leader>tr` - Chạy test tại cursor
-  `<Leader>tb` - Chạy test với debug
-  `<Leader>tp` - Chạy tất cả test trong file
-  `<Leader>tv` - Xem test summary
-  `<Leader>to` - Xem test output

#### Debugging

-  `<Leader>dt` - Toggle breakpoint
-  `<Leader>dc` - Continue
-  `<Leader>ds` - Step over
-  `<Leader>di` - Step into
-  `<Leader>do` - Step out
-  `<Leader>du` - Toggle debug UI

#### Python specific keymaps

-  `<Leader>rf` - Chạy Python file
-  `<Leader>rp` - Chạy Python file trong terminal
-  `<Leader>ri` - Mở Python interactive

#### Format và Lint

-  `<Leader>gf` - Format code (sử dụng black/isort)

### 5. Tạo file test Python

Tạo file `test_example.py`:

```python
def add(a, b):
    return a + b

def test_add():
    assert add(2, 3) == 5
    assert add(-1, 1) == 0
    assert add(0, 0) == 0

if __name__ == "__main__":
    test_add()
    print("All tests passed!")
```

### 6. Tạo file Python với debug

Tạo file `debug_example.py`:

```python
def factorial(n):
    if n <= 1:
        return 1
    return n * factorial(n - 1)

def main():
    result = factorial(5)
    print(f"Factorial of 5 is: {result}")

if __name__ == "__main__":
    main()
```

## Troubleshooting

### 1. LSP không hoạt động

```bash
# Kiểm tra pylsp đã cài chưa
:MasonInstall pylsp

# Kiểm tra LSP status
:LspInfo
```

### 2. Debug không hoạt động

```bash
# Kiểm tra debugpy đã cài chưa
pip3 install debugpy

# Kiểm tra DAP adapter
:DapInfo
```

### 3. Test không chạy

```bash
# Kiểm tra pytest đã cài chưa
pytest --version

# Chạy test thủ công
python3 -m pytest test_file.py
```

### 4. Format không hoạt động

```bash
# Kiểm tra black đã cài chưa
black --version

# Format thủ công
black your_file.py
```

## Lưu ý

1. **Virtual Environment**: Luôn sử dụng virtual environment cho projects
2. **Requirements**: Tạo `requirements.txt` hoặc `pyproject.toml` cho dependencies
3. **Testing**: Viết test cho tất cả functions quan trọng
4. **Format**: Sử dụng black và isort để format code tự động
5. **Lint**: Sử dụng flake8 và mypy để kiểm tra code quality

## Cập nhật

Để cập nhật cấu hình:

1. Chỉnh sửa file trong `programs/python.nix`
2. Chạy `sudo nixos-rebuild switch`
3. Restart Neovim để áp dụng thay đổi
