
let count_num input cchar = 
  let rec count index c =
    if index >= String.length input then
      c
    else
      if input.[index] = cchar then
        count (index + 1) (c + 1)
      else
        count (index + 1) c
    in
  count 0 0
;;

let count_lists tc lc rc =
  if (int_of_string lc) <= tc && tc <= (int_of_string rc) then
    1
  else
    0
;;

let a input =
  print_endline "a";

  let rec totalc count = function 
    | h :: t -> (
      let arr = Array.of_list h in
      let c = count_num arr.(3) arr.(2).[0] in
      let bol = count_lists c arr.(0) arr.(1) in
      totalc (count + bol) t
    )
    | [] -> count
  in
  totalc 0 input
  ;;

