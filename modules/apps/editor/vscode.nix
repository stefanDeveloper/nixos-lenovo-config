{ pkgs, ... }:
{
  home-manager.users.stefan = {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium; # You can skip this if you want to use the unfree version
      userSettings = {
        "terminal.integrated.fontFamily" = "'Source Code Pro for Powerline', 'Hack Nerd Font'";
        "workbench.colorTheme" = "Visual Studio Dark";

        "latex-workshop.view.pdf.viewer" = "tab";

        "files.associations" = {
          "**/.i3/config" = "i3";
          "**/i3/config" = "i3";
          "**/i3/config/*" = "i3";
        };

        "[nix]" = {
          "editor.defaultFormatter" = "B4dM4n.nixpkgs-fmt";
        };
        "yaml.customTags" = [
          "!Equals sequence"
          "!FindInMap sequence"
          "!GetAtt"
          "!GetAZs"
          "!ImportValue"
          "!Join sequence"
          "!Ref"
          "!Select sequence"
          "!Split sequence"
          "!Sub"
          "!vault"
        ];
        "java.jdt.ls.java.home" = "${pkgs.jdk11}";
        "redhat.telemetry.enabled" = false;
        "workbench.iconTheme" = "material-icon-theme";
        "clangd.detectExtensionConflicts" = false;

        "latex-workshop.latex.tools" = [
          {
              "name"= "latexmk";
              "command"= "latexmk";
              "args"= [
                  "-shell-escape"
                  "-synctex=1"
                  "-interaction=nonstopmode"
                  "-file-line-error"
                  "-pdf"
                  "-outdir=%OUTDIR%"
                  "%DOC%"
              ];
              "env"= {};
          }
        ];
      };
      extensions = (with pkgs.vscode-extensions; [
        dracula-theme.theme-dracula

        llvm-vs-code-extensions.vscode-clangd

        jnoortheen.nix-ide
        # vscodevim.vim 
        bbenoist.nix
        ms-python.vscode-pylance

        yzhang.markdown-all-in-one
        james-yu.latex-workshop

        timonwong.shellcheck
        donjayamanne.githistory

        ms-toolsai.jupyter
        ms-azuretools.vscode-docker
        ms-vscode.cpptools
        ms-vscode.cmake-tools

        redhat.java
        redhat.vscode-yaml

        twxs.cmake

        bierner.emojisense
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
        {
          name = "python";
          publisher = "ms-python";
          version = "2022.2.1924087327";
          sha256 = "JksPDcFpi8+JD9BDBhb6cbU0hRbNVbO/ABflOKZctWM=";
        }
        {
          name = "nix-env-selector";
          publisher = "arrterian";
          version = "1.0.7";
          sha256 = "DnaIXJ27bcpOrIp1hm7DcrlIzGSjo4RTJ9fD72ukKlc=";
        }
        {
          name = "dotenv";
          publisher = "mikestead";
          version = "1.0.1";
          sha256 = "dieCzNOIcZiTGu4Mv5zYlG7jLhaEsJR05qbzzzQ7RWc=";
        }
        {
          name = "markdown-preview-enhanced";
          publisher = "shd101wyy";
          version = "0.6.2";
          sha256 = "tjRXAoUS63d2hsiL2a528+hQeal8pKP1eTnkf/qiUQo=";
        }
        {
          name = "material-icon-theme";
          publisher = "PKief";
          version = "4.14.1";
          sha256 = "OHXi0EfeyKMeFiMU5yg0aDoWds4ED0lb+l6T12XZ3LQ=";
        }
        {
          name = "nixpkgs-fmt";
          publisher = "B4dM4n";
          version = "0.0.1";
          sha256 = "vz2kU36B1xkLci2QwLpl/SBEhfSWltIDJ1r7SorHcr8=";
        }
        {
          name = "i3";
          publisher = "dcasella";
          version = "0.0.1";
          sha256 = "Mn1QnwFOC5Gy9jnXJsoKt5S6/aKUJjxni4PR8RTVZlM=";
        }
        {
          name = "jinjahtml";
          publisher = "samuelcolvin";
          version = "0.17.0";
          sha256 = "Kxzsv1P2tS9Nme8L2D/ZJn15syKynxeyBmq/n9VCH4g=";
        }
        {
          name = "vscode-xml";
          publisher = "redhat";
          version = "0.20.0";
          sha256 = "GKBrf9s8n7Wv14RSfwyDma1dM0fGMvRkU/7v2DAcB9A=";
        }
      ];
    };
  };
}
