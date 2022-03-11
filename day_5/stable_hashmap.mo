import Principal "mo:base/Principal"; 
import HashMap "mo:base/HashMap";
import Iter "mo:base/Iter";

actor {

  stable var entries : [(Principal, Nat)] = [];
  let mynum : Nat = 9;

  public func dummy() : async () {
    
  };

  let favoriteNumber = HashMap.fromIter<Principal,Nat>(
    entries.vals(), 0, Principal.equal, Principal.hash);

  //let favoriteNumber = HashMap.HashMap<Principal, Nat>(0, Principal.equal, Principal.hash);

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

  system func preupgrade() {
    entries := Iter.toArray(favoriteNumber.entries());
  };

  system func postupgrade() {
    entries := [];
  };

};
