{
  lib,
  config,
  pkgs,
  ...
}:
let
  nixpkgsBaseVersion = builtins.head (builtins.match ''([0-9]+\.[0-9]+).*'' pkgs.lib.version);
in
{
  options.firefox = {
    userContent = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
    };
  };

  config.programs.firefox.policies = {
    ExtensionSettings = {
      "*".installation_mode = "allowed";
      # Ad Blocker:
      "uBlock0@raymondhill.net" = {
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
        installation_mode = "force_installed";
        default_area = "menupanel";
      };
      # Dark Reader:
      "addon@darkreader.org" = {
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
        installation_mode = "force_installed";
        default_area = "menupanel";
      };
      # YouTube extension for skipping irrelevant video parts
      "sponsorBlocker@ajay.app" = {
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
        installation_mode = "force_installed";
        default_area = "menupanel";
      };
    };
  };

  config.programs.firefox.enable = true;
  config.programs.firefox.profiles."default-release" = {
    id = 0;
    path = "default";
    isDefault = true;

    bookmarks = {
      force = true;
      settings = [
        {
          toolbar = true;  # global toolbar 
          bookmarks = [
            {
              name = "YouTube";
              url = "https://www.youtube.com";
            }
            {
              name = "GitHub";
              url = "https://github.com/wojtryb?tab=repositories";
            }
            {
              name = "KritaArtists";
              url = "https://www.krita-artists.org/";
            }
            {
              name = "FaceBook";
              url = "https://www.facebook.com/";
            }
          ];
        }
      ];
    };

    settings = {
      "layout.css.devPixelsPerPx" = 0.9;  # SCALE
      "browser.aboutwelcome.enabled" = false;
      "extensions.autoDisableScopes" = 0;
      "ui.key.menuAccessKeyFocuses" = false;
      "browser.startup.page" = 0;
      "browser.aboutConfig.showWarning" = false;
      "browser.tabs.closeWindowWithLastTab" = false;
      "browser.tabs.fadeOutUnloadedTabs" = true;
      "browser.ctrlTab.sortByRecentlyUsed" = true;
      "browser.toolbars.bookmarks.visibility" = "never";
      "browser.newtabpage.activity-stream.showSponsored" = false;
      "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
      "browser.newtabpage.activity-stream.newtabWallpapers.wallpaper" = "solid-color-picker-#171717";
      "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
      "sidebar.visibility" = "always";
      "sidebar.expandOnHover" = false;
      "sidebar.verticalTabs" = true;
      "sidebar.position_start" = false; # Move to right
      "sidebar.main.tools" = "";
      "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      "browser.uiCustomization.state" = {
        "placements" = {
          "nav-bar" = [
            "back-button"
            "forward-button"
            "stop-reload-button"
            "customizableui-special-spring1"
            "vertical-spacer"
            "urlbar-container"
            "personal-bookmarks"
            "customizableui-special-spring2"
            "downloads-button"
            "unified-extensions-button"
            "fxa-toolbar-menu-button"
          ];
          "toolbar-menubar" = [ "menubar-items" ];
          "vertical-tabs" = [ "tabbrowser-tabs" ];
        };
        "currentVersion" = 22;
        "newElementCount" = 5;
      };
      "privacy.userContext.newTabContainerOnLeftClick.enabled" = true;
      "devtools.debugger.remote-enabled" = true;
      "devtools.chrome.enabled" = true;

      "browser.urlbar.shortcuts.actions" = false;
      "browser.urlbar.shortcuts.bookmarks" = false;
      "browser.urlbar.shortcuts.history" = false;
      "browser.urlbar.shortcuts.tabs" = false;
    };

    # Is this not working?
    # non-clickable "mute/unmute" playback buttons on background tabs
    userChrome = ''
      tab.tabbrowser-tab:not([selected="true"]) image.tab-icon-overlay[role="presentation"] {
        pointer-events: none;
      }
    '';

    userContent = lib.strings.concatStringsSep "\n" config.firefox.userContent;
    containersForce = true;

    search.force = true;
    search.default = "ddg";
    search.order = [ "ddg" "google" ];
    search.engines.bing.metaData.hidden = true;
    # search.engines.ebay.metaData.hidden = true; # Not working?
    search.engines.perplexity.metaData.hidden = true;
    search.engines."Nix Packages" = {
      definedAliases = [ "@np" ];
      urls = [
        {
          template = "https://search.nixos.org/packages";
          params = [
            {
              name = "query";
              value = "{searchTerms}";
            }
            {
              name = "channel";
              value = nixpkgsBaseVersion;
            }
          ];
        }
      ];
      iconMapObj."48" = "https://nixos.org/favicon-48x48.png";
    };
    search.engines."Nix Options" = {
      definedAliases = [ "@no" ];
      urls = [
        {
          template = "https://search.nixos.org/options";
          params = [
            {
              name = "query";
              value = "{searchTerms}";
            }
            {
              name = "channel";
              value = nixpkgsBaseVersion;
            }
          ];
        }
      ];
      iconMapObj."48" = "https://nixos.org/favicon-48x48.png";
    };
    search.engines."Home Manager Options" = {
      definedAliases = [ "@hmo" ];
      urls = [
        {
          template = "https://home-manager-options.extranix.com/";
          params = [
            {
              name = "query";
              value = "{searchTerms}";
            }
            {
              name = "release";
              value = "release-${nixpkgsBaseVersion}";
            }
          ];
        }
      ];
      iconMapObj."48" = "https://nixos.org/favicon-48x48.png";
    };

    extensions.force = true;
  };
}
