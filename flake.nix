{
  description = "nixos-config";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    grub2-themes.url = github:vinceliuice/grub2-themes;
    emacs-overlay.url = github:nix-community/emacs-overlay;
    nur.url = github:nix-community/NUR;
    nix-doom-emacs.url = github:nix-community/nix-doom-emacs;
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur-pkgs = {
      url = github:ocfox/nur-pkgs;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nur,
    home-manager,
    nur-pkgs,
    nix-doom-emacs,
    grub2-themes,
    emacs-overlay,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    username = "ocfox";
  in {
    nixosConfigurations.whitefox = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        grub2-themes.nixosModule
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = nixpkgs.lib.mkMerge [
            {
              imports = [ nix-doom-emacs.hmModule ];
            }
            ./home.nix
          ];
        }
        {
          nixpkgs.overlays = [
            (final: prev: {
              nur-pkgs = inputs.nur-pkgs.packages."${prev.system}";
            })
            nur.overlay
            emacs-overlay.overlay
          ];
        }
      ];
      specialArgs = {inherit inputs;};
    };
  };
}
