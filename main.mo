import Array "mo:base/Array";
import Nat "mo:base/Nat";


actor {

  var mycounter = 0;

  public func greet(name : Text) : async Text {
    return "Hello, " # name # "!";
  };

  public func add(num1 : Nat, num2 : Nat) : async Nat {
    return (num1 + num2);
  };

  public func square(num : Nat) : async Nat {
    return (num*num);
  };

  public func days_to_second(days : Nat) : async Nat {
    return (days*24*60*60);
  };

  public func increment_counter() : async () {
    mycounter+=1;
  };

  public func clear_counter() : async () {
    mycounter := 0;
  };

  public func get_counter() : async Nat {
    return mycounter;
  };

  public func divide(num1 : Int, num2 : Int) : async Bool {
    if ((num1 % num2) == 0)
      return true
    else
      return false;
  };

  public func is_even(num : Int) : async Bool {
    if ((num % 2) == 0)
      return true
    else
      return false;
  };

  public func sum_of_array(myarray : [Nat]) : async Nat {
    if (myarray.size() == 0)
    {
      return 0;
    }
    else
    {
      var sum = 0;
      for (a in myarray.vals() )
      {
        sum += a;
      };
      return sum;
    };
  };

  public func maximum(myarray : [Nat]) : async Nat {
    if (myarray.size() == 0)
    {
      return 0;
    }
    else
    {
      var max : Nat = myarray[0];
      for (a in myarray.vals() )
      {
        if (a > max)
        {
          max := a;
        }
      };
      return max;
    };
  };

  public func remove_from_array(myarray: [Nat], value: Nat) : async [Nat] {
    if (myarray.size() == 0)
    {
      return [];
    }
    else
    {
      return Array.filter(myarray, func(val: Nat) : Bool { value != val });
    }
  };

  public func selection_sort(myarray: [Nat], value: Nat) : async [Nat] {
    if (myarray.size() == 0)
    {
      return [];
    }
    else
    {
      return Array.sort(myarray, Nat.compare);
    }

  };

};
