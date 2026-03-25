{ self, inputs, ... }: {
  flake.nixosModules.niri = { pkgs, lib, ... }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };

    security.pam.services.noctalia-shell = {};
  };

  perSystem = { pkgs, lib, self', ... }: {
    packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;
      settings = {
        spawn-at-startup = [
          (lib.getExe self'.packages.myNoctalia)
        ];
        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;
        input.keyboard.xkb = {
          layout = "us";
          options = "caps:escape";
        };
        layout = {
          gaps = 8;
          focus-ring.width = 2;
        };
        binds = {
          # Programs
          "Mod+Return".spawn-sh = lib.getExe pkgs.ghostty;
          "Mod+D".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle";
          "Mod+Q".close-window = null;

          # Focus
          "Mod+H".focus-column-left = null;
          "Mod+L".focus-column-right = null;
          "Mod+J".focus-window-down = null;
          "Mod+K".focus-window-up = null;

          # Move windows
          "Mod+Shift+H".move-column-left = null;
          "Mod+Shift+L".move-column-right = null;
          "Mod+Shift+J".move-window-down = null;
          "Mod+Shift+K".move-window-up = null;

          # Workspaces
          "Mod+1".focus-workspace = 1;
          "Mod+2".focus-workspace = 2;
          "Mod+3".focus-workspace = 3;
          "Mod+4".focus-workspace = 4;
          "Mod+5".focus-workspace = 5;
          "Mod+Shift+1".move-window-to-workspace = 1;
          "Mod+Shift+2".move-window-to-workspace = 2;
          "Mod+Shift+3".move-window-to-workspace = 3;
          "Mod+Shift+4".move-window-to-workspace = 4;
          "Mod+Shift+5".move-window-to-workspace = 5;

          # Layout
          "Mod+R".switch-preset-column-width = null;
          "Mod+F".maximize-column = null;
          "Mod+Shift+F".fullscreen-window = null;
          "Mod+Comma".consume-window-into-column = null;
          "Mod+Period".expel-window-from-column = null;

          # Screenshot
          "Print".screenshot = null;
          "Mod+Print".screenshot-window = null;

          # Session
          "Mod+Shift+E".quit = null;
          "Mod+Shift+Slash".show-hotkey-overlay = null;
          "Mod+Escape".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call lockscreen lock";

          # Media keys
          "XF86AudioRaiseVolume".spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
          "XF86AudioLowerVolume".spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
          "XF86AudioMute".spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          "XF86MonBrightnessUp".spawn-sh = "${lib.getExe pkgs.brightnessctl} set 5%+";
          "XF86MonBrightnessDown".spawn-sh = "${lib.getExe pkgs.brightnessctl} set 5%-";
          "XF86AudioPlay".spawn-sh = "${lib.getExe pkgs.playerctl} play-pause";
          "XF86AudioNext".spawn-sh = "${lib.getExe pkgs.playerctl} next";
          "XF86AudioPrev".spawn-sh = "${lib.getExe pkgs.playerctl} previous";
        };
      };
    };
  };
}
