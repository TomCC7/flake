# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.loader = {
    systemd-boot.enable = true;
    grub.device = "/dev/disk/by-uuid/EA4A-D611";
  };

  boot.initrd.luks.devices."enc" = {
    device = "/dev/disk/by-uuid/fd75d71c-23be-41a8-8ede-b0ee552e2be4";
    preLVM = true;
  };

  fileSystems."/" =
    { device = "/dev/mapper/enc";
      fsType = "btrfs";
      options = [ "subvol=nixos" "compress=zstd" ];
    };

  fileSystems."/home" =
    { device = "/dev/mapper/enc";
      fsType = "btrfs";
      options = [ "subvol=home" "compress=zstd" ];
    };

  fileSystems."/boot/efi" =
    { device = "/dev/disk/by-uuid/EA4A-D611";
      fsType = "vfat";
    };

  swapDevices = [ { device = "/dev/disk/by-uuid/8ee80a94-8ca3-4293-9199-c7af7412cba9"; }];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  # high-resolution display
  hardware.video.hidpi.enable = lib.mkDefault true;
}
