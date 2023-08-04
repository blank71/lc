type var = string 

type exp =
  (* variable:    a *)
  | Var of var            
  (* abstraction: \x. M *)
  | Abst of var * exp     
  (* application: M N 
     M, N are lambda term *)
  | Appl of exp * exp     
                          

let rec to_string = function
| Var var -> var
| Abst (var, exp) -> "(" ^ "λ" ^ var ^ "." ^ (to_string exp) ^ ")"
| Appl (exp1, exp2) -> "(" ^ (to_string exp1) ^ " " ^ (to_string exp2) ^ ")"

let rec to_type exp = match exp with
| Var var -> "Syntax.Var \"" ^ var  ^ "\""
| Abst (var, exp)-> "Syntax.Abst (\"" ^ var ^ "\", " ^ to_type exp ^ ")"
| Appl (exp1, exp2) -> "Syntax.Appl (" ^ to_type exp1 ^ ", " ^ to_type exp2  ^ ")" 

let rec to_parse exp = match exp with
| Var var -> "Var \"" ^ var  ^ "\""
| Abst (var, exp)-> "Abst (\"" ^ var ^ "\", " ^ to_parse exp ^ ")"
| Appl (exp1, exp2) -> "Appl (" ^ to_parse exp1 ^ ", " ^ to_parse exp2  ^ ")" 