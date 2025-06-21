{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix

          home-manager.nixosModules.home-manager # Home Manager module
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            
            # Multiple users configuration
            home-manager.users = {
              nagih = import ./home/profiles/nagih.nix;
            };
            
            # Backup files instead of failing
            home-manager.backupFileExtension = "backup";
          }
        ];
      };
    };
  };
}
