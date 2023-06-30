let backslash = '\\'
let LAMBDA = "λ"
let atom_head = ['a'-'z' '_']
let atom_foot = ['A'-'Z' 'a'-'z' '0'-'9' '_']
let new_line = '\r' '\n' | [ '\r' '\n' ]
let space = [' ' '\t']

rule lex = parse
| backslash | LAMBDA { Parser.LAMBDA }
| "."   { Parser.DOT }
| "("   { Parser.LPAREN }
| ")"   { Parser.RPAREN }
| atom_head atom_foot*  { Parser.ATOM (Lexing.lexeme lexbuf) }
| new_line { Parser.EOL }
| (* ignore space, tab *)
  [' ' '\t']*  { Parser.SPACE }
(* | space+ { Parser.SPACE } *)
