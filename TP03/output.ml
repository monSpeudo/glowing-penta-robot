open Types;;
open Eval;;

let getIndent i =
  let rec aux i res =
    match i with
      | 0 -> res
      | _ -> aux (i - 1) res ^ "    "
  in
    aux i ""
;;



(*TODO affichage du terme*)
let rec term_to_string term =
    match term with
      | Var x -> x
      | Lambda (x, y) -> "λ" ^ x ^ ". " ^ (term_to_string y)
      | App (x, y) -> (term_to_string x) ^ " " ^(term_to_string y)
;;

let print_term term =
    print_endline (term_to_string term)
;;