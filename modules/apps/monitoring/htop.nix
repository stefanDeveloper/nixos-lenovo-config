{
  home-manager.users.stefan = {
    programs.htop = {
      enable = true;
      settings = {
        vimMode = true;
        delay = 5;
        showCpuFrequency = true;
        showCpuUsage = true;
        treeView = true;
        hideUserlandThreads = true;
        sort_direction = true;
        sort_key = "PERCENT_CPU";
      };
    };
  };
}
