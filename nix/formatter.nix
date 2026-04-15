{ pkgs, inputs, ... }:
inputs.treefmt-nix.lib.mkWrapper pkgs {
    projectRootFile = "flake.nix";

    # nix
    programs = {
        deadnix.enable = true;
        nixfmt = {
            enable = true;
            indent = 4;
            strict = true;
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
    programs.texfmt.enable = true;
    settings.formatter = {
        texfmt = {
            options = [
                "--nowrap"
                "--tabsize"
                "4"
            ];
        };
    };

    # python
    programs = {
        ruff-check.enable = true;
        ruff-format.enable = true;
    };
    settings.formatter = {
        ruff-check = {
            excludes = [
                "example/src/p*.py"
                "src/p*.py"
            ];
        };
        ruff-format = {
            excludes = [
                "example/src/p*.py"
                "src/p*.py"
            ];
        };
    };
}
