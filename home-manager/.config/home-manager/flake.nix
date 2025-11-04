{
  description = "Home Manager configuration of mikhail";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixGL = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    }; 
  };

outputs = {
    self,
    nixpkgs,
    home-manager,
    nixGL,
    ...
  }: {
    # Replace with your own username
    homeConfigurations."mikhail" = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config = {
          allowUnfree = true;
          allowUnfreePredicate = _: true;
        };
      };
      extraSpecialArgs = {
        inherit nixGL;
      };
      modules = [./home.nix];
    };
  };
}
