# NixOS 25.05 Management Makefile
# Professional system management and optimization

.PHONY: help build switch update clean optimize test lint format check-health
.DEFAULT_GOAL := help

# Colors for output
CYAN := \033[36m
GREEN := \033[32m
YELLOW := \033[33m
RED := \033[31m
RESET := \033[0m

# Configuration
FLAKE_PATH := .
HOSTNAME := desktop
USERNAME := nagih

help: ## Show this help message
	@echo "$(CYAN)NixOS 25.05 Management Commands$(RESET)"
	@echo "=================================="
	@awk 'BEGIN {FS = ":.*##"} /^[a-zA-Z_-]+:.*##/ { printf "  $(GREEN)%-15s$(RESET) %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

# Build commands
build: ## Build the system configuration without switching
	@echo "$(CYAN)🔨 Building NixOS configuration...$(RESET)"
	nix build .#nixosConfigurations.$(HOSTNAME).config.system.build.toplevel -L

switch: ## Build and switch to the new configuration
	@echo "$(CYAN)🔄 Switching to new NixOS configuration...$(RESET)"
	sudo nixos-rebuild switch --flake .#$(HOSTNAME) --show-trace

boot: ## Build and set as boot default (requires reboot)
	@echo "$(CYAN)🥾 Setting new configuration as boot default...$(RESET)"
	sudo nixos-rebuild boot --flake .#$(HOSTNAME) --show-trace

test: ## Test the configuration without switching
	@echo "$(CYAN)🧪 Testing NixOS configuration...$(RESET)"
	sudo nixos-rebuild test --flake .#$(HOSTNAME) --show-trace

# Update commands  
update: ## Update flake inputs and switch
	@echo "$(CYAN)📦 Updating flake inputs...$(RESET)"
	nix flake update
	@echo "$(CYAN)🔄 Switching to updated configuration...$(RESET)"
	sudo nixos-rebuild switch --flake .#$(HOSTNAME) --show-trace

update-input: ## Update specific flake input (usage: make update-input INPUT=nixpkgs)
	@if [ -z "$(INPUT)" ]; then \
		echo "$(RED)❌ Please specify INPUT=<input_name>$(RESET)"; \
		exit 1; \
	fi
	@echo "$(CYAN)📦 Updating $(INPUT)...$(RESET)"
	nix flake update $(INPUT)

check-updates: ## Check for available updates without applying
	@echo "$(CYAN)🔍 Checking for updates...$(RESET)"
	nix flake metadata
	@echo "\n$(YELLOW)💡 Run 'make update' to apply updates$(RESET)"

# Optimization commands
optimize: ## Run comprehensive system optimization
	@echo "$(CYAN)🚀 Running system optimization...$(RESET)"
	./scripts/system-optimizer.sh --all

optimize-nix: ## Optimize Nix store only
	@echo "$(CYAN)🗄️ Optimizing Nix store...$(RESET)"
	./scripts/system-optimizer.sh --nix

optimize-performance: ## Optimize system performance
	@echo "$(CYAN)⚡ Optimizing system performance...$(RESET)"
	./scripts/system-optimizer.sh --performance

clean: ## Clean temporary files and caches
	@echo "$(CYAN)🧹 Cleaning system...$(RESET)"
	./scripts/system-optimizer.sh --clean

clean-deep: ## Deep clean including old generations
	@echo "$(CYAN)🧹 Deep cleaning system...$(RESET)"
	./scripts/system-optimizer.sh --nix --clean
	sudo nix-collect-garbage -d
	sudo nix-env --delete-generations old --profile /nix/var/nix/profiles/system

# Analysis commands
check-health: ## Check system health
	@echo "$(CYAN)🏥 Checking system health...$(RESET)"
	./scripts/system-optimizer.sh --health

analyze-boot: ## Analyze boot performance
	@echo "$(CYAN)⏱️ Analyzing boot performance...$(RESET)"
	./scripts/system-optimizer.sh --boot

system-info: ## Show detailed system information
	@echo "$(CYAN)ℹ️ System Information:$(RESET)"
	./scripts/system-optimizer.sh --info

system-report: ## Generate comprehensive system report
	@echo "$(CYAN)📄 Generating system report...$(RESET)"
	./scripts/system-optimizer.sh --report

# Development commands
lint: ## Lint Nix files
	@echo "$(CYAN)🔍 Linting Nix files...$(RESET)"
	find . -name "*.nix" -exec nix-instantiate --parse {} \; >/dev/null

format: ## Format Nix files with alejandra
	@echo "$(CYAN)✨ Formatting Nix files...$(RESET)"
	alejandra .

check: ## Check flake and run basic validation
	@echo "$(CYAN)✅ Checking flake...$(RESET)"
	nix flake check --show-trace

show: ## Show flake outputs
	@echo "$(CYAN)📋 Showing flake outputs...$(RESET)"
	nix flake show

# Development shells
dev-shell: ## Enter development shell
	@echo "$(CYAN)🔧 Entering development shell...$(RESET)"
	nix develop

dev-web: ## Enter web development shell
	@echo "$(CYAN)🌐 Entering web development shell...$(RESET)"
	nix develop .#web

dev-python: ## Enter Python development shell
	@echo "$(CYAN)🐍 Entering Python development shell...$(RESET)"
	nix develop .#python

# Gaming commands
gaming-on: ## Enable gaming optimizations
	@echo "$(CYAN)🎮 Enabling gaming optimizations...$(RESET)"
	echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
	sudo systemctl stop power-profiles-daemon 2>/dev/null || true
	@echo "$(GREEN)✅ Gaming mode enabled$(RESET)"

gaming-off: ## Disable gaming optimizations (power save)
	@echo "$(CYAN)🔋 Enabling power save mode...$(RESET)"
	echo powersave | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
	sudo systemctl start power-profiles-daemon 2>/dev/null || true
	@echo "$(GREEN)✅ Power save mode enabled$(RESET)"

# Backup and restore
backup-config: ## Backup current configuration
	@echo "$(CYAN)💾 Backing up configuration...$(RESET)"
	mkdir -p backups
	tar -czf backups/nixos-config-$(shell date +%Y%m%d-%H%M%S).tar.gz \
		--exclude='.git' \
		--exclude='result*' \
		--exclude='backups' \
		.
	@echo "$(GREEN)✅ Configuration backed up to backups/$(RESET)"

list-generations: ## List system generations
	@echo "$(CYAN)📋 System generations:$(RESET)"
	sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

rollback: ## Rollback to previous generation
	@echo "$(CYAN)⏪ Rolling back to previous generation...$(RESET)"
	sudo nixos-rebuild --rollback switch

# Emergency commands
emergency-shell: ## Boot into emergency shell (next boot)
	@echo "$(YELLOW)⚠️ Setting emergency shell for next boot...$(RESET)"
	sudo systemctl set-default emergency.target
	@echo "$(RED)🚨 System will boot into emergency shell on next reboot!$(RESET)"
	@echo "$(YELLOW)💡 Run 'sudo systemctl set-default graphical.target' to restore$(RESET)"

fix-boot: ## Fix common boot issues
	@echo "$(CYAN)🔧 Attempting to fix boot issues...$(RESET)"
	sudo systemctl set-default graphical.target
	sudo grub-mkconfig -o /boot/grub/grub.cfg 2>/dev/null || \
	sudo bootctl update 2>/dev/null || \
	echo "$(YELLOW)⚠️ Manual boot configuration may be needed$(RESET)"

# Performance modes
performance-mode: ## Enable maximum performance mode
	@echo "$(CYAN)🚀 Enabling performance mode...$(RESET)"
	./scripts/system-optimizer.sh --performance
	@echo "$(GREEN)✅ Performance mode enabled$(RESET)"

powersave-mode: ## Enable power saving mode
	@echo "$(CYAN)🔋 Enabling power save mode...$(RESET)"
	echo powersave | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
	@echo "$(GREEN)✅ Power save mode enabled$(RESET)"

# Monitoring
monitor: ## Show real-time system monitoring
	@echo "$(CYAN)📊 Starting system monitor...$(RESET)"
	htop

monitor-gpu: ## Show GPU monitoring (NVIDIA)
	@echo "$(CYAN)🎮 Starting GPU monitor...$(RESET)"
	watch -n 1 nvidia-smi

monitor-network: ## Show network monitoring
	@echo "$(CYAN)🌐 Starting network monitor...$(RESET)"
	sudo nethogs

# Quick fixes
quick-fix: ## Quick system fixes and optimizations
	@echo "$(CYAN)🔧 Running quick fixes...$(RESET)"
	sudo systemctl daemon-reload
	sudo systemctl restart NetworkManager
	./scripts/system-optimizer.sh --clean
	@echo "$(GREEN)✅ Quick fixes completed$(RESET)"

# Installation helpers
install-deps: ## Install development dependencies
	@echo "$(CYAN)📦 Installing development dependencies...$(RESET)"
	nix profile install nixpkgs#alejandra nixpkgs#nil nixpkgs#nixpkgs-fmt

# Documentation
docs: ## Generate system documentation
	@echo "$(CYAN)📚 Generating documentation...$(RESET)"
	mkdir -p docs
	{	echo "# NixOS 25.05 Configuration Documentation"; \
		echo ""; \
		echo "Generated on $$(date)"; \
		echo ""; \
		echo "## System Information"; \
		hostnamectl 2>/dev/null || true; \
		echo ""; \
		echo "## Flake Inputs"; \
		nix flake metadata --json | jq -r '.locks.nodes.root.inputs' 2>/dev/null || echo "Could not parse flake metadata"; \
		echo ""; \
		echo "## Available Commands"; \
		make help; \
	} > docs/system-overview.md
	@echo "$(GREEN)✅ Documentation generated in docs/system-overview.md$(RESET)"

# Status check
status: ## Show overall system status
	@echo "$(CYAN)📊 System Status Overview$(RESET)"
	@echo "=========================="
	@echo "$(GREEN)Hostname:$(RESET) $$(hostname)"
	@echo "$(GREEN)Uptime:$(RESET) $$(uptime -p)"
	@echo "$(GREEN)Load:$(RESET) $$(uptime | awk -F'load average:' '{print $$2}')"
	@echo "$(GREEN)Memory:$(RESET) $$(free -h | grep '^Mem:' | awk '{print $$3 "/" $$2}')"
	@echo "$(GREEN)Disk (/)$(RESET) $$(df -h / | awk 'NR==2 {print $$3 "/" $$2 " (" $$5 ")"}')"
	@echo "$(GREEN)Failed Services:$(RESET) $$(systemctl --failed --no-legend | wc -l)"
	@if command -v nvidia-smi >/dev/null 2>&1; then \
		echo "$(GREEN)GPU:$(RESET) $$(nvidia-smi --query-gpu=name,utilization.gpu,memory.used,memory.total --format=csv,noheader,nounits | head -1)"; \
	fi 