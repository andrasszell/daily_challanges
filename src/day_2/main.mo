
import Nat8 "mo:base/Nat8";
import Nat8Lib "mo:base/Nat8";
import Char "mo:base/Char";
import CharLib "mo:base/Char";
import Text "mo:base/Text";
import Bool "mo:base/Bool";
import Iter "mo:base/Iter";
import Array "mo:base/Array";


actor {

  public func nat_to_nat8( mynum : Nat ) : async Nat8 {

    if( (mynum >= 0) and (mynum <= 255) )  {
      let outnum : Nat8 = Nat8Lib.fromNat(mynum);
      return outnum;
    } else {
      return 0;
    };
    
  };

  public func max_number_with_n_bits( n : Nat ) : async Nat {
    return 2 ** n - 1;
  };

  public func decimal_to_bits( n : Nat ) : async Text {
    var rem : Nat8 = 1;
    var bintext : Text = "";
    var myn : Nat = n;

    while (myn > 0) {
      rem := Nat8Lib.fromNat(myn % 2);
      myn := (myn-Nat8Lib.toNat(rem))/2;
      bintext := Nat8Lib.toText(rem) # bintext;
    };
    return bintext;
  };

  public func capitalize_character( c : Char ) : async Char {
    let ascicode : Nat32 = CharLib.toNat32(c);
    if (ascicode > 96 and ascicode < 123) {
      return CharLib.fromNat32(ascicode - 32);
    }
    else {
      return c;
    };
  };

  public func capitalize_text( textin: Text ) : async Text {
    var newtext : Text = "";
    var dumchar : Char = 'a';
    var ascicode : Nat32 = 0;
    //dumchar := capitalize_character(dumchar);

    for(char in textin.chars()){
      ascicode := CharLib.toNat32(char);
      dumchar := CharLib.fromNat32(ascicode-32);
      if (ascicode > 96 and ascicode < 123) {
        newtext := newtext # CharLib.toText(dumchar);
      }
      else
      {
        newtext := newtext # CharLib.toText(char);
      }
    };

    return newtext;

  };

  public func is_inside( textin: Text, inchar : Char ) : async Bool  {
    var isin : Bool = false;

    for(char in textin.chars()){
      if ( CharLib.equal(char,inchar) )
        isin := true;
    };
    return isin;

  };

  public func trim_whitespace( textin: Text) : async Text  {
    
    return Text.trim(textin, #text " ");

  };

  public func duplicated_character( textin: Text) : async Text  {
    var oldchar : Char = ' ';
    var isin : Bool = false;
    var rettext : Text = "";

    for(char in textin.chars()){
      if ( Char.equal(char,oldchar) and Bool.lognot(isin) )  {
        isin := true;
        rettext := Char.toText(char);
      };
      oldchar := char;
    };

    if isin {
      return rettext;
    }
    else
    {
      return textin;
    }

  };

  public func size_in_bytes( textin: Text) : async Nat  {
    
    return textin.size()*8;

  };

  public func bubble_sort( myarray : [Nat]) : async [Nat]  {
    let length = myarray.size();
    var dummy = 0;
    var j = 0;
    var i = 0;
    let yarray : [var Nat] = Array.init<Nat>(length, 0);

    for (a in myarray.vals() )
    {
      yarray[i] := a;
      i := i + 1;
    };
    i := 1;
    for (a in yarray.vals() )
    {
      if ( (length - i - 1) >= 1) {
        for (j in Iter.range(1, length - i - 1)) {
          if (yarray[j] > yarray[j+1]) {
            dummy := yarray[j+1];
            yarray[j+1] := yarray[j];
            yarray[j] := dummy;
          };
        };
        i := i + 1;
      };
    };
    return Array.freeze(yarray);

  };

};
