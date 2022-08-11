# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
in
{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "vmd" "nvme" "usb_storage" "usbhid" "sd_mod" "sdhci_pci" ];
  boot.initrd.kernelModules = [ ];
  # boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  # boot.kernelParams = [ "modprobe.blacklist=nouveau" ];

  fileSystems."/" =
    { device = "/dev/mapper/enc";
      fsType = "btrfs";
      options = ["subvol=nixos" "compress=zstd" "noatime"];
    };

  boot.initrd.luks.devices."enc".device = "/dev/disk/by-uuid/0976cf53-20cd-43a0-b66e-b71c18d37257";

  fileSystems."/home" ={
    device = "/dev/mapper/enc";
    fsType = "btrfs";
    options = ["subvol=home" "compress=zstd" "noatime"];
  };

  fileSystems."/boot/efi" = {
    device = "/dev/disk/by-uuid/FC1C-F544";
    fsType = "vfat";
  };

  fileSystems."/mnt/share" = {
    device = "/dev/disk/by-uuid/7CD85F373997531E";
    fsType = "ntfs";
    options = ["rw" "uid=1000"];
  };

  swapDevices = [{
    device = "/dev/disk/by-uuid/438f4595-6b4e-4f54-8d22-74132509fba4";
  }];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno2.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

  # powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  # high-resolution display
  hardware.video.hidpi.enable = lib.mkDefault true;

  # Intel
  hardware.opengl =
    let
      fn = oa: {
        nativeBuildInputs = oa.nativeBuildInputs ++ [ pkgs.glslang ];
        mesonFlags = oa.mesonFlags ++ [ "-Dvulkan-layers=device-select,overlay" ];
        patches = oa.patches ++ [ ./mesa-vulkan-layer-nvidia.patch ];
        postInstall = oa.postInstall + ''
            mv $out/lib/libVkLayer* $drivers/lib

            #Device Select layer
            layer=VkLayer_MESA_device_select
            substituteInPlace $drivers/share/vulkan/implicit_layer.d/''${layer}.json \
              --replace "lib''${layer}" "$drivers/lib/lib''${layer}"

            #Overlay layer
            layer=VkLayer_MESA_overlay
            substituteInPlace $drivers/share/vulkan/explicit_layer.d/''${layer}.json \
              --replace "lib''${layer}" "$drivers/lib/lib''${layer}"
          '';
      };
    in
      with pkgs; {
        enable = true;
        driSupport32Bit = true;
        package = (mesa.overrideAttrs fn).drivers;
        package32 = (pkgsi686Linux.mesa.overrideAttrs fn).drivers;
        extraPackages = with pkgs; [
          intel-media-driver # LIBVA_DRIVER_NAME=iHD
          # vaapiIntel         # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
          vaapiVdpau
          libvdpau-va-gl
        ];
      };

  # Nvidia {{
  services.xserver.videoDrivers = [ "nvidia" ];
  # hardware.nvidia.modesetting.enable = true;


  # Optionally, you may need to select the appropriate driver version for your specific GPU.
  # hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  environment.systemPackages = [
    nvidia-offload
    pkgs.glxinfo
    pkgs.glmark2
  ];

  hardware.nvidia.prime = {
    offload.enable = true;
    # sync.enable = true;

    # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA
    intelBusId = "PCI:0:2:0";

    # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
    nvidiaBusId = "PCI:1:0:0";
  };

  # enable boot with external display
  # specialisation = {
  #   external-display.configuration = {
  #     system.nixos.tags = [ "external-display" ];
  #     hardware.nvidia.prime.offload.enable = lib.mkForce false;
  #     hardware.nvidia.powerManagement.enable = lib.mkForce false;
  #   };
  # };
  # }}
  #

  services.tlp = {
    enable = true;
    settings = {
      TLP_ENABLE = 1;
      TLP_WARN_LEVEL=3;

      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_SCALING_MIN_FREQ_ON_AC=5000000;
      CPU_SCALING_MAX_FREQ_ON_AC=5000000;

      CPU_ENERGY_PERF_POLICY_ON_AC="performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT="power";

      CPU_MIN_PERF_ON_AC=0;
      CPU_MAX_PERF_ON_AC=100;
      CPU_MIN_PERF_ON_BAT=0;
      CPU_MAX_PERF_ON_BAT=70;

      CPU_BOOST_ON_AC=1;
      CPU_BOOST_ON_BAT=0;

      CPU_HWP_DYN_BOOST_ON_AC=1;
      CPU_HWP_DYN_BOOST_ON_BAT=0;

      SCHED_POWERSAVE_ON_AC=0;
      SCHED_POWERSAVE_ON_BAT=1;

      PLATFORM_PROFILE_ON_AC="performance";
      PLATFORM_PROFILE_ON_BAT="balanced";
    };
  };
}
