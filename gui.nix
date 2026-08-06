{ pkgs, config, ... }:
{
    environment.systemPackages = with pkgs; [
      grim 
      slurp 
      wl-clipboard 
      mako 
      #swaylock 
      wofi 
      i3status-rust 
      networkmanagerapplet 
    ];

    programs.gnupg.agent.pinentryPackage = pkgs.pinentry-curses;
    programs.nm-applet.enable = true;

    services.gnome.gnome-keyring.enable = true;

    programs.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd sway";
          user = "greeter";
        };
      };
    };
}