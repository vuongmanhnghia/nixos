{ config, pkgs, ... }:

{
  # === GO DEVELOPMENT ENVIRONMENT ===
  
  # Go development environment packages
  environment.systemPackages = with pkgs; [
    # === GO CORE ===
    go                           # Go compiler and tools
    gopls                        # Go Language Server Protocol
    
    # === GO DEVELOPMENT TOOLS ===
    # Debugging
    delve                        # Go debugger (dlv)
    
    # Testing and benchmarking
    golangci-lint               # Fast Go linters runner
    gotests                     # Generate Go tests
    
    # Code formatting and linting
    gofumpt                     # Stricter gofmt
    gotools                     # Additional Go tools (includes goimports, guru, gorename, etc.)
    
    # Build and dependency management
    go-migrate                  # Database migration tool
    protobuf                    # Protocol buffer compiler
    protoc-gen-go              # Go protobuf plugin
    
    # Development utilities
    air                         # Live reload for Go apps
    goconvey                    # BDD testing framework
  ];

  # === GO ENVIRONMENT VARIABLES ===
  environment.variables = {
    # Go workspace configuration
    GOPATH = "$HOME/go";                    # Go workspace directory
    GOBIN = "$HOME/go/bin";                # Go binaries directory
    GO111MODULE = "on";                     # Enable Go modules
    GOPROXY = "https://proxy.golang.org";   # Go module proxy
    GOSUMDB = "sum.golang.org";            # Go checksum database
  };

  # === GO SHELL INITIALIZATION ===
  programs.zsh.interactiveShellInit = ''
    # Go development aliases
    alias gob="go build"
    alias gor="go run"
    alias got="go test"
    alias gotv="go test -v"
    alias goc="go clean"
    alias goi="go install"
    alias gom="go mod"
    alias gof="go fmt"
    alias godoc="go doc"
    alias goget="go get"
    
    # Go workspace navigation
    alias gowork="cd $GOPATH/src"
    alias gobin="cd $GOPATH/bin"
    
    # Go testing shortcuts
    alias gotest="go test ./..."
    alias gobench="go test -bench=."
    alias gocover="go test -cover"
    
    # Go linting and formatting
    alias golint="golangci-lint run"
    alias gofmt="gofumpt -w ."
    alias goimp="goimports -w ."
    
    # Go build shortcuts
    alias gobuild="go build -v"
    alias goinstall="go install -v"
    
    # Add Go bin to PATH if not already there
    if [[ ":$PATH:" != *":$GOPATH/bin:"* ]]; then
      export PATH="$GOPATH/bin:$PATH"
    fi
  '';
} 