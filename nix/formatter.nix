{
    pkgs,
    inputs,
    ...
}:
inputs.treefmt-nix.lib.mkWrapper pkgs {
    projectRootFile = "flake.nix";

    # nix
    programs = {
        deadnix.enable = true;
        nixfmt = {
            enable = true;
            indent = 4;
        };
    };

    # md
    programs.prettier = {
        enable = true;
        settings = {
            tabWidth = 4;
        };
    };

    # latex
    programs = {
        latexindent.enable = true;
    };

    # python
    programs = {
        ruff-check.enable = true;
        ruff-format.enable = true;
    };
}
