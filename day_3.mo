import Array "mo:base/Array";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Option "mo:base/Option";
import Func "mo:base/Func";


actor {
  private func swap( myarray : [var Nat], i : Nat, j : Nat) : async [Nat] {
    var dummy : Nat = 0;
    dummy := myarray[i];
    myarray[i] := myarray[j];
    myarray[j] := myarray[i];
    return Array.freeze(myarray);
  };

  public func init_count( n : Nat) : async [Nat] {
    var myarray : [var Nat] = Array.init(n, 0);
    for (j in Iter.range(0, n - 1)) {
      myarray[j] := j;
    };
    return Array.freeze(myarray);
  };

  public func seven( myarray : [Nat]) : async Text {
    var dumtext : Text = "";
    for (j in myarray.vals()) {
      dumtext := Nat.toText(j);
      if (Text.contains(dumtext,#text "7"))
        return "Seven is found";
    };
    return "Seven not found";
  };

  public func nat_opt_to_nat( n : ?Nat, m : Nat) : async ?Nat {
    switch(n) {
      case(null) {
        return ?m;
      };
      case(?something){
        return n;
      };
    };
  };

  public func day_of_the_week( n : Nat) : async ?Text {
    switch(n) {
      case(1) {
        return ?"Monday";
      };
      case(2) {
        return ?"Tuesday";
      };
      case(3) {
        return ?"Wednesdy";
      };
      case(4) {
        return ?"Thursday";
      };
      case(5) {
        return ?"Friday";
      };
      case(6) {
        return ?"Saturday";
      };
      case(7) {
        return ?"Sunday";
      };
      case(something) {
        return null;
      };
    };
    return null;
  };

  let f = func (n : ?Nat) : Nat {
    return Option.get<Nat>(n, 0);
  };

  public func populate_array( myarray : [?Nat]) : async [Nat] {
    return( Array.map<?Nat, Nat>(myarray, f) );
  };

  let f2 = func (a : Nat, b : Nat) : Nat {
    return a + b;
  };

  public func sum_of_array( myarray : [Nat]) : async Nat {
    return( Array.foldRight<Nat, Nat>(myarray, 0, f2) );
  };

  let f3 = func (n : Nat) : Nat {
    return n*n;
  };

  public func squared_array( myarray : [Nat]) : async [Nat] {
    return( Array.map<Nat, Nat>(myarray, f3) );
  };

  let f4 = func (n : Nat, i : Nat) : Nat {
    return n + i;
  };

  public func increase_by_index( myarray : [Nat]) : async [Nat] {
    return( Array.mapEntries<Nat, Nat>(myarray, f4) );
  };


  private func contains<A>( myarray : [A], a : A, f : (A,A) -> Bool) : Bool {
    let f5 = func (n : A) : Bool {
      return f(n,a); // f compares n with a, n == a -> true else false
    };

    let res : ?A = ( Array.find<A>(myarray, f5) );

    switch(res) {
      case(null) {
        return false;
      };
      case(something) {
        return true;
      };
    };
  };

  public func test_contain() : async Bool {
      let myf = func (a : Nat, b : Nat) : Bool {
        if ( a == b ) {
          return true;
        };
        return false;
      };

      var myarray : [Nat] = [1,2,3,4];
      return (contains<Nat>(myarray, 3, myf));
  };

};
