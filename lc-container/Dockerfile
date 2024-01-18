FROM ocaml/opam:ubuntu-22.04-ocaml-4.14

SHELL ["/bin/bash", "-c"]

RUN \
    opam install dune merlin ocaml-lsp-server odoc ocamlformat utop dune-release && \
    git clone https://github.com/blank71/lc.git 

