FROM ocaml/opam:ubuntu-22.04-ocaml-4.14

RUN \
    opam install dune merlin ocaml-lsp-server odoc ocamlformat utop dune-release && \
    # apt-get install -y gcc-mingw-w64-x86-64 && \
    # opam repository add windows https://github.com/ocaml-cross/opam-cross-windows.git && \
    # opam install ocaml-windows -y && \
    # apt-get clean && \
    # rm -rf /var/lib/apt/lists/*
    git clone https://github.com/blank71/lc.git