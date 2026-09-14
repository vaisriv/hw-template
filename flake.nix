{
    description = "<HW_ASSIGNMENT> flake";

    inputs = {
        # nixpkgs
        # WARN: python3xxPackages.cartopy broken on release-26.05
        # nixpkgs.url = "github:nixos/nixpkgs/release-26.05";
        nixpkgs.url = "github:nixos/nixpkgs/staging-next";
        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

        # flake tools (thanks numtide)
        blueprint = {
            url = "github:numtide/blueprint";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        devshell = {
            url = "github:numtide/devshell";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        treefmt-nix = {
            url = "github:numtide/treefmt-nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs =
        inputs:
        inputs.blueprint {
            inherit inputs;
            prefix = "./nix/";
        };
}
