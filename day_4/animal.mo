module {
    public type Animal = {
        specie : Text;
        energy : Nat;
    };

    public func animal_sleep(myanimal : Animal) : Animal {
        var newanimal : Animal = {
            specie = myanimal.specie;
            energy = myanimal.energy + 10;
        } ;
      
        return newanimal;
    };
}