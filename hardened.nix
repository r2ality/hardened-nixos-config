# NixOS security-hardening module.
# Import this file from /etc/nixos/configuration.nix.
#
# This does NOT replace the stock kernel with a custom linux-hardened build.
# It applies runtime sysctl protections and a few conservative boot settings.

{ lib, ... }:
{
  # Nix builds should run in the sandbox. This is normally already enabled on
  # multi-user NixOS; mkDefault lets an explicit setting elsewhere override it.
  nix.settings.sandbox = lib.mkDefault true;

  # NixOS already enables the firewall by default. Keep it explicitly enabled.
  networking.firewall.enable = lib.mkDefault true;

  # Prevent loading a replacement kernel with kexec. This also adds
  # "nohibernate", so suspend-to-RAM remains available but hibernation does not.
  security.protectKernelImage = lib.mkDefault true;

  # Enable the AppArmor framework and packaged profiles. Only programs with an
  # applicable profile are confined; this does not sandbox every application.
  security.apparmor.enable = lib.mkDefault true;

  # Defense-in-depth kernel parameters. Numeric sysctls are strings because
  # they are written to /proc/sys at boot.
  boot.kernel.sysctl = {
    # Hide kernel addresses and restrict access to kernel logs.
    "kernel.dmesg_restrict" = lib.mkDefault "1";

    # Restrict performance counters and process-memory inspection.
    "kernel.perf_event_paranoid" = lib.mkDefault "3";
    "kernel.yama.ptrace_scope" = lib.mkDefault "1";

    # Disable unprivileged BPF, but use value 2 so root can reverse it at runtime
    # if a diagnostic/development tool genuinely needs it.
    "kernel.unprivileged_bpf_disabled" = lib.mkDefault "2";
    "net.core.bpf_jit_harden" = lib.mkDefault "2";

    # Keep ASLR fully enabled and prevent set-user-ID programs from producing
    # core dumps that could disclose privileged process memory.
    "kernel.randomize_va_space" = lib.mkDefault "2";
    "fs.suid_dumpable" = lib.mkDefault "0";

    # Protect common temporary-directory link/FIFO attacks.
    "fs.protected_hardlinks" = lib.mkDefault "1";
    "fs.protected_symlinks" = lib.mkDefault "1";
    "fs.protected_fifos" = lib.mkDefault "1";

    # A desktop/workstation should not accept or emit router redirects.
    # If this machine is intentionally a router, revisit these settings.
    "net.ipv4.conf.all.accept_redirects" = lib.mkDefault "0";
    "net.ipv4.conf.default.accept_redirects" = lib.mkDefault "0";
    "net.ipv4.conf.all.secure_redirects" = lib.mkDefault "0";
    "net.ipv4.conf.default.secure_redirects" = lib.mkDefault "0";
    "net.ipv4.conf.all.send_redirects" = lib.mkDefault "0";
    "net.ipv4.conf.default.send_redirects" = lib.mkDefault "0";
    "net.ipv6.conf.all.accept_redirects" = lib.mkDefault "0";
    "net.ipv6.conf.default.accept_redirects" = lib.mkDefault "0";
    "net.ipv4.icmp_echo_ignore_broadcasts" = lib.mkDefault "1";

    # OPTIONAL / stricter controls: uncomment only after testing your workload.
    # Disable io_uring entirely (may break modern applications/services).
    # "kernel.io_uring_disabled" = "2";
    # Limit unprivileged userfaultfd (may affect some memory-management tools).
    # "kernel.unprivileged_userfaultfd" = "0";
    # Disable kernel tracing interfaces (can break perf/ftrace diagnostics).
    # "kernel.ftrace_enabled" = "0";
  };

  # Extra kernel mitigations. These are supported by commonly used kernels;
  # unsupported parameters are generally ignored by the kernel.
  boot.kernelParams = [
    "slab_nomerge"       # Do not merge kernel slab caches; adds some memory overhead.
    "page_alloc.shuffle=1" # Randomize page allocator freelists when supported.
    "debugfs=off"        # Disable debugfs, reducing exposed kernel debugging interfaces.
  ];
}
