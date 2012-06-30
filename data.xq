xquery version "3.0";

(:
 : Copyright (c) 2010-2012 John Snelson
 :
 : Licensed under the Apache License, Version 2.0 (the "License");
 : you may not use this file except in compliance with the License.
 : You may obtain a copy of the License at
 :
 :     http://www.apache.org/licenses/LICENSE-2.0
 :
 : Unless required by applicable law or agreed to in writing, software
 : distributed under the License is distributed on an "AS IS" BASIS,
 : WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 : See the License for the specific language governing permissions and
 : limitations under the License.
 :)

(:~ 
 : <h1>data.xq</h1>
 : <p>An XQuery 3.0 library for defining algebraic data types, and performing
 : structural pattern matching on them. This can be used to define complex
 : data structures and the operations on them.</p>
 : 
 :  @author John Snelson
 :  @since June 28, 2012
 :  @version 0.1
 :)
module namespace data = "http://snelson.org.uk/functions/data";
declare default function namespace "http://snelson.org.uk/functions/data";

(:~ 
 : Returns a sequence of constructor functions for the XML type
 : description passed in as an argument. One constructor function is
 : returned for each of the sub-types described. The constructor functions
 : can be called to construct an instance of the type, passing in the
 : values required the specific sub-type being created.
 :
 : <p>An example of an XML description is:
 : <code>
 : &lt;Maybe>
 :   &lt;Nothing/>
 :   &lt;Just>&lt;data:Sequence/>&lt;/Just>
 : &lt;/Maybe>
 : </code>
 : This defines a type named "Maybe", with two sub-types named "Nothing" and
 : "Just". The "Nothing" constructor function takes no arguments, and store no
 : additional data. The "Just" constructor function takes a single argument which
 : is an arbitrary sequence. Passing this type description to this function will
 : return two constructor functions, one for each sub-type.
 : </p>
 :
 : <p>Another example of an XML description is:
 : <code>
 : &lt;Tree>
 :   &lt;Empty/>
 :   &lt;Leaf>&lt;data:Sequence/>&lt;/Leaf>
 :   &lt;Node>&lt;Tree/>&lt;Tree/>&lt;/Node>
 : &lt;/Tree>
 : </code>
 : This defines a type named "Tree", with three sub-types named "Empty",
 : "Leaf", and "Node". The "Node" constructor function takes two arguments,
 : each of which will be type checked as a "Tree" object during construction.
 : </p>
 :
 : @param $decl: An XML description of an algebraic data type.
 : 
 : @return A sequence of constructor functions for the given algebraic type description.
 :)
declare function declare($decl as element()) as function(*)*
{
  declare($decl,fn:true())
};

(:~ 
 : Returns a sequence of constructor functions for the XML type
 : description passed in as an argument. One constructor function is
 : returned for each of the sub-types described. The constructor functions
 : can be called to construct an instance of the type, passing in the
 : values required the specific sub-type being created.
 :
 : <p>An example of an XML description is:
 : <code>
 : &lt;Maybe>
 :   &lt;Nothing/>
 :   &lt;Just>&lt;data:Sequence/>&lt;/Just>
 : &lt;/Maybe>
 : </code>
 : This defines a type named "Maybe", with two sub-types named "Nothing" and
 : "Just". The "Nothing" constructor function takes no arguments, and store no
 : additional data. The "Just" constructor function takes a single argument which
 : is an arbitrary sequence. Passing this type description to this function will
 : return two constructor functions, one for each sub-type.
 : </p>
 :
 : <p>Another example of an XML description is:
 : <code>
 : &lt;Tree>
 :   &lt;Empty/>
 :   &lt;Leaf>&lt;data:Sequence/>&lt;/Leaf>
 :   &lt;Node>&lt;Tree/>&lt;Tree/>&lt;/Node>
 : &lt;/Tree>
 : </code>
 : This defines a type named "Tree", with three sub-types named "Empty",
 : "Leaf", and "Node". The "Node" constructor function takes two arguments,
 : each of which will be type checked as a "Tree" object during construction.
 : </p>
 :
 : @param $decl: An XML description of an algebraic data type.
 : @param $type-check: Setting this argument to false turns off type checking during
 : value construction, which can speed up data structure creation.
 : 
 : @return A sequence of constructor functions for the given algebraic type description.
 :)
declare function declare($decl as element(),$type-check as xs:boolean) as function(*)*
{
  let $total := fn:count($decl/*)
  for $entry at $position in $decl/*
  let $arity := fn:count($entry/*)
  return
    if($type-check) then switch($arity)
      case 0 return function() { construct($entry,$position,$total) }
      case 1 return constructd($entry,$position,$total,?)
      case 2 return constructd($entry,$position,$total,?,?)
      case 3 return constructd($entry,$position,$total,?,?,?)
      case 4 return constructd($entry,$position,$total,?,?,?,?)
      case 5 return constructd($entry,$position,$total,?,?,?,?,?)
      case 6 return constructd($entry,$position,$total,?,?,?,?,?,?)
      case 7 return constructd($entry,$position,$total,?,?,?,?,?,?,?)
      case 8 return constructd($entry,$position,$total,?,?,?,?,?,?,?,?)
      case 9 return constructd($entry,$position,$total,?,?,?,?,?,?,?,?,?)
      case 10 return constructd($entry,$position,$total,?,?,?,?,?,?,?,?,?,?)
      default return fn:error(xs:QName("data:BIGARITY"),
        "Type constructor arity too large: " || fn:string($arity))
    else switch($arity)
      case 0 return function() { construct($entry,$position,$total) }
      case 1 return construct($entry,$position,$total,?)
      case 2 return construct($entry,$position,$total,?,?)
      case 3 return construct($entry,$position,$total,?,?,?)
      case 4 return construct($entry,$position,$total,?,?,?,?)
      case 5 return construct($entry,$position,$total,?,?,?,?,?)
      case 6 return construct($entry,$position,$total,?,?,?,?,?,?)
      case 7 return construct($entry,$position,$total,?,?,?,?,?,?,?)
      case 8 return construct($entry,$position,$total,?,?,?,?,?,?,?,?)
      case 9 return construct($entry,$position,$total,?,?,?,?,?,?,?,?,?)
      case 10 return construct($entry,$position,$total,?,?,?,?,?,?,?,?,?,?)
      default return fn:error(xs:QName("data:BIGARITY"),
        "Type constructor arity too large: " || fn:string($arity))
};

declare %private function type-check($entry,$position,$value)
{
  let $type := $entry/*[$position]
  where fn:not(
    typeswitch($type)
    case element(data:Sequence) return fn:true()
    default return
      if($type/@occurrence = "*") then
        every $v in $value satisfies fn:node-name(type($v)/..) eq fn:node-name($type)
      else fn:empty(fn:tail($value)) and fn:node-name(type($value)/..) eq fn:node-name($type)
  )
  return fn:error(xs:QName("data:BADTYPE"),
    "Argument " || fn:string($position) || " to constructor function " ||
    fn:string(fn:node-name($entry)) || " is not of type " ||
    fn:string(fn:node-name($type)) || fn:string($type/@occurrence))
};

declare %private function construct($entry,$position,$total) as item()
{
  function($functions) {
    if(fn:empty($functions)) then $entry
    else if(fn:count($functions) ne $total) then fn:error(xs:QName("data:BADCASES"),
      "Wrong number of case functions, expecting: " || fn:string($total) ||
      ", actual: " || fn:string(fn:count($functions)))
    else $functions[$position] ! .()
  }
};

declare %private function construct($entry,$position,$total,$v1) as item()
{
  function($functions) {
    if(fn:empty($functions)) then $entry
    else if(fn:count($functions) ne $total) then fn:error(xs:QName("data:BADCASES"),
      "Wrong number of case functions, expecting: " || fn:string($total) ||
      ", actual: " || fn:string(fn:count($functions)))
    else $functions[$position]($v1)
  }
};

declare %private function construct($entry,$position,$total,$v1,$v2) as item()
{
  function($functions) {
    if(fn:empty($functions)) then $entry
    else if(fn:count($functions) ne $total) then fn:error(xs:QName("data:BADCASES"),
      "Wrong number of case functions, expecting: " || fn:string($total) ||
      ", actual: " || fn:string(fn:count($functions)))
    else $functions[$position]($v1,$v2)
  }
};

declare %private function construct($entry,$position,$total,$v1,$v2,$v3) as item()
{
  function($functions) {
    if(fn:empty($functions)) then $entry
    else if(fn:count($functions) ne $total) then fn:error(xs:QName("data:BADCASES"),
      "Wrong number of case functions, expecting: " || fn:string($total) ||
      ", actual: " || fn:string(fn:count($functions)))
    else $functions[$position]($v1,$v2,$v3)
  }
};

declare %private function construct($entry,$position,$total,$v1,$v2,$v3,$v4) as item()
{
  function($functions) {
    if(fn:empty($functions)) then $entry
    else if(fn:count($functions) ne $total) then fn:error(xs:QName("data:BADCASES"),
      "Wrong number of case functions, expecting: " || fn:string($total) ||
      ", actual: " || fn:string(fn:count($functions)))
    else $functions[$position]($v1,$v2,$v3,$v4)
  }
};

declare %private function construct($entry,$position,$total,$v1,$v2,$v3,$v4,$v5) as item()
{
  function($functions) {
    if(fn:empty($functions)) then $entry
    else if(fn:count($functions) ne $total) then fn:error(xs:QName("data:BADCASES"),
      "Wrong number of case functions, expecting: " || fn:string($total) ||
      ", actual: " || fn:string(fn:count($functions)))
    else $functions[$position]($v1,$v2,$v3,$v4,$v5)
  }
};

declare %private function construct($entry,$position,$total,$v1,$v2,$v3,$v4,$v5,$v6) as item()
{
  function($functions) {
    if(fn:empty($functions)) then $entry
    else if(fn:count($functions) ne $total) then fn:error(xs:QName("data:BADCASES"),
      "Wrong number of case functions, expecting: " || fn:string($total) ||
      ", actual: " || fn:string(fn:count($functions)))
    else $functions[$position]($v1,$v2,$v3,$v4,$v5,$v6)
  }
};

declare %private function construct($entry,$position,$total,$v1,$v2,$v3,$v4,$v5,$v6,$v7) as item()
{
  function($functions) {
    if(fn:empty($functions)) then $entry
    else if(fn:count($functions) ne $total) then fn:error(xs:QName("data:BADCASES"),
      "Wrong number of case functions, expecting: " || fn:string($total) ||
      ", actual: " || fn:string(fn:count($functions)))
    else $functions[$position]($v1,$v2,$v3,$v4,$v5,$v6,$v7)
  }
};

declare %private function construct($entry,$position,$total,$v1,$v2,$v3,$v4,$v5,$v6,$v7,$v8) as item()
{
  function($functions) {
    if(fn:empty($functions)) then $entry
    else if(fn:count($functions) ne $total) then fn:error(xs:QName("data:BADCASES"),
      "Wrong number of case functions, expecting: " || fn:string($total) ||
      ", actual: " || fn:string(fn:count($functions)))
    else $functions[$position]($v1,$v2,$v3,$v4,$v5,$v6,$v7,$v8)
  }
};

declare %private function construct($entry,$position,$total,$v1,$v2,$v3,$v4,$v5,$v6,$v7,$v8,$v9) as item()
{
  function($functions) {
    if(fn:empty($functions)) then $entry
    else if(fn:count($functions) ne $total) then fn:error(xs:QName("data:BADCASES"),
      "Wrong number of case functions, expecting: " || fn:string($total) ||
      ", actual: " || fn:string(fn:count($functions)))
    else $functions[$position]($v1,$v2,$v3,$v4,$v5,$v6,$v7,$v8,$v9)
  }
};

declare %private function construct($entry,$position,$total,$v1,$v2,$v3,$v4,$v5,$v6,$v7,$v8,$v9,$v10) as item()
{
  function($functions) {
    if(fn:empty($functions)) then $entry
    else if(fn:count($functions) ne $total) then fn:error(xs:QName("data:BADCASES"),
      "Wrong number of case functions, expecting: " || fn:string($total) ||
      ", actual: " || fn:string(fn:count($functions)))
    else $functions[$position]($v1,$v2,$v3,$v4,$v5,$v6,$v7,$v8,$v9,$v10)
  }
};

declare %private function constructd($entry,$position,$total,$v1) as item()
{
  type-check($entry,1,$v1),
  function($functions) {
    if(fn:empty($functions)) then $entry
    else if(fn:count($functions) ne $total) then fn:error(xs:QName("data:BADCASES"),
      "Wrong number of case functions, expecting: " || fn:string($total) ||
      ", actual: " || fn:string(fn:count($functions)))
    else $functions[$position]($v1)
  }
};

declare %private function constructd($entry,$position,$total,$v1,$v2) as item()
{
  type-check($entry,1,$v1),
  type-check($entry,2,$v2),
  function($functions) {
    if(fn:empty($functions)) then $entry
    else if(fn:count($functions) ne $total) then fn:error(xs:QName("data:BADCASES"),
      "Wrong number of case functions, expecting: " || fn:string($total) ||
      ", actual: " || fn:string(fn:count($functions)))
    else $functions[$position]($v1,$v2)
  }
};

declare %private function constructd($entry,$position,$total,$v1,$v2,$v3) as item()
{
  type-check($entry,1,$v1),
  type-check($entry,2,$v2),
  type-check($entry,3,$v3),
  function($functions) {
    if(fn:empty($functions)) then $entry
    else if(fn:count($functions) ne $total) then fn:error(xs:QName("data:BADCASES"),
      "Wrong number of case functions, expecting: " || fn:string($total) ||
      ", actual: " || fn:string(fn:count($functions)))
    else $functions[$position]($v1,$v2,$v3)
  }
};

declare %private function constructd($entry,$position,$total,$v1,$v2,$v3,$v4) as item()
{
  type-check($entry,1,$v1),
  type-check($entry,2,$v2),
  type-check($entry,3,$v3),
  type-check($entry,4,$v4),
  function($functions) {
    if(fn:empty($functions)) then $entry
    else if(fn:count($functions) ne $total) then fn:error(xs:QName("data:BADCASES"),
      "Wrong number of case functions, expecting: " || fn:string($total) ||
      ", actual: " || fn:string(fn:count($functions)))
    else $functions[$position]($v1,$v2,$v3,$v4)
  }
};

declare %private function constructd($entry,$position,$total,$v1,$v2,$v3,$v4,$v5) as item()
{
  type-check($entry,1,$v1),
  type-check($entry,2,$v2),
  type-check($entry,3,$v3),
  type-check($entry,4,$v4),
  type-check($entry,5,$v5),
  function($functions) {
    if(fn:empty($functions)) then $entry
    else if(fn:count($functions) ne $total) then fn:error(xs:QName("data:BADCASES"),
      "Wrong number of case functions, expecting: " || fn:string($total) ||
      ", actual: " || fn:string(fn:count($functions)))
    else $functions[$position]($v1,$v2,$v3,$v4,$v5)
  }
};

declare %private function constructd($entry,$position,$total,$v1,$v2,$v3,$v4,$v5,$v6) as item()
{
  type-check($entry,1,$v1),
  type-check($entry,2,$v2),
  type-check($entry,3,$v3),
  type-check($entry,4,$v4),
  type-check($entry,5,$v5),
  type-check($entry,6,$v6),
  function($functions) {
    if(fn:empty($functions)) then $entry
    else if(fn:count($functions) ne $total) then fn:error(xs:QName("data:BADCASES"),
      "Wrong number of case functions, expecting: " || fn:string($total) ||
      ", actual: " || fn:string(fn:count($functions)))
    else $functions[$position]($v1,$v2,$v3,$v4,$v5,$v6)
  }
};

declare %private function constructd($entry,$position,$total,$v1,$v2,$v3,$v4,$v5,$v6,$v7) as item()
{
  type-check($entry,1,$v1),
  type-check($entry,2,$v2),
  type-check($entry,3,$v3),
  type-check($entry,4,$v4),
  type-check($entry,5,$v5),
  type-check($entry,6,$v6),
  type-check($entry,7,$v7),
  function($functions) {
    if(fn:empty($functions)) then $entry
    else if(fn:count($functions) ne $total) then fn:error(xs:QName("data:BADCASES"),
      "Wrong number of case functions, expecting: " || fn:string($total) ||
      ", actual: " || fn:string(fn:count($functions)))
    else $functions[$position]($v1,$v2,$v3,$v4,$v5,$v6,$v7)
  }
};

declare %private function constructd($entry,$position,$total,$v1,$v2,$v3,$v4,$v5,$v6,$v7,$v8) as item()
{
  type-check($entry,1,$v1),
  type-check($entry,2,$v2),
  type-check($entry,3,$v3),
  type-check($entry,4,$v4),
  type-check($entry,5,$v5),
  type-check($entry,6,$v6),
  type-check($entry,7,$v7),
  type-check($entry,8,$v8),
  function($functions) {
    if(fn:empty($functions)) then $entry
    else if(fn:count($functions) ne $total) then fn:error(xs:QName("data:BADCASES"),
      "Wrong number of case functions, expecting: " || fn:string($total) ||
      ", actual: " || fn:string(fn:count($functions)))
    else $functions[$position]($v1,$v2,$v3,$v4,$v5,$v6,$v7,$v8)
  }
};

declare %private function constructd($entry,$position,$total,$v1,$v2,$v3,$v4,$v5,$v6,$v7,$v8,$v9) as item()
{
  type-check($entry,1,$v1),
  type-check($entry,2,$v2),
  type-check($entry,3,$v3),
  type-check($entry,4,$v4),
  type-check($entry,5,$v5),
  type-check($entry,6,$v6),
  type-check($entry,7,$v7),
  type-check($entry,8,$v8),
  type-check($entry,9,$v9),
  function($functions) {
    if(fn:empty($functions)) then $entry
    else if(fn:count($functions) ne $total) then fn:error(xs:QName("data:BADCASES"),
      "Wrong number of case functions, expecting: " || fn:string($total) ||
      ", actual: " || fn:string(fn:count($functions)))
    else $functions[$position]($v1,$v2,$v3,$v4,$v5,$v6,$v7,$v8,$v9)
  }
};

declare %private function constructd($entry,$position,$total,$v1,$v2,$v3,$v4,$v5,$v6,$v7,$v8,$v9,$v10) as item()
{
  type-check($entry,1,$v1),
  type-check($entry,2,$v2),
  type-check($entry,3,$v3),
  type-check($entry,4,$v4),
  type-check($entry,5,$v5),
  type-check($entry,6,$v6),
  type-check($entry,7,$v7),
  type-check($entry,8,$v8),
  type-check($entry,9,$v9),
  type-check($entry,10,$v10),
  function($functions) {
    if(fn:empty($functions)) then $entry
    else if(fn:count($functions) ne $total) then fn:error(xs:QName("data:BADCASES"),
      "Wrong number of case functions, expecting: " || fn:string($total) ||
      ", actual: " || fn:string(fn:count($functions)))
    else $functions[$position]($v1,$v2,$v3,$v4,$v5,$v6,$v7,$v8,$v9,$v10)
  }
};

(:~ 
 : Returns the type of the value - that is, the child node in the
 : XML type description that represents this value.
 :
 : @param $v: A value, which must have been created by this library.
 : 
 : @return The description element representing the type of the value.
 :)
declare function type($v as item()) as element()
{
  $v(())
};

declare %private function newline($indent)
{
  "&#xa;" || fn:string-join(((1 to $indent) ! "  "))
};

(:~ 
 : Returns a string serialization of the structure of the values. Non-algebraic
 : types are serialized using the fn:string() function.
 :
 : @param $v: A sequence of values, which must have been created by this library.
 : 
 : @return The serialization of the values.
 :)
declare function describe($v) as xs:string
{
  describe-data(0,$v)
};

declare %private function describe-sequence($indent,$v)
{
  typeswitch($v)
  case xs:decimal | xs:float | xs:double return fn:string($v)
  case item() return '"' || fn:string($v) || '"'
  default return "(" || fn:string-join($v ! describe-sequence($indent,.),", ") || ")"
};

declare %private function describe-data($indent,$v)
{
  typeswitch($v)
  case item() return
    let $entry := type($v)
    let $total := fn:count($entry/../*)
    return (
      "[" || fn:string(fn:node-name($entry/..)) ||
      "/" || fn:string(fn:node-name($entry)) ||
      (switch(fn:count($entry/*))
      case 0 return ""
      case 1 return $v((1 to $total) ! describe-one($entry,$indent + 1,?))
      case 2 return $v((1 to $total) ! describe-many($entry,$indent + 1,?,?))
      case 3 return $v((1 to $total) ! describe-many($entry,$indent + 1,?,?,?))
      case 4 return $v((1 to $total) ! describe-many($entry,$indent + 1,?,?,?,?))
      case 5 return $v((1 to $total) ! describe-many($entry,$indent + 1,?,?,?,?,?))
      case 6 return $v((1 to $total) ! describe-many($entry,$indent + 1,?,?,?,?,?,?))
      case 7 return $v((1 to $total) ! describe-many($entry,$indent + 1,?,?,?,?,?,?,?))
      case 8 return $v((1 to $total) ! describe-many($entry,$indent + 1,?,?,?,?,?,?,?,?))
      case 9 return $v((1 to $total) ! describe-many($entry,$indent + 1,?,?,?,?,?,?,?,?,?))
      case 10 return $v((1 to $total) ! describe-many($entry,$indent + 1,?,?,?,?,?,?,?,?,?,?))
      default return fn:error(xs:QName("data:BIGARITY"),
        "Type constructor arity too large: " || fn:string(fn:count($entry/*))))
      || "]"
    )
  default return "(" ||
    fn:string-join($v ! (newline($indent + 1) || describe-data($indent + 1,.))) || ")"
};

declare %private function describe-type($entry, $position, $indent, $v)
{
  let $type := $entry/*[$position]
  return
    typeswitch($type)
    case element(data:Sequence) return describe-sequence($indent,$v)
    default return describe-data($indent,$v)
};

declare %private function describe-one($entry, $indent, $v1)
{
  " " || describe-type($entry,1,$indent - 1,$v1)
};

declare %private function describe-many($entry, $indent, $v1, $v2)
{
  newline($indent) || describe-type($entry,1,$indent,$v1) ||
  newline($indent) || describe-type($entry,2,$indent,$v2)
};

declare %private function describe-many($entry, $indent, $v1, $v2, $v3)
{
  newline($indent) || describe-type($entry,1,$indent,$v1) ||
  newline($indent) || describe-type($entry,2,$indent,$v2) ||
  newline($indent) || describe-type($entry,3,$indent,$v3)
};

declare %private function describe-many($entry, $indent, $v1, $v2, $v3, $v4)
{
  newline($indent) || describe-type($entry,1,$indent,$v1) ||
  newline($indent) || describe-type($entry,2,$indent,$v2) ||
  newline($indent) || describe-type($entry,3,$indent,$v3) ||
  newline($indent) || describe-type($entry,4,$indent,$v4)
};

declare %private function describe-many($entry, $indent, $v1, $v2, $v3, $v4, $v5)
{
  newline($indent) || describe-type($entry,1,$indent,$v1) ||
  newline($indent) || describe-type($entry,2,$indent,$v2) ||
  newline($indent) || describe-type($entry,3,$indent,$v3) ||
  newline($indent) || describe-type($entry,4,$indent,$v4) ||
  newline($indent) || describe-type($entry,5,$indent,$v5)
};

declare %private function describe-many($entry, $indent, $v1, $v2, $v3, $v4, $v5, $v6)
{
  newline($indent) || describe-type($entry,1,$indent,$v1) ||
  newline($indent) || describe-type($entry,2,$indent,$v2) ||
  newline($indent) || describe-type($entry,3,$indent,$v3) ||
  newline($indent) || describe-type($entry,4,$indent,$v4) ||
  newline($indent) || describe-type($entry,5,$indent,$v5) ||
  newline($indent) || describe-type($entry,6,$indent,$v6)
};

declare %private function describe-many($entry, $indent, $v1, $v2, $v3, $v4, $v5, $v6, $v7)
{
  newline($indent) || describe-type($entry,1,$indent,$v1) ||
  newline($indent) || describe-type($entry,2,$indent,$v2) ||
  newline($indent) || describe-type($entry,3,$indent,$v3) ||
  newline($indent) || describe-type($entry,4,$indent,$v4) ||
  newline($indent) || describe-type($entry,5,$indent,$v5) ||
  newline($indent) || describe-type($entry,6,$indent,$v6) ||
  newline($indent) || describe-type($entry,7,$indent,$v7)
};

declare %private function describe-many($entry, $indent, $v1, $v2, $v3, $v4, $v5, $v6, $v7, $v8)
{
  newline($indent) || describe-type($entry,1,$indent,$v1) ||
  newline($indent) || describe-type($entry,2,$indent,$v2) ||
  newline($indent) || describe-type($entry,3,$indent,$v3) ||
  newline($indent) || describe-type($entry,4,$indent,$v4) ||
  newline($indent) || describe-type($entry,5,$indent,$v5) ||
  newline($indent) || describe-type($entry,6,$indent,$v6) ||
  newline($indent) || describe-type($entry,7,$indent,$v7) ||
  newline($indent) || describe-type($entry,8,$indent,$v8)
};

declare %private function describe-many($entry, $indent, $v1, $v2, $v3, $v4, $v5, $v6, $v7, $v8, $v9)
{
  newline($indent) || describe-type($entry,1,$indent,$v1) ||
  newline($indent) || describe-type($entry,2,$indent,$v2) ||
  newline($indent) || describe-type($entry,3,$indent,$v3) ||
  newline($indent) || describe-type($entry,4,$indent,$v4) ||
  newline($indent) || describe-type($entry,5,$indent,$v5) ||
  newline($indent) || describe-type($entry,6,$indent,$v6) ||
  newline($indent) || describe-type($entry,7,$indent,$v7) ||
  newline($indent) || describe-type($entry,8,$indent,$v8) ||
  newline($indent) || describe-type($entry,9,$indent,$v9)
};

declare %private function describe-many($entry, $indent, $v1, $v2, $v3, $v4, $v5, $v6, $v7, $v8, $v9, $v10)
{
  newline($indent) || describe-type($entry,1,$indent,$v1) ||
  newline($indent) || describe-type($entry,2,$indent,$v2) ||
  newline($indent) || describe-type($entry,3,$indent,$v3) ||
  newline($indent) || describe-type($entry,4,$indent,$v4) ||
  newline($indent) || describe-type($entry,5,$indent,$v5) ||
  newline($indent) || describe-type($entry,6,$indent,$v6) ||
  newline($indent) || describe-type($entry,7,$indent,$v7) ||
  newline($indent) || describe-type($entry,8,$indent,$v8) ||
  newline($indent) || describe-type($entry,9,$indent,$v9) ||
  newline($indent) || describe-type($entry,10,$indent,$v10)
};

(:~ 
 : Performs structural pattern matching against the value. The pattern matching
 : works by calling the function passed in in the same position as the sub-type
 : of the value. Therefore the number of functions passed in as arguments must equal
 : the number of sub-types of the value, and each function should have the same arity
 : as its corresponding sub-type contains values.
 :
 : @param $v: A value, which must have been created by this library.
 : @param $f1: A function, which is called with the values from the first sub-type of the type.
 : 
 : @return The result of the function called.
 :)
declare function match(
  $v as item(),
  $f1 as function(*))
{
  $v($f1)
};

(:~ 
 : Performs structural pattern matching against the value. The pattern matching
 : works by calling the function passed in in the same position as the sub-type
 : of the value. Therefore the number of functions passed in as arguments must equal
 : the number of sub-types of the value, and each function should have the same arity
 : as its corresponding sub-type contains values.
 :
 : @param $v: A value, which must have been created by this library.
 : @param $f1: A function, which is called with the values from the first sub-type of the type.
 : @param $f2: A function, which is called with the values from the second sub-type of the type.
 : 
 : @return The result of the function called.
 :)
declare function match(
  $v as item(),
  $f1 as function(*),
  $f2 as function(*))
{
  $v(($f1,$f2))
};

(:~ 
 : Performs structural pattern matching against the value. The pattern matching
 : works by calling the function passed in in the same position as the sub-type
 : of the value. Therefore the number of functions passed in as arguments must equal
 : the number of sub-types of the value, and each function should have the same arity
 : as its corresponding sub-type contains values.
 :
 : @param $v: A value, which must have been created by this library.
 : @param $f1: A function, which is called with the values from the first sub-type of the type.
 : @param $f2: A function, which is called with the values from the second sub-type of the type.
 : @param $f3: A function, which is called with the values from the third sub-type of the type.
 : 
 : @return The result of the function called.
 :)
declare function match(
  $v as item(),
  $f1 as function(*),
  $f2 as function(*),
  $f3 as function(*))
{
  $v(($f1,$f2,$f3))
};

(:~ 
 : Performs structural pattern matching against the value. The pattern matching
 : works by calling the function passed in in the same position as the sub-type
 : of the value. Therefore the number of functions passed in as arguments must equal
 : the number of sub-types of the value, and each function should have the same arity
 : as its corresponding sub-type contains values.
 :
 : @param $v: A value, which must have been created by this library.
 : @param $f1: A function, which is called with the values from the first sub-type of the type.
 : @param $f2: A function, which is called with the values from the second sub-type of the type.
 : @param $f3: A function, which is called with the values from the third sub-type of the type.
 : @param $f4: A function, which is called with the values from the fourth sub-type of the type.
 : 
 : @return The result of the function called.
 :)
declare function match(
  $v as item(),
  $f1 as function(*),
  $f2 as function(*),
  $f3 as function(*),
  $f4 as function(*))
{
  $v(($f1,$f2,$f3,$f4))
};

(:~ 
 : Performs structural pattern matching against the value. The pattern matching
 : works by calling the function passed in in the same position as the sub-type
 : of the value. Therefore the number of functions passed in as arguments must equal
 : the number of sub-types of the value, and each function should have the same arity
 : as its corresponding sub-type contains values.
 :
 : @param $v: A value, which must have been created by this library.
 : @param $f1: A function, which is called with the values from the first sub-type of the type.
 : @param $f2: A function, which is called with the values from the second sub-type of the type.
 : @param $f3: A function, which is called with the values from the third sub-type of the type.
 : @param $f4: A function, which is called with the values from the fourth sub-type of the type.
 : @param $f5: A function, which is called with the values from the fifth sub-type of the type.
 : 
 : @return The result of the function called.
 :)
declare function match(
  $v as item(),
  $f1 as function(*),
  $f2 as function(*),
  $f3 as function(*),
  $f4 as function(*),
  $f5 as function(*))
{
  $v(($f1,$f2,$f3,$f4,$f5))
};

(:~ 
 : Performs structural pattern matching against the value. The pattern matching
 : works by calling the function passed in in the same position as the sub-type
 : of the value. Therefore the number of functions passed in as arguments must equal
 : the number of sub-types of the value, and each function should have the same arity
 : as its corresponding sub-type contains values.
 :
 : @param $v: A value, which must have been created by this library.
 : @param $f1: A function, which is called with the values from the first sub-type of the type.
 : @param $f2: A function, which is called with the values from the second sub-type of the type.
 : @param $f3: A function, which is called with the values from the third sub-type of the type.
 : @param $f4: A function, which is called with the values from the fourth sub-type of the type.
 : @param $f5: A function, which is called with the values from the fifth sub-type of the type.
 : @param $f6: A function, which is called with the values from the sixth sub-type of the type.
 : 
 : @return The result of the function called.
 :)
declare function match(
  $v as item(),
  $f1 as function(*),
  $f2 as function(*),
  $f3 as function(*),
  $f4 as function(*),
  $f5 as function(*),
  $f6 as function(*))
{
  $v(($f1,$f2,$f3,$f4,$f5,$f6))
};

(:~ 
 : Performs structural pattern matching against the value. The pattern matching
 : works by calling the function passed in in the same position as the sub-type
 : of the value. Therefore the number of functions passed in as arguments must equal
 : the number of sub-types of the value, and each function should have the same arity
 : as its corresponding sub-type contains values.
 :
 : @param $v: A value, which must have been created by this library.
 : @param $f1: A function, which is called with the values from the first sub-type of the type.
 : @param $f2: A function, which is called with the values from the second sub-type of the type.
 : @param $f3: A function, which is called with the values from the third sub-type of the type.
 : @param $f4: A function, which is called with the values from the fourth sub-type of the type.
 : @param $f5: A function, which is called with the values from the fifth sub-type of the type.
 : @param $f6: A function, which is called with the values from the sixth sub-type of the type.
 : @param $f7: A function, which is called with the values from the seventh sub-type of the type.
 : 
 : @return The result of the function called.
 :)
declare function match(
  $v as item(),
  $f1 as function(*),
  $f2 as function(*),
  $f3 as function(*),
  $f4 as function(*),
  $f5 as function(*),
  $f6 as function(*),
  $f7 as function(*))
{
  $v(($f1,$f2,$f3,$f4,$f5,$f6,$f7))
};

(:~ 
 : Performs structural pattern matching against the value. The pattern matching
 : works by calling the function passed in in the same position as the sub-type
 : of the value. Therefore the number of functions passed in as arguments must equal
 : the number of sub-types of the value, and each function should have the same arity
 : as its corresponding sub-type contains values.
 :
 : @param $v: A value, which must have been created by this library.
 : @param $f1: A function, which is called with the values from the first sub-type of the type.
 : @param $f2: A function, which is called with the values from the second sub-type of the type.
 : @param $f3: A function, which is called with the values from the third sub-type of the type.
 : @param $f4: A function, which is called with the values from the fourth sub-type of the type.
 : @param $f5: A function, which is called with the values from the fifth sub-type of the type.
 : @param $f6: A function, which is called with the values from the sixth sub-type of the type.
 : @param $f7: A function, which is called with the values from the seventh sub-type of the type.
 : @param $f8: A function, which is called with the values from the eighth sub-type of the type.
 : 
 : @return The result of the function called.
 :)
declare function match(
  $v as item(),
  $f1 as function(*),
  $f2 as function(*),
  $f3 as function(*),
  $f4 as function(*),
  $f5 as function(*),
  $f6 as function(*),
  $f7 as function(*),
  $f8 as function(*))
{
  $v(($f1,$f2,$f3,$f4,$f5,$f6,$f7,$f8))
};

(:~ 
 : Performs structural pattern matching against the value. The pattern matching
 : works by calling the function passed in in the same position as the sub-type
 : of the value. Therefore the number of functions passed in as arguments must equal
 : the number of sub-types of the value, and each function should have the same arity
 : as its corresponding sub-type contains values.
 :
 : @param $v: A value, which must have been created by this library.
 : @param $f1: A function, which is called with the values from the first sub-type of the type.
 : @param $f2: A function, which is called with the values from the second sub-type of the type.
 : @param $f3: A function, which is called with the values from the third sub-type of the type.
 : @param $f4: A function, which is called with the values from the fourth sub-type of the type.
 : @param $f5: A function, which is called with the values from the fifth sub-type of the type.
 : @param $f6: A function, which is called with the values from the sixth sub-type of the type.
 : @param $f7: A function, which is called with the values from the seventh sub-type of the type.
 : @param $f8: A function, which is called with the values from the eighth sub-type of the type.
 : @param $f9: A function, which is called with the values from the ninth sub-type of the type.
 : 
 : @return The result of the function called.
 :)
declare function match(
  $v as item(),
  $f1 as function(*),
  $f2 as function(*),
  $f3 as function(*),
  $f4 as function(*),
  $f5 as function(*),
  $f6 as function(*),
  $f7 as function(*),
  $f8 as function(*),
  $f9 as function(*))
{
  $v(($f1,$f2,$f3,$f4,$f5,$f6,$f7,$f8,$f9))
};

(:~ 
 : Performs structural pattern matching against the value. The pattern matching
 : works by calling the function passed in in the same position as the sub-type
 : of the value. Therefore the number of functions passed in as arguments must equal
 : the number of sub-types of the value, and each function should have the same arity
 : as its corresponding sub-type contains values.
 :
 : @param $v: A value, which must have been created by this library.
 : @param $f1: A function, which is called with the values from the first sub-type of the type.
 : @param $f2: A function, which is called with the values from the second sub-type of the type.
 : @param $f3: A function, which is called with the values from the third sub-type of the type.
 : @param $f4: A function, which is called with the values from the fourth sub-type of the type.
 : @param $f5: A function, which is called with the values from the fifth sub-type of the type.
 : @param $f6: A function, which is called with the values from the sixth sub-type of the type.
 : @param $f7: A function, which is called with the values from the seventh sub-type of the type.
 : @param $f8: A function, which is called with the values from the eighth sub-type of the type.
 : @param $f9: A function, which is called with the values from the ninth sub-type of the type.
 : @param $f10: A function, which is called with the values from the tenth sub-type of the type.
 : 
 : @return The result of the function called.
 :)
declare function match(
  $v as item(),
  $f1 as function(*),
  $f2 as function(*),
  $f3 as function(*),
  $f4 as function(*),
  $f5 as function(*),
  $f6 as function(*),
  $f7 as function(*),
  $f8 as function(*),
  $f9 as function(*),
  $f10 as function(*))
{
  $v(($f1,$f2,$f3,$f4,$f5,$f6,$f7,$f8,$f9,$f10))
};
