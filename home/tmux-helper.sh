#!/bin/bash

# =======================================================
# TMUX SESSION MANAGER - HELPER SCRIPT
# =======================================================

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to display usage
usage() {
    echo -e "${BLUE}Tmux Session Manager${NC}"
    echo -e "${YELLOW}Usage:${NC} $0 [COMMAND] [OPTIONS]"
    echo ""
    echo -e "${YELLOW}Commands:${NC}"
    echo "  new <name>       Create new session with name"
    echo "  attach <name>    Attach to existing session"
    echo "  kill <name>      Kill session with name"
    echo "  list             List all sessions"
    echo "  dev <project>    Create development session"
    echo "  work             Create default work session"
    echo "  dotfiles         Create dotfiles editing session"
    echo "  cleanup          Kill all sessions"
    echo "  help             Show this help message"
    echo ""
    echo -e "${YELLOW}Examples:${NC}"
    echo "  $0 new myproject"
    echo "  $0 dev webapp"
    echo "  $0 attach myproject"
    echo "  $0 list"
}

# Function to create new session
new_session() {
    local name="$1"
    if [ -z "$name" ]; then
        echo -e "${RED}Error: Session name required${NC}"
        return 1
    fi
    
    if tmux has-session -t "$name" 2>/dev/null; then
        echo -e "${YELLOW}Session '$name' already exists. Attaching...${NC}"
        tmux attach-session -t "$name"
    else
        echo -e "${GREEN}Creating new session: $name${NC}"
        tmux new-session -d -s "$name"
        tmux attach-session -t "$name"
    fi
}

# Function to attach to session
attach_session() {
    local name="$1"
    if [ -z "$name" ]; then
        echo -e "${RED}Error: Session name required${NC}"
        return 1
    fi
    
    if tmux has-session -t "$name" 2>/dev/null; then
        echo -e "${GREEN}Attaching to session: $name${NC}"
        tmux attach-session -t "$name"
    else
        echo -e "${RED}Session '$name' does not exist${NC}"
        return 1
    fi
}

# Function to kill session
kill_session() {
    local name="$1"
    if [ -z "$name" ]; then
        echo -e "${RED}Error: Session name required${NC}"
        return 1
    fi
    
    if tmux has-session -t "$name" 2>/dev/null; then
        tmux kill-session -t "$name"
        echo -e "${GREEN}Killed session: $name${NC}"
    else
        echo -e "${RED}Session '$name' does not exist${NC}"
        return 1
    fi
}

# Function to list sessions
list_sessions() {
    echo -e "${BLUE}Active Tmux Sessions:${NC}"
    if tmux list-sessions 2>/dev/null; then
        echo ""
        echo -e "${YELLOW}Use 'tmux attach -t <name>' to attach to a session${NC}"
    else
        echo -e "${YELLOW}No active sessions${NC}"
    fi
}

# Function to create development session
dev_session() {
    local project="$1"
    if [ -z "$project" ]; then
        echo -e "${RED}Error: Project name required${NC}"
        return 1
    fi
    
    local session_name="dev-$project"
    
    if tmux has-session -t "$session_name" 2>/dev/null; then
        echo -e "${YELLOW}Development session '$session_name' already exists. Attaching...${NC}"
        tmux attach-session -t "$session_name"
        return 0
    fi
    
    echo -e "${GREEN}Creating development session: $session_name${NC}"
    
    # Create session with main window
    tmux new-session -d -s "$session_name" -n "main"
    
    # Create additional windows
    tmux new-window -t "$session_name" -n "editor"
    tmux new-window -t "$session_name" -n "server"
    tmux new-window -t "$session_name" -n "logs"
    tmux new-window -t "$session_name" -n "git"
    
    # Setup main window with split panes
    tmux send-keys -t "$session_name:main" "clear" Enter
    tmux split-window -t "$session_name:main" -h
    tmux split-window -t "$session_name:main.2" -v
    tmux select-pane -t "$session_name:main.1"
    
    # Setup editor window
    tmux send-keys -t "$session_name:editor" "nvim ." Enter
    
    # Setup git window
    tmux send-keys -t "$session_name:git" "git status" Enter
    
    # Select main window and attach
    tmux select-window -t "$session_name:main"
    tmux attach-session -t "$session_name"
}

# Function to create work session
work_session() {
    local session_name="work"
    
    if tmux has-session -t "$session_name" 2>/dev/null; then
        echo -e "${YELLOW}Work session already exists. Attaching...${NC}"
        tmux attach-session -t "$session_name"
        return 0
    fi
    
    echo -e "${GREEN}Creating work session${NC}"
    
    # Create session with main window
    tmux new-session -d -s "$session_name" -n "terminal"
    
    # Create additional windows
    tmux new-window -t "$session_name" -n "code"
    tmux new-window -t "$session_name" -n "browser"
    tmux new-window -t "$session_name" -n "notes"
    
    # Setup code window with split
    tmux split-window -t "$session_name:code" -h
    tmux select-pane -t "$session_name:code.1"
    
    # Select terminal window and attach
    tmux select-window -t "$session_name:terminal"
    tmux attach-session -t "$session_name"
}

# Function to create dotfiles session
dotfiles_session() {
    local session_name="dotfiles"
    
    if tmux has-session -t "$session_name" 2>/dev/null; then
        echo -e "${YELLOW}Dotfiles session already exists. Attaching...${NC}"
        tmux attach-session -t "$session_name"
        return 0
    fi
    
    echo -e "${GREEN}Creating dotfiles session${NC}"
    
    # Create session and navigate to nixos config
    tmux new-session -d -s "$session_name" -c "$HOME/Workspaces/Config/nixos"
    
    # Create windows
    tmux new-window -t "$session_name" -n "config" -c "$HOME/Workspaces/Config/nixos"
    tmux new-window -t "$session_name" -n "test" -c "$HOME/Workspaces/Config/nixos"
    
    # Setup config window
    tmux send-keys -t "$session_name:config" "nvim ." Enter
    
    # Setup test window
    tmux send-keys -t "$session_name:test" "sudo nixos-rebuild test" Enter
    
    # Select config window and attach
    tmux select-window -t "$session_name:config"
    tmux attach-session -t "$session_name"
}

# Function to cleanup all sessions
cleanup_sessions() {
    echo -e "${YELLOW}Killing all tmux sessions...${NC}"
    tmux kill-server 2>/dev/null
    echo -e "${GREEN}All sessions killed${NC}"
}

# Main script logic
case "$1" in
    "new")
        new_session "$2"
        ;;
    "attach")
        attach_session "$2"
        ;;
    "kill")
        kill_session "$2"
        ;;
    "list")
        list_sessions
        ;;
    "dev")
        dev_session "$2"
        ;;
    "work")
        work_session
        ;;
    "dotfiles")
        dotfiles_session
        ;;
    "cleanup")
        cleanup_sessions
        ;;
    "help"|"--help"|"-h")
        usage
        ;;
    "")
        usage
        ;;
    *)
        echo -e "${RED}Unknown command: $1${NC}"
        usage
        exit 1
        ;;
esac 