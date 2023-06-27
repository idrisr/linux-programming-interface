{
  inputs.nixpkgs.url = "nixpkgs";
  description = "chapter 41 and 42";
  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

      libtlpi = with pkgs;
        stdenv.mkDerivation {
          name = "libtlpi";
          src = fetchurl {
            url = "https://man7.org/tlpi/code/download/tlpi-230522-dist.tar.gz";
            hash = "sha256-8cHXacHsxjo69fvVQicGd5L+HtTXIoZMIGFYJ3bFLZs=";
          };
          buildInputs = [ libcap ];
          preInstall = ''
            mkdir -p $out/lib
          '';
          buildPhase = ''
            pushd lib
            make
          '';
          installPhase = ''
            popd
            mkdir -p $out/{lib,include}
            mv libtlpi.a $out/lib
            cp lib/* $out/include
          '';
        };

      ch41 = with pkgs;
        stdenv.mkDerivation {
          name = "libtlpi";
          src = fetchurl {
            url = "https://man7.org/tlpi/code/download/tlpi-230522-dist.tar.gz";
            hash = "sha256-8cHXacHsxjo69fvVQicGd5L+HtTXIoZMIGFYJ3bFLZs=";
          };
          nativeBuildInputs = [ libtlpi ];
          postPatch = ''
            sed -i '/''${EXE} : ''${TLPI_LIB}/d' shlibs/Makefile
            substituteInPlace Makefile.inc --replace \
            'TLPI_LIB = ''${TLPI_DIR}/libtlpi.a' \
            'TLPI_LIB = "${libtlpi}/lib/libtlpi.a"' \
            --replace \
            'TLPI_INCL_DIR = ''${TLPI_DIR}/lib' \
            'TLPI_INCL_DIR = ${libtlpi}/share'
          '';
          LIBRARY_PATH = lib.makeLibraryPath [ libtlpi ];
          makeFlags = [ "-l${libtlpi}/lib" ''LIBRARY_PATH="${libtlpi}/lib'' ];
          buildPhase = ''
            pushd shlibs
            make
          '';

          installPhase = ''
            mkdir -p $out/bin
            cp dynload  $out/bin
          '';
        };

    in {
      packages.${system} = { inherit libtlpi ch41; };

      apps.${system} = {
        runch41 = {
          type = "app";
          program = "${ch41}/bin/dynload";
        };
      };

      devShells.${system} = { inherit libtlpi; };
    };
}
