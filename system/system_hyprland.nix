{ config, pkgs, inputs, ... }:

{
    home-manager = {
        extraSpecialArgs = {inherit inputs;};
        backupFileExtension = "backup";
        users = {
            "ian" = import ../home_manager/home_hyprland.nix;
        };
    };

    hardware = {
        # Enable OpenGL
        graphics.enable = true;

        bluetooth = {
            enable = true;
            powerOnBoot = true;
        };

        nvidia = {
            modesetting.enable = true;
            powerManagement.enable = true;
            powerManagement.finegrained = false;
            open = false;
            nvidiaSettings = true;
            package = config.boot.kernelPackages.nvidiaPackages.latest;
            };
    };

    boot.kernelParams = [ "nvidia-drm.modeset=1" ];

    services = {
        # displayManager.ly.enable = true;
        greetd = {
            enable = true;               # start greetd on boot
            vt     = 1;                  # use first virtual terminal (DMs default)
            settings = {
                # tuigreet will show a menu of *all* desktop/wayland sessions
                # and remember the last one the user picked
                default_session = {
                    user    = "greeter";     # greetd auto‑creates this user
                    command = ''
                        ${pkgs.greetd.tuigreet}/bin/tuigreet \
                            --time --remember --remember-session \
                            --sessions /run/current-system/sw/share/wayland-sessions \
                            --cmd "${pkgs.uwsm}/bin/uwsm start -F -- ${pkgs.hyprland}/bin/Hyprland"
                    '';
                };
            };
        };

        pipewire = {
            wireplumber.enable = true;
            enable = true;
            alsa = {
                enable = true;
                support32Bit = true;
            };
            pulse.enable = true;
            jack.enable = true;
        };

        xserver = {
            enable = true;
            videoDrivers = ["nvidia"];
        };
    };

    services.gnome.gnome-keyring.enable = true;
    security.pam.services.login.enableGnomeKeyring = true;
    security.pam.services.hyprlock.enableGnomeKeyring = true;

    networking.wireless.iwd.enable = true;

    programs = {
        hyprland = {
            enable = true;
            withUWSM = true;
            xwayland.enable = true;
        };

        nh = {
            enable = true;
            clean.enable = true;
            clean.extraArgs = "--keep-since 4d --keep 3";
            flake = "/etc/nixos/";
        };

        uwsm = {
            enable = true;          # ← THIS is what actually writes the .desktop file
        };
    };

    # Packages
    environment.systemPackages = with pkgs; [
        # hyprland
        hypridle
        hyprlock
        hyprpaper
        hyprpicker
        hyprshot

        # networking tui
        impala
        bluetui

        kitty
        ly
        mako
        swayosd
        waybar
        udiskie
        rofi-wayland
        yazi




    ];
}
