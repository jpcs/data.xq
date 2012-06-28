# library module: http://snelson.org.uk/functions/data
 
 
# data.xq
 

An XQuery 3.0 library for defining algebraic data types, and performing
 structural pattern matching on them. This can be used to define complex
 data structures and the operations on them.

 
  


Author:  John Snelson
   June 28, 2012
  
Version:  0.1


## Table of Contents

* Functions: [declare\#1](#func_declare_1), [type\#1](#func_type_1), [describe\#1](#func_describe_1), [match\#2](#func_match_2), [match\#3](#func_match_3), [match\#4](#func_match_4), [match\#5](#func_match_5), [match\#6](#func_match_6), [match\#7](#func_match_7), [match\#8](#func_match_8), [match\#9](#func_match_9), [match\#10](#func_match_10), [match\#11](#func_match_11)


## Functions

### <a name="func_declare_1"/> declare\#1
```xquery
declare($decl as element()
) as  function(*)*
```
 
 Returns a sequence of constructor functions for the XML type
 description passed in as an argument. One constructor function is
 returned for each of the sub-types described. The constructor functions
 can be called to construct an instance of the type, passing in the
 values required the specific sub-type being created.

 

An example of an XML description is:
 

```xquery

 <Maybe>
   <Nothing/>
   <Just><data:Sequence/></Just>
 </Maybe>
 
```

 This defines a type named "Maybe", with two sub-types named "Nothing" and
 "Just". The "Nothing" constructor function takes no arguments, and store no
 additional data. The "Just" constructor function takes a single argument which
 is an arbitrary sequence. Passing this type description to this function will
 return two constructor functions, one for each sub-type.
 


 

Another example of an XML description is:
 

```xquery

 <Tree>
   <Empty/>
   <Leaf><data:Sequence/></Leaf>
   <Node><Tree/><Tree/></Node>
 </Tree>
 
```

 This defines a type named "Tree", with three sub-types named "Empty",
 "Leaf", and "Node". The "Node" constructor function takes two arguments,
 each of which will be type checked as a "Tree" object during construction.
 


 


#### Params

* $decl as  element(): An XML description of an algebraic data type.


#### Returns
*  function(\*)\*: A sequence of constructor functions for the given algebraic type description.

### <a name="func_type_1"/> type\#1
```xquery
type($v
) as  element()
```
 
 Returns the type of the value - that is, the child node in the
 XML type description that represents this value.

 


#### Params

* $v: A value, which must have been created by this library.


#### Returns
*  element(): The description element representing the type of the value.

### <a name="func_describe_1"/> describe\#1
```xquery
describe($v
) as  xs:string
```
 
 Returns a string serialization of the structure of the value. Non-algebraic
 types are serialized using the fn:string() function.

 


#### Params

* $v: A value, which must have been created by this library.


#### Returns
*  xs:string: The serialization of this value.

### <a name="func_match_2"/> match\#2
```xquery
match($v,$f1
)
```
 
 Performs structural pattern matching against the value. The pattern matching
 works by calling the function passed in in the same position as the sub-type
 of the value. Therefore the number of functions passed in as arguments must equal
 the number of sub-types of the value, and each function should have the same arity
 as its corresponding sub-type contains values.

 


#### Params

* $v: A value, which must have been created by this library.

* $f1: A function, which is called with the values from the first sub-type of the type.


### <a name="func_match_3"/> match\#3
```xquery
match($v,$f1,$f2
)
```
 
 Performs structural pattern matching against the value. The pattern matching
 works by calling the function passed in in the same position as the sub-type
 of the value. Therefore the number of functions passed in as arguments must equal
 the number of sub-types of the value, and each function should have the same arity
 as its corresponding sub-type contains values.

 


#### Params

* $v: A value, which must have been created by this library.

* $f1: A function, which is called with the values from the first sub-type of the type.

* $f2: A function, which is called with the values from the second sub-type of the type.


### <a name="func_match_4"/> match\#4
```xquery
match($v,$f1,$f2,$f3
)
```
 
 Performs structural pattern matching against the value. The pattern matching
 works by calling the function passed in in the same position as the sub-type
 of the value. Therefore the number of functions passed in as arguments must equal
 the number of sub-types of the value, and each function should have the same arity
 as its corresponding sub-type contains values.

 


#### Params

* $v: A value, which must have been created by this library.

* $f1: A function, which is called with the values from the first sub-type of the type.

* $f2: A function, which is called with the values from the second sub-type of the type.

* $f3: A function, which is called with the values from the third sub-type of the type.


### <a name="func_match_5"/> match\#5
```xquery
match($v,$f1,$f2,$f3,$f4
)
```
 
 Performs structural pattern matching against the value. The pattern matching
 works by calling the function passed in in the same position as the sub-type
 of the value. Therefore the number of functions passed in as arguments must equal
 the number of sub-types of the value, and each function should have the same arity
 as its corresponding sub-type contains values.

 


#### Params

* $v: A value, which must have been created by this library.

* $f1: A function, which is called with the values from the first sub-type of the type.

* $f2: A function, which is called with the values from the second sub-type of the type.

* $f3: A function, which is called with the values from the third sub-type of the type.

* $f4: A function, which is called with the values from the fourth sub-type of the type.


### <a name="func_match_6"/> match\#6
```xquery
match($v,$f1,$f2,$f3,$f4,$f5
)
```
 
 Performs structural pattern matching against the value. The pattern matching
 works by calling the function passed in in the same position as the sub-type
 of the value. Therefore the number of functions passed in as arguments must equal
 the number of sub-types of the value, and each function should have the same arity
 as its corresponding sub-type contains values.

 


#### Params

* $v: A value, which must have been created by this library.

* $f1: A function, which is called with the values from the first sub-type of the type.

* $f2: A function, which is called with the values from the second sub-type of the type.

* $f3: A function, which is called with the values from the third sub-type of the type.

* $f4: A function, which is called with the values from the fourth sub-type of the type.

* $f5: A function, which is called with the values from the fifth sub-type of the type.


### <a name="func_match_7"/> match\#7
```xquery
match($v,$f1,$f2,$f3,$f4,$f5,$f6
)
```
 
 Performs structural pattern matching against the value. The pattern matching
 works by calling the function passed in in the same position as the sub-type
 of the value. Therefore the number of functions passed in as arguments must equal
 the number of sub-types of the value, and each function should have the same arity
 as its corresponding sub-type contains values.

 


#### Params

* $v: A value, which must have been created by this library.

* $f1: A function, which is called with the values from the first sub-type of the type.

* $f2: A function, which is called with the values from the second sub-type of the type.

* $f3: A function, which is called with the values from the third sub-type of the type.

* $f4: A function, which is called with the values from the fourth sub-type of the type.

* $f5: A function, which is called with the values from the fifth sub-type of the type.

* $f6: A function, which is called with the values from the sixth sub-type of the type.


### <a name="func_match_8"/> match\#8
```xquery
match($v,$f1,$f2,$f3,$f4,$f5,$f6,$f7
)
```
 
 Performs structural pattern matching against the value. The pattern matching
 works by calling the function passed in in the same position as the sub-type
 of the value. Therefore the number of functions passed in as arguments must equal
 the number of sub-types of the value, and each function should have the same arity
 as its corresponding sub-type contains values.

 


#### Params

* $v: A value, which must have been created by this library.

* $f1: A function, which is called with the values from the first sub-type of the type.

* $f2: A function, which is called with the values from the second sub-type of the type.

* $f3: A function, which is called with the values from the third sub-type of the type.

* $f4: A function, which is called with the values from the fourth sub-type of the type.

* $f5: A function, which is called with the values from the fifth sub-type of the type.

* $f6: A function, which is called with the values from the sixth sub-type of the type.

* $f7: A function, which is called with the values from the seventh sub-type of the type.


### <a name="func_match_9"/> match\#9
```xquery
match($v,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$f8
)
```
 
 Performs structural pattern matching against the value. The pattern matching
 works by calling the function passed in in the same position as the sub-type
 of the value. Therefore the number of functions passed in as arguments must equal
 the number of sub-types of the value, and each function should have the same arity
 as its corresponding sub-type contains values.

 


#### Params

* $v: A value, which must have been created by this library.

* $f1: A function, which is called with the values from the first sub-type of the type.

* $f2: A function, which is called with the values from the second sub-type of the type.

* $f3: A function, which is called with the values from the third sub-type of the type.

* $f4: A function, which is called with the values from the fourth sub-type of the type.

* $f5: A function, which is called with the values from the fifth sub-type of the type.

* $f6: A function, which is called with the values from the sixth sub-type of the type.

* $f7: A function, which is called with the values from the seventh sub-type of the type.

* $f8: A function, which is called with the values from the eighth sub-type of the type.


### <a name="func_match_10"/> match\#10
```xquery
match($v,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$f8,$f9
)
```
 
 Performs structural pattern matching against the value. The pattern matching
 works by calling the function passed in in the same position as the sub-type
 of the value. Therefore the number of functions passed in as arguments must equal
 the number of sub-types of the value, and each function should have the same arity
 as its corresponding sub-type contains values.

 


#### Params

* $v: A value, which must have been created by this library.

* $f1: A function, which is called with the values from the first sub-type of the type.

* $f2: A function, which is called with the values from the second sub-type of the type.

* $f3: A function, which is called with the values from the third sub-type of the type.

* $f4: A function, which is called with the values from the fourth sub-type of the type.

* $f5: A function, which is called with the values from the fifth sub-type of the type.

* $f6: A function, which is called with the values from the sixth sub-type of the type.

* $f7: A function, which is called with the values from the seventh sub-type of the type.

* $f8: A function, which is called with the values from the eighth sub-type of the type.

* $f9: A function, which is called with the values from the ninth sub-type of the type.


### <a name="func_match_11"/> match\#11
```xquery
match($v,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$f8,$f9,$f10
)
```
 
 Performs structural pattern matching against the value. The pattern matching
 works by calling the function passed in in the same position as the sub-type
 of the value. Therefore the number of functions passed in as arguments must equal
 the number of sub-types of the value, and each function should have the same arity
 as its corresponding sub-type contains values.

 


#### Params

* $v: A value, which must have been created by this library.

* $f1: A function, which is called with the values from the first sub-type of the type.0: A function, which is called with the values from the tenth sub-type of the type.

* $f2: A function, which is called with the values from the second sub-type of the type.

* $f3: A function, which is called with the values from the third sub-type of the type.

* $f4: A function, which is called with the values from the fourth sub-type of the type.

* $f5: A function, which is called with the values from the fifth sub-type of the type.

* $f6: A function, which is called with the values from the sixth sub-type of the type.

* $f7: A function, which is called with the values from the seventh sub-type of the type.

* $f8: A function, which is called with the values from the eighth sub-type of the type.

* $f9: A function, which is called with the values from the ninth sub-type of the type.

* $f10: A function, which is called with the values from the tenth sub-type of the type.






*Generated by [xquerydoc](https://github.com/xquery/xquerydoc)*
