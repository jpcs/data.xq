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

module namespace data = "http://snelson.org.uk/functions/data";
declare default function namespace "http://snelson.org.uk/functions/data";

declare function declare($decl)
{
  let $total := fn:count($decl/*)
  for $entry at $position in $decl/*
  let $arity := fn:count($entry/*)
  return
    switch($arity)
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

declare %private function construct($entry,$position,$total)
{
  function($functions) {
    if(fn:empty($functions)) then $entry
    else if(fn:count($functions) ne $total) then fn:error(xs:QName("data:BADCASES"),
      "Wrong number of case functions, expecting: " || fn:string($total) ||
      ", actual: " || fn:string(fn:count($functions)))
    else $functions[$position] ! .()
  }
};

declare %private function construct($entry,$position,$total,$v1)
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

declare %private function construct($entry,$position,$total,$v1,$v2)
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

declare %private function construct($entry,$position,$total,$v1,$v2,$v3)
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

declare %private function construct($entry,$position,$total,$v1,$v2,$v3,$v4)
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

declare %private function construct($entry,$position,$total,$v1,$v2,$v3,$v4,$v5)
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

declare %private function construct($entry,$position,$total,$v1,$v2,$v3,$v4,$v5,$v6)
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

declare %private function construct($entry,$position,$total,$v1,$v2,$v3,$v4,$v5,$v6,$v7)
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

declare %private function construct($entry,$position,$total,$v1,$v2,$v3,$v4,$v5,$v6,$v7,$v8)
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

declare %private function construct($entry,$position,$total,$v1,$v2,$v3,$v4,$v5,$v6,$v7,$v8,$v9)
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

declare %private function construct($entry,$position,$total,$v1,$v2,$v3,$v4,$v5,$v6,$v7,$v8,$v9,$v10)
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

declare function type($v)
{
  $v(())
};

declare %private function newline($indent)
{
  "&#xa;" || fn:string-join(((1 to $indent) ! "  "))
};

declare function describe($v)
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
  " " || describe-type($entry,1,$indent,$v1)
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

declare function match($v,$f1)
{
  $v($f1)
};

declare function match($v,$f1,$f2)
{
  $v(($f1,$f2))
};

declare function match($v,$f1,$f2,$f3)
{
  $v(($f1,$f2,$f3))
};

declare function match($v,$f1,$f2,$f3,$f4)
{
  $v(($f1,$f2,$f3,$f4))
};

declare function match($v,$f1,$f2,$f3,$f4,$f5)
{
  $v(($f1,$f2,$f3,$f4,$f5))
};

declare function match($v,$f1,$f2,$f3,$f4,$f5,$f6)
{
  $v(($f1,$f2,$f3,$f4,$f5,$f6))
};

declare function match($v,$f1,$f2,$f3,$f4,$f5,$f6,$f7)
{
  $v(($f1,$f2,$f3,$f4,$f5,$f6,$f7))
};

declare function match($v,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$f8)
{
  $v(($f1,$f2,$f3,$f4,$f5,$f6,$f7,$f8))
};

declare function match($v,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$f8,$f9)
{
  $v(($f1,$f2,$f3,$f4,$f5,$f6,$f7,$f8,$f9))
};

declare function match($v,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$f8,$f9,$f10)
{
  $v(($f1,$f2,$f3,$f4,$f5,$f6,$f7,$f8,$f9,$f10))
};
