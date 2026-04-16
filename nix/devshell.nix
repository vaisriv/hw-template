{ pkgs, perSystem, ... }:
perSystem.devshell.mkShell {
    name = "hw devshell";
    motd = ''
        {141}📚 hw{reset} devshell
        $(type -p menu &>/dev/null && menu)
    '';

    commands = [
        # python helpers
        {
            name = "py";
            category = "[python]";
            help = "run submission python script";
            command =
                # bash
                ''
                    CYAN="\e[0;36m"
                    NC="\e[0m"

                    cd $(git rev-parse --show-toplevel)

                    echo -e -n "$CYAN"
                    echo -e "running python script for $(basename $(pwd)):$NC"
                    python ./submission.py $@
                '';
        }
        {
            name = "tpy";
            category = "[python]";
            help = "type check submission python script";
            command =
                # bash
                ''
                    CYAN="\e[0;36m"
                    NC="\e[0m"

                    cd $(git rev-parse --show-toplevel)

                    echo -e -n "$CYAN"
                    echo -e "checking python script for $(basename $(pwd)):$NC"
                    ty check --python "$(which python3)" src $@
                '';
        }

        # latex helpers
        {
            name = "ltx";
            category = "[latex]";
            help = "compile submission latex doc";
            command =
                # bash
                ''
                    CYAN="\e[0;36m"
                    NC="\e[0m"

                    cd $(git rev-parse --show-toplevel)

                    echo -e -n "$CYAN"
                    echo -e "compiling latex document for $(basename $(pwd)):$NC"
                    latexmk $@
                '';
        }
        {
            name = "ltxw";
            category = "[latex]";
            help = "compile (and watch) submission latex doc";
            command =
                # bash
                ''
                    CYAN="\e[0;36m"
                    NC="\e[0m"

                    cd $(git rev-parse --show-toplevel)

                    echo -e -n "$CYAN"
                    echo -e "watching latex document for $(basename $(pwd)):$NC"
                    latexmk -pvc $@
                '';
        }
        {
            name = "ltxc";
            category = "[latex]";
            help = "clean-compile submission latex doc";
            command =
                # bash
                ''
                    BOLDCYAN="\e[1;36m"
                    CYAN="\e[0;36m"
                    NC="\e[0m"

                    cd $(git rev-parse --show-toplevel)

                    echo -e -n "$BOLDCYAN"
                    echo -e "clean-compiling latex document for $(basename $(pwd)):\n"
                    echo -e -n "$CYAN"
                    echo -e "removing old latex aux files:$NC"
                    latexmk -C

                    echo -e -n "$CYAN"
                    echo -e "compiling latex document:$NC"
                    latexmk $@
                '';
        }
        {
            name = "tltx";
            category = "[latex]";
            help = "type check submission latex doc";
            command =
                # bash
                ''
                    CYAN="\e[0;36m"
                    NC="\e[0m"

                    cd $(git rev-parse --show-toplevel)

                    echo -e -n "$CYAN"
                    echo -e "checking latex document for $(basename $(pwd)):$NC"
                    textidote reports/main.tex $@
                '';
        }
    ];

    packages = with pkgs; [
        # latex
        texlive.combined.scheme-full
        texlab
        textidote

        # python
        (python3.withPackages (
            ps: with ps; [
                # python packages here
                pandas
                matplotlib
                numpy
                scipy
                cartopy
            ]
        ))
        uv
        ty

        # font
        pkgs.nerd-fonts.iosevka-term
    ];
}
