{ config, lib, pkgs, ... }:

{
  wayland.windowManager.hyprland.settings = {
    # Define color variables
    "$background" = "rgba(0e1416ff)";
    "$error" = "rgba(ffb4abff)";
    "$error_container" = "rgba(93000aff)";
    "$inverse_on_surface" = "rgba(2b3133ff)";
    "$inverse_primary" = "rgba(006876ff)";
    "$inverse_surface" = "rgba(dee3e5ff)";
    "$on_background" = "rgba(dee3e5ff)";
    "$on_error" = "rgba(690005ff)";
    "$on_error_container" = "rgba(ffdad6ff)";
    "$on_primary" = "rgba(00363eff)";
    "$on_primary_container" = "rgba(a2efffff)";
    "$on_primary_fixed" = "rgba(001f25ff)";
    "$on_primary_fixed_variant" = "rgba(004e5aff)";
    "$on_secondary" = "rgba(1c3439ff)";
    "$on_secondary_container" = "rgba(cde7edff)";
    "$on_secondary_fixed" = "rgba(051f23ff)";
    "$on_secondary_fixed_variant" = "rgba(334a50ff)";
    "$on_surface" = "rgba(dee3e5ff)";
    "$on_surface_variant" = "rgba(bfc8caff)";
    "$on_tertiary" = "rgba(262f4dff)";
    "$on_tertiary_container" = "rgba(dbe1ffff)";
    "$on_tertiary_fixed" = "rgba(101a37ff)";
    "$on_tertiary_fixed_variant" = "rgba(3c4665ff)";
    "$outline" = "rgba(899295ff)";
    "$outline_variant" = "rgba(3f484aff)";
    "$primary" = "rgba(83d2e3ff)";
    "$primary_container" = "rgba(004e5aff)";
    "$primary_fixed" = "rgba(a2efffff)";
    "$primary_fixed_dim" = "rgba(83d2e3ff)";
    "$scrim" = "rgba(000000ff)";
    "$secondary" = "rgba(b1cbd1ff)";
    "$secondary_container" = "rgba(334a50ff)";
    "$secondary_fixed" = "rgba(cde7edff)";
    "$secondary_fixed_dim" = "rgba(b1cbd1ff)";
    "$shadow" = "rgba(000000ff)";
    "$source_color" = "rgba(4c6c73ff)";
    "$surface" = "rgba(0e1416ff)";
    "$surface_bright" = "rgba(343a3cff)";
    "$surface_container" = "rgba(1b2122ff)";
    "$surface_container_high" = "rgba(252b2cff)";
    "$surface_container_highest" = "rgba(303637ff)";
    "$surface_container_low" = "rgba(171d1eff)";
    "$surface_container_lowest" = "rgba(090f10ff)";
    "$surface_dim" = "rgba(0e1416ff)";
    "$surface_tint" = "rgba(83d2e3ff)";
    "$surface_variant" = "rgba(3f484aff)";
    "$tertiary" = "rgba(bcc5ebff)";
    "$tertiary_container" = "rgba(3c4665ff)";
    "$tertiary_fixed" = "rgba(dbe1ffff)";
    "$tertiary_fixed_dim" = "rgba(bcc5ebff)";
  };
}