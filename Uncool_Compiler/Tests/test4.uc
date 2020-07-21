class Main {
    a: Int;
    b: Int <- 42; 
    c: String <- "a string";
    print_it(x: Int,y: Int, z: Int) : Int {
      b <- 42;
      out_int(y+x);
      out_string(c);
      out_int(x*-z)
    };

    main () : Int {
       a <- 2;
       print_it(a,42,5); 
       print_it(a*2,b,6)
    };
}

