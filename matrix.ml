type 'a t = 'a array array

let width : 'a t -> int = Array.length

let height m = Array.length m.(0)

let iter f ?line (m : 'a t) =
  match line with
  | None -> Array.iter (Array.iter f) m
  | Some f_l -> Array.iter (fun l -> Array.iter f l ; f_l ()) m

let iterij f ?line (m : 'a t) =
  match line with
  | None -> Array.iteri (fun i -> Array.iteri (fun j -> f (i, j))) m
  | Some f_l ->
      Array.iteri
        (fun i l ->
          Array.iteri (fun j e -> f (i, j) e) l ;
          f_l () )
        m

let for_all p (m : 'a t) = Array.for_all (Array.for_all p) m

let exists p (m : 'a t) = Array.exists (Array.exists p) m

let fold_left f acc (m : 'a t) = Array.fold_left (Array.fold_left f) acc m

let map f (m : 'a t) = Array.map (Array.map f) m

let mapij f (m : 'a t) = Array.mapi (fun i -> Array.mapi (fun j -> f (i, j))) m

let copy m = Array.map Array.copy m

let product a b =
  let rec loop acc = function
    | [] -> acc
    | hd :: tl ->
        let acc' = List.rev_append (List.rev_map (fun x -> (hd, x)) b) acc in
        loop acc' tl
  in
  loop [] a

let neighbors a i j =
  let l =
    product [i - 1; i; i + 1] [j - 1; j; j + 1]
    |> List.filter (fun (i', j') -> i <> i' || j <> j')
  in
  List.filter_map (fun (i, j) -> try Some a.(i).(j) with _ -> None) l

let neighborsij a i j =
  let l =
    product [i - 1; i; i + 1] [j - 1; j; j + 1]
    |> List.filter (fun (i', j') -> i <> i' || j <> j')
  in
  List.filter_map
    (fun (i, j) -> try Some (a.(i).(j), (i, j)) with _ -> None)
    l

let pad size cell =
  let s = String.make (size - String.length cell) ' ' in
  s ^ cell

let max_print pp m =
  fold_left
    (fun max e ->
      let size = String.length (Format.asprintf "%a" pp e) in
      if size > max then size else max )
    0 m

let print ?pad:(p = true) pp fmt m =
  iter
    ( if p then
      let max = max_print pp m in
      fun e ->
        let str = Format.asprintf "%a" pp e in
        Format.fprintf fmt "%s " (pad max str)
    else Format.fprintf fmt "%a " pp )
    ~line:Format.print_newline m
