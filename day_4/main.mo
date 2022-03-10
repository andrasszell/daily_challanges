import Person "custom";
import Animal "animal";
import List "mo:base/List";
import myList "list";

actor {
  public type Person = Person.Person;
  public type Animal = Animal.Animal;

  public type List<T> = ?(T, List<T>);

  var animalList : List<Animal> = null;

  let _animal : Animal = {
    specie = "dog";
    energy = 0;
  };

  public func fun() : async Person {
    var p : Person = {
      name = "Tom Cruise";
      age = 59;
    };
    return p;
  };

  public func create_animal_then_takes_a_break(specie : Text, energy : Nat) : async Animal {
    var sleepyanimal : Animal = {
      specie = specie;
      energy = 0;
    };
    return sleepyanimal;
  };

  private func push_animal(newanimal : Animal) : () {
    var l : List<Animal> = null;
    var newanimal_list : List<Animal> = List.push<Animal>(newanimal, l);
    animalList := List.append<Animal>(animalList, newanimal_list);
  };

  private func get_animals() : [Animal] {
    return List.toArray<Animal>(animalList);
  };

  public func test_push_get_animals() : async [Animal] {
    var anim : Animal = {
      specie = "Dog";
      energy = 5;
    };
    push_animal(anim);
    return get_animals();
  };

  public func test_is_null() : async Bool {
        var l : List<Nat> = null;
        var k : List<Nat> = List.push<Nat>(3, l);
        return myList.is_null<Nat>(k);
    };

  public func test_last() : async ?Nat {
        var l : List<Nat> = null;
        var k : List<Nat> = List.push<Nat>(3, l);
        return myList.last<Nat>(k);
    };

  public func test_size() : async Nat {
        var l : List<Nat> = null;
        var k : List<Nat> = List.push<Nat>(3, l);
        var z : List<Nat> = List.push<Nat>(4, k);
        return myList.size<Nat>(z);
    };

  public func test_get() : async ?Nat {
        var l : List<Nat> = null;
        var k : List<Nat> = List.push<Nat>(3, l);
        var z : List<Nat> = List.push<Nat>(4, k);
        return myList.get<Nat>(z,1);
    };

};
