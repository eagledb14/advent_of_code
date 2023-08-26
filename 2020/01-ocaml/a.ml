
let read_file filename = 
  let ic = open_in filename in
  let rec read_lines acc =
    try
      let line = input_line ic in
      read_lines (int_of_string line :: acc)
    with End_of_file -> 
      close_in ic;
      List.rev acc
  in
  read_lines []
;;


let two_sum nums target = 
  let table = Hashtbl.create (Array.length nums) in
  let rec sum i =
    if i >= Array.length nums then
      raise Not_found
    else
      let complement = target - nums.(i) in 
      try 
        let _ = Hashtbl.find table complement in
        complement * (nums.(i))
      with Not_found ->
        Hashtbl.add table nums.(i) i;
        sum (i + 1)
  in
  sum 0
;;


let () =
  let filename = "input" in
  let int_list = read_file filename in
  List.iter (fun x -> print_endline (string_of_int x)) int_list;
  let product = two_sum (Array.of_list int_list) 2020 in
  print_endline "";
  print_endline (string_of_int product);
;;
