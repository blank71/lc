%{
open Syntax
%}

// %token LAMBDA
%token <Syntax.var> ATOM
%token LPAREN RPAREN
%token LAMBDA
%token DOT
%token EOL


%type <Syntax.exp> main
%type <Syntax.exp> exp
%type <Syntax.exp> abstraction
%type <Syntax.exp> application
%type <Syntax.exp> a

%start main

%%

let main := 
  | ~ = exp; EOL; <>

let exp :=
  | ~ = abstraction; <>

let abstraction :=
  | LAMBDA; var = ATOM; DOT; ~ = abstraction; { Abst (var, abstraction) }
  | ~ = application; <>

let application :=
  | ~ = application; ~ = a; { Appl (application, a) }
  | ~ = a; <>

let a :=
  | var = ATOM; { Var var }
  | LPAREN; ~ = exp; RPAREN; <>