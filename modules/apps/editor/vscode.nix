{ pkgs, ...} :
{
  home-manager.users.stefan = {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;    # You can skip this if you want to use the unfree version
      userSettings = {
        "terminal.integrated.fontFamily" = "'Source Code Pro for Powerline', 'Hack Nerd Font'";
        "workbench.colorTheme" = "Visual Studio Dark";
      };
      extensions = with pkgs.vscode-extensions; [
        dracula-theme.theme-dracula
        
        jnoortheen.nix-ide
        vscodevim.vim
        bbenoist.nix
        ms-python.vscode-pylance

        yzhang.markdown-all-in-one
        james-yu.latex-workshop

        timonwong.shellcheck
        donjayamanne.githistory

        ms-toolsai.jupyter
        ms-azuretools.vscode-docker
        ms-vscode.cpptools
      ];
    };
  };
}