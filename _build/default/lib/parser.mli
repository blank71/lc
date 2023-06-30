
(* The type of tokens. *)

type token = 
  | SPACE
  | RPAREN
  | LPAREN
  | LAMBDA
  | EOL
  | DOT
  | ATOM of (Syntax.var)

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val main: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Syntax.exp)
