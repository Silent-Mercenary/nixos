{... }:
{
  services.searx = {
    enable = true;
    redisCreateLocally = true;

    settings.general = {
      debug = false;
      instance_name = "SearXNG Instance";
      donation_url = false;
      contact_url = false;
      privacypolicy_url = false;
      enable_metrics = false;
    };

    settings.server = {
    port = 9090;
    bind_address = "0.0.0.0";
    secret_key = "hahah fuck you";
    };

    settings.enabled_plugins = [
      "Basic Calculator"
      "Hash plugin"
      "Tor check plugin"
      "Open Access DOI rewrite"
      "Hostnames plugin"
      "Unit converter plugin"
      "Tracker URL remover"
    ];
  };

  networking.firewall.allowedTCPPorts = [ 9090 ];
}
