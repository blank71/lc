let backslash = '\\'
let yen = "¥"
let lambda = "λ" | backslash | yen
let atom_head = ['a'-'z' '_']
let atom_foot = ['A'-'Z' 'a'-'z' '0'-'9' '_']
let atom = atom_head atom_foot*
let new_line = '\r' '\n' | [ '\r' '\n' ]
let space = [' ' '\t']

rule lex = parse
| lambda { Parser.LAMBDA }
| "."   { Parser.DOT }
| "("   { Parser.LPAREN }
| ")"   { Parser.RPAREN }
| atom  { Parser.ATOM (Lexing.lexeme lexbuf) }
| new_line { Parser.EOL }
| (* ignore space, tab *)
  space+  { lex lexbuf }
