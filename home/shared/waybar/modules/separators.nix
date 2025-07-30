{ config, pkgs, lib, ... }:

{
  config.waybar.modules.separators = {
    "custom/separator#dot" = {
      format = "";
      interval = "once";
      tooltip = false;
    };

    "custom/separator#dot-line" = {
      format = "";
      interval = "once";
      tooltip = false;
    };

    "custom/separator#line" = {
      format = "|";
      interval = "once";
      tooltip = false;
    };

    "custom/separator#blank" = {
      format = "";
      interval = "once";
      tooltip = false;
    };

    "custom/separator#blank_2" = {
      format = "  ";
      interval = "once";
      tooltip = false;
    };

    "custom/separator#blank_3" = {
      format = "   ";
      interval = "once";
      tooltip = false;
    };

    "custom/arrow1" = {
      format = "";
      tooltip = false;
    };

    "custom/arrow2" = {
      format = "";
      tooltip = false;
    };

    "custom/arrow3" = {
      format = "";
      tooltip = false;
    };

    "custom/arrow4" = {
      format = "";
      tooltip = false;
    };

    "custom/arrow5" = {
      format = "";
      tooltip = false;
    };

    "custom/arrow6" = {
      format = "";
      tooltip = false;
    };

    "custom/arrow7" = {
      format = "";
      tooltip = false;
    };

    "custom/arrow8" = {
      format = "";
      tooltip = false;
    };

    "custom/arrow9" = {
      format = "";
      tooltip = false;
    };

    "custom/arrow10" = {
      format = "";
      tooltip = false;
    };
  };
}