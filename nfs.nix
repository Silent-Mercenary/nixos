{...}:

{
  services.nfs.server = {
    enable = true;
    exports = ''
      /export 192.168.2.0/24(rw,fsid=0,no_subtree_check) \
              10.42.0.0/24(rw,no_subtree_check) \
              100.110.110.0/24(rw,no_subtree_check) \
              localhost(rw,no_subtree_check)
    '';
  };

  fileSystems."/export" = {
    device = "<YOUR_INTERNAL_DIR>";
    options = [ "bind" "relatime" ];
  };
}
