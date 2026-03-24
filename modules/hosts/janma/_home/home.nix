{ pkgs, ... }: {

  home.username = "janma";
  home.homeDirectory = "/home/janma";
  home.stateVersion = "25.11";

  dconf.settings = {
    "org/gnome/desktop/input-sources" = {
      xkb-options = [ "caps:escape" ];
    };
  };

  programs.zoxide.enable = true;
  programs.yazi.enable = true;

  home.packages = with pkgs; [
    neovim
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
