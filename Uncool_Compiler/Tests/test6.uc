class Main {
    a: Int;
    b: Int;
    max(x: Int, y: Int) : Int {
      if (x > y) then x
      else y 
      fi
   };
    main () : Int {
      out_string("> ");
      a <- in_int(); 
      out_string("> ");
      b <- in_int(); 
      out_int(max(a,b))
    };
}

