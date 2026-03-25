{ pkgs, config, ... }: {

  home.username = "janma";
  home.homeDirectory = "/home/janma";
  home.stateVersion = "25.11";

  dconf.settings = {
    "org/gnome/desktop/input-sources" = {
      xkb-options = [ "caps:escape" ];
    };
  };

  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink /home/janma/nixconfig/dotfiles/nvim;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Senshyi";
        email = "janmachacek97@gmail.com";
      };
    };
  };

  programs.zoxide.enable = true;
  programs.yazi.enable = true;

  home.packages = with pkgs; [
    nixd
    ghostty
    tealdeer
    wl-clipboard
    bat
    ripgrep
    tree
    opencode
    claude-code
    google-chrome
  ];
}
