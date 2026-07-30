{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs-unstable = inputs.unstable.legacyPackages.${system};
  in {
    # NixOS configuration entrypoint
    nixosConfigurations = {
      piotr = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs; inherit pkgs-unstable;};
        # > Our main nixos configuration file <
        modules = [./machine/configuration.nix];
      };
    };

    # Standalone home-manager configuration entrypoint
    homeConfigurations = {
      "ptryb@piotr" = home-manager.lib.homeManagerConfiguration {
        # Home-manager requires 'pkgs' instance
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs;};
        # > Our main home-manager configuration file <
        modules = [./home/home.nix];
      };
    };
  };
}