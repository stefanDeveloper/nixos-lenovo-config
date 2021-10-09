{
    virtualisation = {
        virtualbox.host.enable = true;
        docker = {
            enable = true;

            autoPrune = {
                enable = true;
                dates = "weekly";
            };
        };
    };
}