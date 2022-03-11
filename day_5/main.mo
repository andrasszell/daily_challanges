import Principal "mo:base/Principal"; 
import HashMap "mo:base/HashMap";
import Cycles "mo:base/ExperimentalCycles";
import Iter "mo:base/Iter";

actor {

  let favoriteNumber = HashMap.HashMap<Principal, Nat>(0, Principal.equal, Principal.hash);

  public shared(msg) func is_anonymous() : async Bool {
    let principal_caller = msg.caller;
    return Principal.isAnonymous(principal_caller);
  };

  public shared(msg) func add_favorite_number( n : Nat ) : async Text {
    let principal_caller = msg.caller;
    if (favoriteNumber.get(principal_caller) != null ) {
      return "You have already registered your number";
    } else {
      favoriteNumber.put(principal_caller,n);
      return "You've successfully registered your number";
    };
  };

  public shared(msg) func show_favorite_number() : async ?Nat {
    let principal_caller = msg.caller;
    return favoriteNumber.get(principal_caller);
  };

  public shared(msg) func update_favorite_number(n : Nat) : async Text {
    let principal_caller = msg.caller;
    if (favoriteNumber.get(principal_caller) != null ) {
      var oldun : ?Nat = favoriteNumber.replace(principal_caller,n);
      return "You number was updated";
    } else {
      return "You dont have favourite number yet...";
    };
  };

  public shared(msg) func delete_favorite_number() : async Text {
    let principal_caller = msg.caller;
    if (favoriteNumber.get(principal_caller) != null ) {
      var oldun : ?Nat = favoriteNumber.remove(principal_caller);
      return "You favourite number was deleted";
    } else {
      return "You dont have favourite number yet...";
    };
  };

  public func message_available() : async Nat {
      return(Cycles.available())
  };

  let AMOUNT_TO_PAY : Nat = 900_000;

  public func deposit_cycles() : async Nat {
    var cycles_to_deposit : Nat = AMOUNT_TO_PAY;
    if(Cycles.available() < AMOUNT_TO_PAY) {
        cycles_to_deposit := Cycles.available();
    };
    let received = Cycles.accept(cycles_to_deposit);
    return(cycles_to_deposit);
  };

  stable var mycounter = 1;
  stable var version_number = 0;

  system func postupgrade() {
    version_number += 1;
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

  public func get_version_number() : async Nat {
    return version_number;
  };

};
