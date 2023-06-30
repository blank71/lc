%{
open Syntax
%}

%token LAMBDA
%token <Syntax.var> ATOM
%token DOT
%token LPAREN RPAREN
%token SPACE
%token EOL


%type <Syntax.exp> main
%type <Syntax.exp> exp
%type <Syntax.exp> abstraction
%type <Syntax.exp> application
%type <Syntax.exp> a

%start main

%%

// 入力を受け取る
let main := 
  | SPACE; ~ = main; <>
  | ~ = exp; EOL; <>

let exp :=
  | ~ = abstraction; <>

(* \x. x *)
let abstraction :=
  // | LAMBDA; var = ATOM; DOT; ~ = abstraction; { Abst (var, abstraction) }
  | LAMBDA; var = ATOM; DOT; SPACE; ~ = abstraction; { Abst (var, abstraction) }
  | ~ = application; <>

let application :=
  // | ~ = application; ~ = a; { Appl (application, a) }
  | ~ = application; SPACE; ~ = a; { Appl (application, a) }
  | ~ = a; <>

let a :=
  | var = ATOM; { Var var }
  | LPAREN; ~ = exp; RPAREN; <>