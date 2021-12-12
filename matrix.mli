type 'a t = 'a array array

val width : 'a t -> int
(** Return the number of columns of the given matrice (length of the outer
    array) *)

val height : 'a t -> int
(** Return the number of rows of the given matrice (length of the first inner
    array. @raise Invalid_argument if the outer array is empty *)

val iter : ('a -> unit) -> ?line:(unit -> unit) -> 'a t -> unit
(** [iter f a] applies function [f] in turn to all the elements of [a]. It is
    equivalent to
    [f a.(0).(0); f a.(0)(1); ...; f a.(width
   a - 1).(height a - 1); ()].
    When the default argument [?line] is given, i.e [iter f g a] it applies the
    function [g] at then end of each line *)

val iterij : (int * int -> 'a -> unit) -> ?line:(unit -> unit) -> 'a t -> unit
(** Same as Matrix.iter, but the function is applied to the coordinate of the
    element as first argument, and the element itself as second argument. *)

val map : ('a -> 'b) -> 'a t -> 'b t
(** map f a applies function f to all the elements of a, and builds an array
    with the results returned by f:
    [| \[| f a.(0).(0); f a.(0).(1); ...; (f a.(0).(height a - 1)) |\];
       \[| f a.(1).(0); f a.(1).(1); ...; (f a.(1).(height a - 1)) |\];
       \[| f a.(width a - 1).(0); f a.(width a - 1).(1); ...; (f a.(width a - 1).(height a - 1) |\] |] *)

val mapij : (int * int -> 'a -> 'b) -> 'a t -> 'b t
(** Same as Matrix.map, but the function is applied to the coordinate of the
    element as first argument, and the element itself as second argument. *)

val for_all : ('a -> bool) -> 'a t -> bool

val exists : ('a -> bool) -> 'a t -> bool

val fold_left : ('b -> 'a -> 'b) -> 'b -> 'a t -> 'b
(** fold_left f acc a computes f (... (f (f init a.(0).(0)) a.(0).(1)) ...)
    a.(width n-1).(height n - 1), a *)

val copy : 'a t -> 'a t
(** deep copy *)

val neighbors : 'a t -> int -> int -> 'a list

val neighborsij : 'a t -> int -> int -> ('a * (int * int)) list

val print :
     ?pad:bool
  -> (Format.formatter -> 'a -> unit)
  -> Format.formatter
  -> 'a t
  -> unit
(** default behaviour is to pad cells so that all take the same width. *)
