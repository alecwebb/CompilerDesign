class Main {
    a: Int;
    b: Int;
    looping(a: Int, b: Int) : Int {
      if (a > b) then {
        while (b <= a) loop {
	   out_int(b); b <- b + 1
        } pool
      } else {
        while (a <=b) loop {
	   out_int(a); a <- a + 1
        } pool
      }
      fi
   };
    main () : Int {
      out_string("> ");
      a <- in_int(); 
      out_string("> ");
      b <- in_int(); 
      looping(a,b)
    };
}

