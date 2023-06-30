type var = string 

type exp =
  | Var of var            (* variable:    a *)
  | Abst of var * exp     (* abstraction: \x. M *)
  | Appl of exp * exp     (* application: M N *)
                          (* M, N are lambda term *)

let rec parse_exp = function
  | Var var -> var
  | Abst (var, exp) -> "(" ^ "λ" ^ var ^ "." ^ (parse_exp exp) ^ ")"
  | Appl (exp1, exp2) -> "(" ^ (parse_exp exp1) ^ " " ^ (parse_exp exp2) ^ ")"