let default_rule = [
  ("hoge ", "(λx.x)")
]

let history = []

let parse_lex s = Parser.main Lexer.lex s
let parse_string s = Parser.main Lexer.lex (Lexing.from_string s)

let rec parse_eval () = 
  print_string "> "; flush_all();
  try
    let s = parse_lex (Lexing.from_channel stdin) in 
    let p = Evaluator.eval s in
    print_endline ("-> " ^ Syntax.to_string p);
  with
  (* Fatal error: exception Lc.Parser.MenhirBasics.Error *)
  | _ -> 
    begin
      print_endline ("Error: Input correct input");
      parse_eval ();
    end

let main () =
  while true do 
    parse_eval ();
  done   
