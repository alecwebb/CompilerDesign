class Main {
    print_it(x: Int,y: Int, z: Int) : Int {
      out_int(y+x);
      out_int(x*-z)
    };

    main () : Int {
       print_it(2,42,5); print_it(4,42,6)
    };
}

