# Matugen configuration for NixOS
# Add this to your home-manager configuration

{ config, pkgs, lib, ... }:

{
  # Install matugen package
  home.packages = with pkgs; [
    matugen
  ];

  # Create matugen config directory and files
  home.file = {
    # Main configuration file
    ".config/matugen/config.toml".text = ''
      [config.wallpaper]
      command = "swww"
      arguments = ["img", "--transition-type", "any", "--transition-fps", "60"]
      set = true

      [templates.waybar]
      input_path = '~/.config/matugen/templates/colors.css'
      output_path = '~/.config/waybar/colors.css'
      post_hook = 'pkill -SIGUSR2 waybar'

      [templates.swaync]
      input_path = '~/.config/matugen/templates/colors.css'
      output_path = '~/.config/swaync/colors.css'
      post_hook = 'pkill -SIGUSR2 swaync'

      [templates.kitty]
      input_path = '~/.config/matugen/templates/kitty-colors.conf'
      output_path = '~/.config/kitty/colors.conf'
      post_hook = "kill -SIGUSR1 $(pidof kitty)"

      [templates.hyprland]
      input_path = '~/.config/matugen/templates/hyprland-colors.conf'
      output_path = '~/.config/hypr/colors.conf'
      post_hook = 'hyprctl reload'

      [templates.gtk3]
      input_path = '~/.config/matugen/templates/gtk-colors.css'
      output_path = '~/.config/gtk-3.0/colors.css'

      [templates.gtk4]
      input_path = '~/.config/matugen/templates/gtk-colors.css'
      output_path = '~/.config/gtk-4.0/colors.css'

      [templates.rofi]
      input_path = '~/.config/matugen/templates/rofi-colors.rasi'
      output_path = '~/.config/rofi/colors.rasi'

      [templates.cava]
      input_path = '~/.config/matugen/templates/matugen-cava'
      output_path = '~/.config/cava/config'
      post_hook = "pkill -USR1 cava"

      [templates.spicetify]
      input_path = '~/.config/matugen/templates/spotify-colors.ini'
      output_path = '~/.config/spicetify/Themes/text/color.ini'

      [templates.vesktop]
      input_path = '~/.config/matugen/templates/midnight-discord.css'
      output_path = '~/.config/vesktop/themes/matugen.css'
    '';

    # Template: General CSS colors
    ".config/matugen/templates/colors.css".text = ''
      /*
      * Css Colors
      * Generated with Matugen
      */
      <* for name, value in colors *>
          @define-color {{name}} {{value.default.hex}};
      <* endfor *>
    '';

    # Template: GTK colors
    ".config/matugen/templates/gtk-colors.css".text = ''
      /*
      * GTK Colors
      * Generated with Matugen
      */

      @define-color accent_color {{colors.primary_fixed_dim.default.hex}};
      @define-color accent_fg_color {{colors.on_primary_fixed.default.hex}};
      @define-color accent_bg_color {{colors.primary_fixed_dim.default.hex}};
      @define-color window_bg_color {{colors.surface_dim.default.hex}};
      @define-color window_fg_color {{colors.on_surface.default.hex}};
      @define-color headerbar_bg_color {{colors.surface_dim.default.hex}};
      @define-color headerbar_fg_color {{colors.on_surface.default.hex}};
      @define-color popover_bg_color {{colors.surface_dim.default.hex}};
      @define-color popover_fg_color {{colors.on_surface.default.hex}};
      @define-color view_bg_color {{colors.surface.default.hex}};
      @define-color view_fg_color {{colors.on_surface.default.hex}};
      @define-color card_bg_color {{colors.surface.default.hex}};
      @define-color card_fg_color {{colors.on_surface.default.hex}};
      @define-color sidebar_bg_color @window_bg_color;
      @define-color sidebar_fg_color @window_fg_color;
      @define-color sidebar_border_color @window_bg_color;
      @define-color sidebar_backdrop_color @window_bg_color;
    '';

    # Template: Hyprland colors
    ".config/matugen/templates/hyprland-colors.conf".text = ''
      <* for name, value in colors *>
      $image = {{image}}
      $${"{{"}name${"}}"} = rgba({{value.default.hex_stripped}}ff)
      <* endfor *>
    '';

    # Template: Kitty colors
    ".config/matugen/templates/kitty-colors.conf".text = ''
      cursor {{colors.on_surface.default.hex}}
      cursor_text_color {{colors.on_surface_variant.default.hex}}

      foreground            {{colors.on_surface.default.hex}}
      background            {{colors.surface.default.hex}}
      selection_foreground  {{colors.on_secondary.default.hex}}
      selection_background  {{colors.secondary_fixed_dim.default.hex}}
      url_color             {{colors.primary.default.hex}}

      # black
      color8   #262626
      color0   #4c4c4c

      # red
      color1   #ac8a8c
      color9   #c49ea0

      # green
      color2   #8aac8b
      color10  #9ec49f

      # yellow
      color3   #aca98a
      color11  #c4c19e

      # blue
      /* color4  #8f8aac */
      color4  {{colors.primary.default.hex}}
      color12 #a39ec4

      # magenta
      color5   #ac8aac
      color13  #c49ec4

      # cyan
      color6   #8aacab
      color14  #9ec3c4

      # white
      color15   #e7e7e7
      color7  #f0f0f0
    '';

    # Template: Rofi colors
    ".config/matugen/templates/rofi-colors.rasi".text = ''
      * {
          primary: {{colors.primary.default.hex}}; 
          primary-fixed: {{colors.primary_fixed.default.hex}}; 
          primary-fixed-dim: {{colors.primary_fixed_dim.default.hex}}; 
          on-primary: {{colors.on_primary.default.hex}}; 
          on-primary-fixed: {{colors.on_primary_fixed.default.hex}}; 
          on-primary-fixed-variant: {{colors.on_primary_fixed_variant.default.hex}}; 
          primary-container: {{colors.primary_container.default.hex}}; 
          on-primary-container: {{colors.on_primary_container.default.hex}}; 
          secondary: {{colors.secondary.default.hex}}; 
          secondary-fixed: {{colors.secondary_fixed.default.hex}}; 
          secondary-fixed-dim: {{colors.secondary_fixed_dim.default.hex}}; 
          on-secondary: {{colors.on_secondary.default.hex}}; 
          on-secondary-fixed: {{colors.on_secondary_fixed.default.hex}}; 
          on-secondary-fixed-variant: {{colors.on_secondary_fixed_variant.default.hex}}; 
          secondary-container: {{colors.secondary_container.default.hex}}; 
          on-secondary-container: {{colors.on_secondary_container.default.hex}}; 
          tertiary: {{colors.tertiary.default.hex}}; 
          tertiary-fixed: {{colors.tertiary_fixed.default.hex}}; 
          tertiary-fixed-dim: {{colors.tertiary_fixed_dim.default.hex}}; 
          on-tertiary: {{colors.on_tertiary.default.hex}}; 
          on-tertiary-fixed: {{colors.on_tertiary_fixed.default.hex}}; 
          on-tertiary-fixed-variant: {{colors.on_tertiary_fixed_variant.default.hex}}; 
          tertiary-container: {{colors.tertiary_container.default.hex}}; 
          on-tertiary-container: {{colors.on_tertiary_container.default.hex}}; 
          error: {{colors.error.default.hex}}; 
          on-error: {{colors.on_error.default.hex}}; 
          error-container: {{colors.error_container.default.hex}}; 
          on-error-container: {{colors.on_error_container.default.hex}}; 
          surface: {{colors.surface.default.hex}}; 
          on-surface: {{colors.on_surface.default.hex}}; 
          on-surface-variant: {{colors.on_surface_variant.default.hex}}; 
          outline: {{colors.outline.default.hex}}; 
          outline-variant: {{colors.outline_variant.default.hex}}; 
          shadow: {{colors.shadow.default.hex}}; 
          scrim: {{colors.scrim.default.hex}}; 
          inverse-surface: {{colors.inverse_surface.default.hex}}; 
          inverse-on-surface: {{colors.inverse_on_surface.default.hex}}; 
          inverse-primary: {{colors.inverse_primary.default.hex}}; 
          surface-dim: {{colors.surface_dim.default.hex}}; 
          surface-bright: {{colors.surface_bright.default.hex}}; 
          surface-container-lowest: {{colors.surface_container_lowest.default.hex}}; 
          surface-container-low: {{colors.surface_container_low.default.hex}}; 
          surface-container: {{colors.surface_container.default.hex}}; 
          surface-container-high: {{colors.surface_container_high.default.hex}}; 
          surface-container-highest: {{colors.surface_container_highest.default.hex}}; 
      }
    '';

    # Template: Spotify/Spicetify colors
    ".config/matugen/templates/spotify-colors.ini".text = ''
      [Spicetify]
      accent             = {{ colors.on_surface.default.hex_stripped }}
      accent-active      = {{ colors.secondary_container.default.hex_stripped }}
      accent-inactive    = {{ colors.surface.default.hex_stripped }}
      banner             = {{ colors.on_surface.default.hex_stripped }}
      border-active      = {{ colors.outline.default.hex_stripped }}
      border-inactive    = {{ colors.outline_variant.default.hex_stripped }}
      header             = {{ colors.on_surface.default.hex_stripped }}
      highlight          = {{ colors.surface_container_low.default.hex_stripped }}
      main               = {{ colors.surface.default.hex_stripped }}
      notification       = {{ colors.tertiary.default.hex_stripped }}
      notification-error = {{ colors.error.default.hex_stripped }}
      subtext            = {{ colors.on_surface_variant.default.hex_stripped }}
      text               = {{ colors.on_surface.default.hex_stripped }}
    '';

    # Template: Cava configuration
    ".config/matugen/templates/matugen-cava".text = ''
      #  ┳┳┓┏┓┏┳┓┳┳┏┓┏┓┳┓  ┏┓┏┓┓┏┏┓
      #  ┃┃┃┣┫ ┃ ┃┃┃┓┣ ┃┃━━┃ ┣┫┃┃┣┫
      #  ┛ ┗┛┗ ┻ ┗┛┗┛┗┛┛┗  ┗┛┛┗┗┛┛┗
      #                            

      ## Configuration file for CAVA.
      # Remove the ; to change parameters.

      [general]

      # Smoothing mode. Can be 'normal', 'scientific' or 'waves'. DEPRECATED as of 0.6.0
      ; mode = normal

      # Accepts only non-negative values.
      ; framerate = 60

      # 'autosens' will attempt to decrease sensitivity if the bars peak. 1 = on, 0 = off
      # new as of 0.6.0 autosens of low values (dynamic range)
      # 'overshoot' allows bars to overshoot (in % of terminal height) without initiating autosens. DEPRECATED as of 0.6.0
      ; autosens = 1
      ; overshoot = 20

      # Manual sensitivity in %. If autosens is enabled, this will only be the initial value.
      # 200 means double height. Accepts only non-negative values.
      ; sensitivity = 100

      # The number of bars (0-512). 0 sets it to auto (fill up console).
      # Bars' width and space between bars in number of characters.
      ; bars = 0
      ; bar_width = 2
      ; bar_spacing = 1
      # bar_height is only used for output in "noritake" format
      ; bar_height = 32

      # For SDL width and space between bars is in pixels, defaults are:
      ; bar_width = 20
      ; bar_spacing = 5

      # sdl_glsl have these default values, they are only used to calulate max number of bars.
      ; bar_width = 1
      ; bar_spacing = 0

      # Lower and higher cutoff frequencies for lowest and highest bars
      # the bandwidth of the visualizer.
      # Note: there is a minimum total bandwidth of 43Mhz x number of bars.
      # Cava will automatically increase the higher cutoff if a too low band is specified.
      ; lower_cutoff_freq = 50
      ; higher_cutoff_freq = 10000

      # Seconds with no input before cava goes to sleep mode. Cava will not perform FFT or drawing and
      # only check for input once per second. Cava will wake up once input is detected. 0 = disable.
      ; sleep_timer = 0

      [input]

      # Audio capturing method. Possible methods are: 'fifo', 'portaudio', 'pipewire', 'alsa', 'pulse', 'sndio', 'oss', 'jack' or 'shmem'
      # Defaults to 'oss', 'pipewire', 'sndio', 'jack', 'pulse', 'alsa', 'portaudio' or 'fifo', in that order, dependent on what support cava was built with.
      # On Mac it defaults to 'portaudio' or 'fifo'
      # On windows this is automatic and no input settings are needed.
      #
      # All input methods uses the same config variable 'source'
      # to define where it should get the audio.
      #
      # For pulseaudio and pipewire 'source' will be the source. Default: 'auto', which uses the monitor source of the default sink
      # (all pulseaudio sinks(outputs) have 'monitor' sources(inputs) associated with them).
      #
      # For pipewire 'source' will be the object name or object.serial of the device to capture from.
      # Both input and output devices are supported.
      #
      # For alsa 'source' will be the capture device.
      # For fifo 'source' will be the path to fifo-file.
      # For shmem 'source' will be /squeezelite-AA:BB:CC:DD:EE:FF where 'AA:BB:CC:DD:EE:FF' will be squeezelite's MAC address
      #
      # For sndio 'source' will be a raw recording audio descriptor or a monitoring sub-device, e.g. 'rsnd/2' or 'snd/1'. Default: 'default'.
      # README.md contains further information on how to setup CAVA for sndio.
      #
      # For oss 'source' will be the path to a audio device, e.g. '/dev/dsp2'. Default: '/dev/dsp', i.e. the default audio device.
      # README.md contains further information on how to setup CAVA for OSS on FreeBSD.
      #
      # For jack 'source' will be the name of the JACK server to connect to, e.g. 'foobar'. Default: 'default'.
      # README.md contains further information on how to setup CAVA for JACK.
      #
       method = pipewire
       source = auto

      ; method = alsa
      ; source = hw:Loopback,1

      ; method = fifo
      ; source = /tmp/mpd.fifo

      ; method = shmem
      ; source = /squeezelite-AA:BB:CC:DD:EE:FF

      ; method = portaudio
      ; source = auto

      ; method = sndio
      ; source = default

      ; method = oss
      ; source = /dev/dsp

      ; method = jack
      ; source = default

      # The options 'sample_rate', 'sample_bits', 'channels' and 'autoconnect' can be configured for some input methods:
      #   sample_rate: fifo, pipewire, sndio, oss
      #   sample_bits: fifo, pipewire, sndio, oss
      #   channels:    sndio, oss, jack
      #   autoconnect: jack
      # Other methods ignore these settings.
      #
      # For 'sndio' and 'oss' they are only preferred values, i.e. if the values are not supported
      # by the chosen audio device, the device will use other supported values instead.
      # Example: 48000, 32 and 2, but the device only supports 44100, 16 and 1, then it
      # will use 44100, 16 and 1.
      #
      ; sample_rate = 44100
      ; sample_bits = 16
      ; channels = 2
      ; autoconnect = 2

      [output]

      # Output method. Can be 'ncurses', 'noncurses', 'raw', 'noritake', 'sdl'
      # or 'sdl_glsl'.
      # 'noncurses' (default) uses a buffer and cursor movements to only print
      # changes from frame to frame in the terminal. Uses less resources and is less
      # prone to tearing (vsync issues) than 'ncurses'.
      #
      # 'raw' is an 8 or 16 bit (configurable via the 'bit_format' option) data
      # stream of the bar heights that can be used to send to other applications.
      # 'raw' defaults to 200 bars, which can be adjusted in the 'bars' option above.
      #
      # 'noritake' outputs a bitmap in the format expected by a Noritake VFD display
      #  in graphic mode. It only support the 3000 series graphical VFDs for now.
      #
      # 'sdl' uses the Simple DirectMedia Layer to render in a graphical context.
      # 'sdl_glsl' uses SDL to create an OpenGL context. Write your own shaders or
      # use one of the predefined ones.
      ; method = noncurses

      # Orientation of the visualization. Can be 'bottom', 'top', 'left' or 'right'.
      # Default is 'bottom'. Other orientations are only supported on sdl and ncruses
      # output. Note: many fonts have weird glyphs for 'top' and 'right' characters,
      # which can make ncurses not look right.
      ; orientation = bottom

      # Visual channels. Can be 'stereo' or 'mono'.
      # 'stereo' mirrors both channels with low frequencies in center.
      # 'mono' outputs left to right lowest to highest frequencies.
      # 'mono_option' set mono to either take input from 'left', 'right' or 'average'.
      # set 'reverse' to 1 to display frequencies the other way around.
      ; channels = stereo
      ; mono_option = average
      ; reverse = 0

      # Raw output target. A fifo will be created if target does not exist.
      ; raw_target = /dev/stdout

      # Raw data format. Can be 'binary' or 'ascii'.
      ; data_format = binary

      # Binary bit format, can be '8bit' (0-255) or '16bit' (0-65530).
      ; bit_format = 16bit

      # Ascii max value. In 'ascii' mode range will run from 0 to value specified here
      ; ascii_max_range = 1000

      # Ascii delimiters. In ascii format each bar and frame is separated by a delimiters.
      # Use decimal value in ascii table (i.e. 59 = ';' and 10 = '\n' (line feed)).
      ; bar_delimiter = 59
      ; frame_delimiter = 10

      # sdl window size and position. -1,-1 is centered.
      ; sdl_width = 1000
      ; sdl_height = 500
      ; sdl_x = -1
      ; sdl_y= -1
      ; sdl_full_screen = 0

      # set label on bars on the x-axis. Can be 'frequency' or 'none'. Default: 'none'
      # 'frequency' displays the lower cut off frequency of the bar above.
      # Only supported on ncurses and noncurses output.
      ; xaxis = none

      # enable alacritty synchronized updates. 1 = on, 0 = off
      # removes flickering in alacritty terminal emulator.
      # defaults to off since the behaviour in other terminal emulators is unknown
      ; alacritty_sync = 0

      # Shaders for sdl_glsl, located in $HOME/.config/cava/shaders
      ; vertex_shader = pass_through.vert
      ; fragment_shader = bar_spectrum.frag

      ; for glsl output mode, keep rendering even if no audio
      ; continuous_rendering = 0

      # disable console blank (screen saver) in tty
      # (Not supported on FreeBSD)
      ; disable_blanking = 0

      # show a flat bar at the bottom of the screen when idle, 1 = on, 0 = off
      ; show_idle_bar_heads = 1

      # show waveform instead of frequency spectrum, 1 = on, 0 = off
      ; waveform = 0

      [color]

      # Colors can be one of seven predefined: black, blue, cyan, green, magenta, red, white, yellow.
      # Or defined by hex code '#xxxxxx' (hex code must be within quotes). User defined colors requires
      # a terminal that can change color definitions such as Gnome-terminal or rxvt.
      # default is to keep current terminal color
      ; background = default
      ; foreground = default

      # SDL and sdl_glsl only support hex code colors, these are the default:
      ; background = '#111111'
      ; foreground = '#33ffff'

      # these are default
      # Gradient mode, only hex defined colors are supported,
      # background must also be defined in hex or remain commented out. 1 = on, 0 = off.
      # You can define as many as 8 different colors. They range from bottom to top of screen
      ; gradient = 0
      ; gradient_count = 8
      ; gradient_color_1 = '#59cc33'
      ; gradient_color_2 = '#80cc33'
      ; gradient_color_3 = '#a6cc33'
      ; gradient_color_4 = '#cccc33'
      ; gradient_color_5 = '#cca633'
      ; gradient_color_6 = '#cc8033'
      ; gradient_color_7 = '#cc5933'
      ; gradient_color_8 = '#cc3333'

      # for matugen
      gradient = 1
      gradient_count = 2
      gradient_color_1 = '{{colors.surface_bright.default.hex}}' 
      gradient_color_2 = '{{colors.primary.default.hex}}' 

      [smoothing]

      # Percentage value for integral smoothing. Takes values from 0 - 100.
      # Higher values means smoother, but less precise. 0 to disable.
      # DEPRECATED as of 0.8.0, use noise_reduction instead
      ; integral = 77

      # Disables or enables the so-called "Monstercat smoothing" with or without "waves". Set to 0 to disable.
      ; monstercat = 0
      ; waves = 0

      # Set gravity percentage for "drop off". Higher values means bars will drop faster.
      # Accepts only non-negative values. 50 means half gravity, 200 means double. Set to 0 to disable "drop off".
      # DEPRECATED as of 0.8.0, use noise_reduction instead
      ; gravity = 100

      # In bar height, bars that would have been lower that this will not be drawn.
      # DEPRECATED as of 0.8.0
      ; ignore = 0

      # Noise reduction, int 0 - 100. default 77
      # the raw visualization is very noisy, this factor adjusts the integral and gravity filters to keep the signal smooth
      # 100 will be very slow and smooth, 0 will be fast but noisy.
      ; noise_reduction = 77

      [eq]

      # This one is tricky. You can have as much keys as you want.
      # Remember to uncomment more than one key! More keys = more precision.
      # Look at readme.md on github for further explanations and examples.
      ; 1 = 1 # bass
      ; 2 = 1
      ; 3 = 1 # midtone
      ; 4 = 1
      ; 5 = 1 # treble
    '';
  };

  # Optional: Create shell aliases for convenience
  home.shellAliases = {
    matugen-generate = "matugen image ~/Workspaces/Config/nixos/current_wallpaper";
    matugen-reload = "matugen image ~/Workspaces/Config/nixos/current_wallpaper && pkill -SIGUSR2 waybar";
  };

  # Optional: Add systemd service to auto-generate colors on wallpaper change
  systemd.user.services.matugen-auto = {
    Unit = {
      Description = "Auto-generate colors with Matugen";
      After = [ "graphical-session.target" ];
    };
    
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.matugen}/bin/matugen image %h/.config/wallpapers/current_wallpaper";
      Environment = [ "PATH=${pkgs.swww}/bin:${pkgs.waybar}/bin:${pkgs.hyprland}/bin:${pkgs.cava}/bin" ];
    };
    
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}