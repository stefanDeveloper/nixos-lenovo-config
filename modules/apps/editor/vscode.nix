{ pkgs, ...} :
{
  home-manager.users.stefan = {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;    # You can skip this if you want to use the unfree version
      userSettings = {
        "terminal.integrated.fontFamily" = "'Source Code Pro for Powerline', 'Hack Nerd Font'";
        "workbench.colorTheme" = "Visual Studio Dark";

        "files.associations" = {
            "**/.i3/config" = "i3";
            "**/i3/config" = "i3";
            "**/i3/config/*" = "i3";
        };
      };
      extensions = (with pkgs.vscode-extensions; [
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
      ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "remote-ssh-edit";
          publisher = "ms-vscode-remote";
          version = "0.47.2";
          sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
        }
        {
          name = "ansible";
          publisher = "redhat";
          version = "0.8.1";
          sha256 = "Vum9R2af7ERAFZ5D8AWbeOGvPbGZ/lI4ZS562T/uiM0=";
        }
      ];
    };
  };
}