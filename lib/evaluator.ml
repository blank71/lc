let rec get_type exp = match exp with
  | Syntax.Var var -> "Syntax.Var \"" ^ var  ^ "\""
  | Syntax.Abst (var, exp)-> "Syntax.Abst (\"" ^ var ^ "\", " ^ get_type exp ^ ")"
  | Syntax.Appl (exp1, exp2) -> "Syntax.Appl (" ^ get_type exp1 ^ ", " ^ get_type exp2  ^ ")" 

(* let rec alpha var exp = 
  let prime_var = var ^ "'" in
  match exp with
  | Syntax.Var v -> 
    if v = var then
      Syntax.Var prime_var
    else 
      exp
  | Syntax.Abst (v, e) ->
    if v = var then
      Syntax.Abst (prime_var, alpha var e)
    else 
      Syntax.Abst (v, alpha var e)
  | Syntax.Appl (e1, e2) ->
    Syntax.Appl (alpha var e1, alpha var e2)
;
let rec alpha_u exp = match exp with
  | Syntax.Var var -> Syntax.Var var
  | Syntax.Abst (v, e) -> Syntax.Abst (v, alpha v e)
  | Syntax.Appl (e1, e2) -> Syntax.Appl (alpha_u e1, alpha_u e2)
;
let is_Abst = function
  | Syntax.Abst (_, _) -> true
  | _ -> false
; *)

let rec beta1 v exp1 exp2 = match exp1 with
| Syntax.Var var -> 
  begin if var = v then
    exp2
  else 
    exp1
  end
| Syntax.Abst (var, exp) -> 
  Syntax.Abst (var, beta1 v exp exp2)
| Syntax.Appl (e1, e2) -> 
  Syntax.Appl (beta1 v e1 exp2, beta1 v e2 exp2)

let rec beta exp = match exp with
| Syntax.Var _ -> exp
| Syntax.Abst (_, _) -> exp
| Syntax.Appl (ae1, ae2) -> 
  begin match ae1 with
  | Syntax.Var _ -> exp
  | Syntax.Abst (var, e1) -> beta1 var e1 ae2
  | Syntax.Appl (_, _) -> Syntax.Appl ((beta ae1) ,ae2)
  end

let eval exp = 
  let rec eval1 show_beta exp = 
    let next = beta exp in 
    if next = exp then 
      exp
    else
      begin 
        if show_beta then print_endline ("β " ^ Syntax.to_string exp);
      eval1 show_beta next;
      end
  in eval1 true exp;

