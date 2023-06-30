open Syntax

let main () = 
  while true do 
    print_string "> "; flush_all();
    let s =
      Parser.main Lexer.lex (Lexing.from_channel stdin) in
      let p = parse_exp s in
      print_string ("-> " ^ p);
    print_newline ();
  done