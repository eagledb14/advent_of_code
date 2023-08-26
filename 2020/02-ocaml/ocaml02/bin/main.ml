
let read_file name =
  let file = open_in name in
  let rec read arr =
    try 
      let line = input_line file in
      read (line :: arr)
    with End_of_file -> 
      close_in file;
      List.rev arr
  in
  read []
;;

let parse input = 
  let i = List.map (fun x -> Str.split (Str.regexp "[-: ]") x) input in
  List.map (fun x -> List.filter (fun s -> s <> "") x) i
;;

let () = 
  let f = read_file "input" in
  let c = parse f in
  (* List.iter (fun x -> List.iter print_endline x) c; *)
  print_int (A.a c);

  print_int (B.b c);
;;
