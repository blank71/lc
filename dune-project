(lang dune 3.0)

(name lc)

(generate_opam_files true)

(package
 (name lc)
 (synopsis "A short synopsis")
 (description "A longer description")
 (depends ocaml dune))

(using menhir 2.1)