let a = 1

let main () = 
  while true do 
    print_string "> "; flush_all();
    let s = Parser.main Lexer.lex (Lexing.from_channel stdin) in
    let p = Evaluator.eval s in
    print_endline ("-> " ^ Syntax.to_string p);
    (* print_newline (); *)
  done   
