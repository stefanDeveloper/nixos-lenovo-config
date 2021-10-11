{ stdenv, fetchgit, writeTextFile }:

let
  config_file = writeTextFile {
    name = "ibm.plymouth";
    text = ''
      [Plymouth Theme]
      Name=ibm
      Description=display kinda fireworks
      Comment=created By Aditya Shakya (@adi1090x)
      ModuleName=script

      [script]
      ImageDir=etc/plymouth/themes/ibm
      ScriptFile=etc/plymouth/themes/ibm/ibm.script
    '';
  };
in stdenv.mkDerivation rec {
  name = "ibm";

  src = fetchGit {
    url = "https://github.com/adi1090x/plymouth-themes";
    rev = "bf2f570bee8e84c5c20caac353cbe1d811a4745f";
  };

  buildInputs = [ stdenv ];

  configurePhase = ''
    install_path=$out/share/plymouth/themes/
    mkdir -p $install_path
  '';

  buildPhase = ''
    substitute ${config_file} "pack_3/ibm/ibm.plymouth"
  '';

  installPhase = ''
    cd pack_3 && cp -r ibm $install_path
  '';

  meta = with stdenv.lib; { platfotms = platforms.linux; };
}
