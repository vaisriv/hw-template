{
    pkgs,
    perSystem,
    ...
}:
perSystem.devshell.mkShell {
    name = "hw devshell";
    motd = ''
        {141}📚 hw{reset} devshell
        $(type -p menu &>/dev/null && menu)
    '';

    commands = [
        # python helper
        {
            name = "py";
            category = "[submission]";
            help = "run submission python script";
            command =
                # bash
                ''
                    CYAN="\e[0;36m"
                    NC="\e[0m"

                    cd $(git rev-parse --show-toplevel)

                    echo -e -n "$CYAN"
                    echo -e "running python script for $(basename $(pwd)):$NC"
                    python ./submission.py
                '';
        }

        # latex helpers
        {
            name = "ltx";
            category = "[submission]";
            help = "compile submission latex doc";
            command =
                # bash
                ''
                    CYAN="\e[0;36m"
                    NC="\e[0m"

                    cd $(git rev-parse --show-toplevel)

                    echo -e -n "$CYAN"
                    echo -e "compiling latex document for $(basename $(pwd)):$NC"
                    latexmk
                '';
        }
        {
            name = "ltxc";
            category = "[submission]";
            help = "clean-compile submission latex doc";
            command =
                # bash
                ''
                    BOLDCYAN="\e[1;36m"
                    CYAN="\e[0;36m"
                    NC="\e[0m"

                    cd $(git rev-parse --show-toplevel)

                    echo -e -n "$BOLDCYAN"
                    echo -e "compiling latex document for $(basename $(pwd)):\n"
                    echo -e -n "$CYAN"
                    echo -e "removing old latex aux files:$NC"
                    latexmk -C

                    echo -e -n "$CYAN"
                    echo -e "compiling latex document:$NC"
                    latexmk
                '';
        }
    ];

    packages = with pkgs; [
        # latex
        texlive.combined.scheme-full
        texlab

        # python
        (python3.withPackages (ps:
            with ps; [
                # python packages here
                matplotlib
                numpy
                scipy
                cartopy
            ]))
    ];
}
