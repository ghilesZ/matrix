type 'a t = 'a array array

val iter : ('a -> unit) -> ?line:(unit -> unit) -> 'a t -> unit

val iterij : (int * int -> 'a -> unit) -> ?line:(unit -> unit) -> 'a t -> unit

val for_all : ('a -> bool) -> 'a t -> bool

val exists : ('a -> bool) -> 'a t -> bool

val fold_left : ('b -> 'a -> 'b) -> 'b -> 'a t -> 'b

val map : ('a -> 'b) -> 'a t -> 'b t

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
