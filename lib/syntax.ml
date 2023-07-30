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