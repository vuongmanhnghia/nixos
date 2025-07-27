{ config, pkgs, ... }:

{
  # === WLOGOUT CONFIGURATION (ViegPhunt Style) ===
  
  # Create Wlogout configuration directory
  home.file.".config/wlogout/layout" = {
    text = ''
      {
          "label": "lock",
          "action": "hyprlock",
          "text": "Lock",
      }

      {
          "label": "suspend",
              "action": "systemctl suspend",
              "text": "Suspend",
      }

      {
          "label": "shutdown",
              "action": "systemctl poweroff",
              "text": "Shutdown",
      }

      {
          "label": "reboot",
              "action": "systemctl reboot",
              "text": "Reboot",
      }

      {
          "label": "logout",
              "action": "hyprctl dispatch exit 0",
              "text": "Logout",
      }
    '';
  };
  
  # Create Wlogout style with Catppuccin colors
  home.file.".config/wlogout/style.css" = {
    text = ''
      @define-color background #1e1e2e;
      @define-color foreground #cdd6f4;
      @define-color select     #585b70;
      
      @define-color pink       #f5c2e7;
      @define-color purple     #cba6f7;
      @define-color red        #f38ba8;
      @define-color orange     #fab387;
      @define-color yellow     #f9e2af;
      @define-color green      #a6e3a1;
      @define-color blue       #89b4fa;
      @define-color gray       #45475a;

      @keyframes glowing {
          0% {
              box-shadow: 0 0 30px @pink;
          }
          20% {
              box-shadow: 0 0 30px @pink;
          }
          80% {
              box-shadow: 0 0 30px @foreground;
          }
          100% {
              box-shadow: 0 0 30px @blue;
          }
      }

      * {
          background-image: none;
          font-family: "JetBrainsMono Nerd Font";
          transition: 20ms;
      }

      window {
          background: rgba(0, 0, 0, 0.3);
          font-size: 0px;
      }

      button {
          background: transparent;
          outline-style: none;
          border: none;
          border-width: 0px;
          background-repeat: no-repeat;
          background-position: center;
          background-size: 50%;
          border-radius: 60px;
          box-shadow: none;
          text-shadow: none;
          animation: gradient_f 10s ease-in infinite;
      }

      button:hover {
          background-size: 60%;
          animation: glowing 1s infinite alternate;
          outline-style: none;
      }

      #lock {
          background-image: image(url("./icons/lock.png"));
      }

      #suspend {
          background-image: image(url("./icons/suspend.png"));
      }

      #shutdown {
          background-image: image(url("./icons/shutdown.png"));
      }

      #reboot {
          background-image: image(url("./icons/reboot.png"));
      }

      #logout {
          background-image: image(url("./icons/logout.png"));
      }
    '';
  };
} 