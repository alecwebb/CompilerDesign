class Main {
    a: Int [ 10 ];
    i: Int;
    main () : Int {
      i <- 0;
      while (i < 10) loop {
        out_string("> ");
        a[i] <- in_int();
        i <- i + 1
      } pool;
      i <- 0;
      while (i < 10) loop {
        out_int(a[i]);
        i <- i + 1
      } pool

    };
}

