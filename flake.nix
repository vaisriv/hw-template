{
    description = "hw flake";

    inputs = {
        # nixpkgs
        nixpkgs.url = "github:nixos/nixpkgs/release-25.11";
        # nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

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

    outputs = inputs:
        inputs.blueprint {
            inherit inputs;
            prefix = "./nix/";
        };
}
