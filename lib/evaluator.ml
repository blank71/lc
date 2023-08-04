let rec chech var vars = 
  if List.exists (fun x -> x = var) vars then
    chech (var ^ "'") vars
  else 
    var

let rec alpha1 var exp vars = 
  let rename_var = chech var vars in 
  match exp with
  | Syntax.Var v -> 
    if var = v then
      Syntax.Var (rename_var)
    else 
      Syntax.Var v
  | Syntax.Abst (v, e) -> 
    if var = v then
      Syntax.Abst (rename_var , alpha1 var e vars)
    else 
      Syntax.Abst (v , alpha1 var e vars)
  | Syntax.Appl (e1, e2) -> 
    Syntax.Appl (alpha1 var e1 vars, alpha1 var e2 vars)

let rec alpha exp vars = 
  print_endline ("3: " ^ Syntax.to_type exp);
  match exp with
| Syntax.Var _ -> (exp, vars)
| Syntax.Abst (var, e) -> 
  if List.exists (fun x -> x = var) vars then
    let new_exp = alpha1 var exp vars in 
      print_endline ("1: " ^ Syntax.to_string new_exp);
    (new_exp, vars)
  else 
    let new_vars = vars @ [var] in 
    let (e, vs) = alpha e new_vars in 
    (Syntax.Abst (var, e), vs)
| Syntax.Appl (e1, e2) -> 
  let (exp1, new_vars1) = alpha e1 vars in 
  let (exp2, new_vars2) = alpha e2 new_vars1 in 
  (Syntax.Appl (exp1, exp2), new_vars2)

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
| Syntax.Abst (var, e) -> 
  Syntax.Abst (var, beta e)
| Syntax.Appl (ae1, ae2) -> 
  begin match ae1 with
  | Syntax.Var _ -> Syntax.Appl (ae1, beta ae2)
  | Syntax.Abst (var, e1) -> beta1 var e1 ae2
  | Syntax.Appl (_, _) -> Syntax.Appl ((beta ae1) ,(beta ae2))
  end

let rec print_lists exps = match exps with
| [] -> ""
| hd :: tl -> "var: " ^ hd ^ "\n" ^ (print_lists tl)

let tmp = Parser.main Lexer.lex (Lexing.from_string "(λx.x)\n")

let eval exp = 
  let rec eval1 exp show_beta = 
    let next = beta exp in 
    if next = exp then 
      exp 
    else 
    begin
      print_endline ("β " ^ Syntax.to_string exp);
      eval1 next show_beta
    end
  in eval1 exp true


(* 
> (λn.λf.λx. f (n f x))(λf.λx.x)   
β ((λn.(λf.(λx.(f ((n f) x))))) (λf.(λx.x)))
β (λf.(λx.(f (((λf.(λx.x)) f) x))))
β (λf.(λx.(f ((λx.x) x))))
-> (λf.(λx.(f x)))
*)