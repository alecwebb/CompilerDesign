class Main {
    a: Int [ 10 ];
    i: Int;
    current: Int;
    smallest: Int;
    l: Int;
    num_elems: Int;

    print_array(size: Int) : Int {
       i <- 0;
       while (i < size) loop {
          out_int(a[i]);
          i<- i+1
       } pool
    };

    get_array(size: Int) : Int {
       i <- 0;
       while (i < size) loop {
          a[i] <- in_int();
          i<- i+1
       } pool
    };

    smallest_index(start: Int, stop: Int) : Int {
      current <- start;
      while (start < stop) loop {
         current <- if (a[current] > a[start]) then start else current fi; 
         start <- start+1
      } pool; current 
    }; 

    swap(x: Int, y: Int) : Int {
       l <- a[x];  a[x] <- a[y]; a[y] <- l 
    };

    sort(num_elems: Int) : Int {
       i <- 0;
       while (i < num_elems) loop {
          smallest <- smallest_index(i,num_elems);
          swap(smallest,i);  i <- i + 1       
       } pool
     };

    main () : Int {
      out_string("Number of elements (up to 10)?");
      num_elems <- in_int();
      num_elems <- if (num_elems > 10) then 10 else num_elems fi;
      get_array(num_elems);
      sort(num_elems);
      print_array(num_elems)
    };
}

