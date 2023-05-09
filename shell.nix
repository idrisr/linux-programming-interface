with import <nixpkgs> { };
mkShell {
  buildInputs = [
    acl
    libcap
    libseccomp
    libselinux
    libxcrypt

  ];
}
