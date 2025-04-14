{ pkgs, inputs, ... }:

{
  # Import impermanence integration for home-manager.
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  # Set the home-manager state version (do not change unless you know why).
  home.stateVersion = "24.11";

  # Home persistence configuration: list all directories and files you want to persist.
  home.persistence."/persist/home" = {
    directories = [
      "Downloads"
      "Music"
      "Pictures"
      "Documents"
      "Videos"
      ".ssh"
      ".config/zed"

      # Gnome
      ".config/dconf"
      ".local/share/keyrings"
      ".config/google-chrome"
      
      {
        directory = ".local/share/Steam";
        method = "symlink";
      }
      {
        directory = ".local/share/zed";
        method = "symlink";
      }
    ];
    files = [ 
      ".screenrc" 
      ".config/monitors.xml"
    ];
    allowOther = true;
  };

  # Enable dconf to manage GNOME settings
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";  # Preferred color scheme
      gtk-theme = "Adwaita-dark";    # Set GTK theme to Adwaita-dark
    };
  };

  # Configure GTK settings
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    cursorTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };

    # Tells GTK 3 to prefer a dark theme variant
    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
  };

  programs.ssh.enable = true;

  programs.git = {
    enable = true;
    userName  = "ian";
    userEmail = "ian.page38@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      safe.directory = "/etc/nixos";
    };
  };
}
