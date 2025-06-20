{
  description = "Professional NixOS 25.05 Configuration - Nagih's Setup";

  inputs = {
    # Main nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # Hardware support
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    
    # Secrets management
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # Gaming optimizations
    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # VSCode extensions
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # Better dev shells
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { 
    self, 
    nixpkgs, 
    nixpkgs-unstable,
    home-manager, 
    nixos-hardware,
    sops-nix,
    nix-gaming,
    nix-vscode-extensions,
    devshell,
    ... 
  }@inputs: 
  let
    system = "x86_64-linux";
    
    # Overlay for unstable packages
    overlay-unstable = final: prev: {
      unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    };
    
    # Common specialArgs for all configurations
    specialArgs = {
      inherit inputs;
      inherit system;
    };
    
  in {
    # NixOS Configurations
    nixosConfigurations = {
      # Desktop configuration
      nixos = nixpkgs.lib.nixosSystem {
        inherit system specialArgs;
        modules = [
          ({ config, pkgs, ... }: {
            nixpkgs.overlays = [ overlay-unstable ];
          })
          
          # System configuration
          ./hosts/desktop/configuration.nix
          ./hosts/desktop/hardware-configuration.nix
          
          # Hardware support (if needed)
          # nixos-hardware.nixosModules.common-gpu-nvidia
          
          # Secrets management
          sops-nix.nixosModules.sops
          
          # Gaming support
          nix-gaming.nixosModules.pipewireLowLatency
          
          # Home Manager integration
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              
              extraSpecialArgs = specialArgs // {
                extensions = nix-vscode-extensions.extensions.${system};
              };
              
              users = {
                nagih = import ./home/users/nagih;
              };
            };
          }
        ];
      };
    };
    
    # Development shells
    devShells.${system} = {
      default = devshell.devShells.${system}.default;
      
      # Web development shell
      web = nixpkgs.legacyPackages.${system}.mkShell {
        name = "web-dev";
        buildInputs = with nixpkgs.legacyPackages.${system}; [
          nodejs_20
          yarn
          typescript
        ];
      };
      
      # Python development shell
      python = nixpkgs.legacyPackages.${system}.mkShell {
        name = "python-dev";
        buildInputs = with nixpkgs.legacyPackages.${system}; [
          python311
          python311Packages.pip
          python311Packages.virtualenv
        ];
      };
    };
    
    # Packages
    packages.${system} = {
      # Custom packages can go here
    };
    
    # Formatting
    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
  };
}
