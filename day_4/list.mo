module {
    public type List<T> = ?(T, List<T>);
    public func is_null<T>(list : List<T>) : Bool {
        switch(list){
            case(null) {
                return true;
            };
            case(list){
                return false;
            };
        }
    };

    public func last<T>(list : List<T>) : ?T {
        switch(list){
            case (null) { null };
            case (?(a, null)) { ?a };
            case (?(_, lst)) { last<T>(lst) };
        }
    };

    public func size<T>(list : List<T>) : Nat {

        func rec(l : List<T>, n : Nat) : Nat {
            switch l {
                case null { n };
                case (?(_, t)) { rec(t, n + 1) };
            }
        };
        rec(list,0)
        
    };

    public func get<T>(list : List<T>, n : Nat) : ?T {

        switch (n, list) {
            case (_, null) { null };
            case (0, (?(h, t))) { ?h };
            case (_, (?(_, t))) { get<T>(t, n - 1) };
        }
        
    };


};