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

  programs.zoxide.enable = true;
  programs.yazi.enable = true;

  home.packages = with pkgs; [
    neovim
    nixd
    ghostty
    git
    tealdeer
    xclip
    bat
    ripgrep
    tree
    opencode
    claude-code
    google-chrome
  ];
}
