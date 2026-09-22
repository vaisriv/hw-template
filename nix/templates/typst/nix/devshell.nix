{ pkgs, perSystem, ... }:
perSystem.devshell.mkShell {
    name = "<HW_ASSIGNMENT> devshell";
    motd = ''
        {141}📚 <HW_ASSIGNMENT>{reset} devshell
        $(type -p menu &>/dev/null && menu)
    '';

    commands = [
        # helpers
        ## python
        {
            name = "pyr";
            category = "[python]";
            help = "run";
            command = "python ./submission.py $@";
        }
        {
            name = "pyl";
            category = "[python]";
            help = "lsp";
            # command = "ty check --python '$(which python3)' src $@";
            command = "uvx ruff check src $@";
        }
        ## typst
        {
            name = "typ";
            category = "[typst]";
            help = "preview";
            command = "tinymist preview reports/main.typ --root=.";
        }
        {
            name = "tyl";
            category = "[typst]";
            help = "lsp";
            command = "tinymist test --no-dashboard --ignore-system-fonts --watch reports/main.typ --root=.";
        }
        {
            name = "tyc";
            category = "[typst]";
            help = "compile";
            # command = "nix run .#report";
            command = "tinymist compile reports/main.typ --root=.";
        }
    ];

    packages = with pkgs; [
        # python
        (python3.withPackages (
            ps: with ps; [
                # python packages here
                pandas
                matplotlib
                numpy
                scipy
            ]
        ))
        uv
        ty

        # typst
        tinymist
    ];

    env = [
        {
            name = "TYPST_FONT_PATHS";
            prefix =
                with pkgs;
                lib.makeSearchPath "share/fonts/opentype" [
                    newcomputermodern
                    tex-gyre.cursor
                    tex-gyre.termes
                    nerd-fonts.iosevka-term
                ];
        }
    ];
}
