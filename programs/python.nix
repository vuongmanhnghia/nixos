{ config, pkgs, ... }:

{
  # === PYTHON DEVELOPMENT ENVIRONMENT ===
  
  # Python development environment packages
  environment.systemPackages = with pkgs; [
    # === PYTHON CORE ===
    python3
    python3Packages.pip
    python3Packages.setuptools
    
    # === PYTHON DEVELOPMENT TOOLS ===
    # Debugging
    python3Packages.debugpy      # Required for nvim-dap-python
    
    # Testing
    python3Packages.pytest       # Main testing framework
    
    # Code formatting and linting
    python3Packages.black        # Code formatter
    python3Packages.isort        # Import sorter
    python3Packages.flake8       # Linter
    
    # Development utilities
    python3Packages.ipython      # Enhanced REPL
    python3Packages.virtualenv   # Virtual environment manager
  ];

  # === PYTHON ENVIRONMENT VARIABLES ===
  environment.variables = {
    # Enable Python development mode
    PYTHONDONTWRITEBYTECODE = "1";  # Don't create .pyc files
  };

  # === PYTHON SHELL INITIALIZATION ===
  # Add Python configuration to existing zsh setup
  programs.zsh.interactiveShellInit = ''
    # Python virtual environment prompt
    export VIRTUAL_ENV_DISABLE_PROMPT=1
    
    # Auto-activate virtual environment if exists
    if [[ -f .venv/bin/activate ]]; then
      source .venv/bin/activate
    elif [[ -f venv/bin/activate ]]; then
      source venv/bin/activate
    fi
    
    # Python aliases
    alias py="python3"
    alias pip="pip3"
    alias pytest="python3 -m pytest"
    alias black="python3 -m black"
    alias isort="python3 -m isort"
    alias flake8="python3 -m flake8"
  '';
} 