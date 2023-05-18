with import <nixpkgs> { };
mkShell {
  buildInputs = [
    acl
    bear
    libcap
    libseccomp
    libselinux
    libxcrypt
    ccls

  ];
}
