
let check_index li ri c s =
  let lc = s.[li - 1] in  
  let rc = s.[ri - 1] in 
  (lc = c && rc <> c) || (lc <> c && rc = c)
;;

let b input =
  print_endline "";
  print_endline "b";

  let rec totalc count = function 
    | h :: t -> (
      let arr = Array.of_list h in
      if check_index (int_of_string arr.(0)) (int_of_string arr.(1)) arr.(2).[0] arr.(3) then
        totalc (count + 1) t
      else
        totalc count t
    )
    | [] -> count
  in
  totalc 0 input
;;
