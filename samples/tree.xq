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

import module namespace data = "http://snelson.org.uk/functions/data" at "../data.xq";

declare variable $tree := data:declare(
<Tree>
  <Empty/>
  <Leaf><data:Sequence/></Leaf>
  <Node><Tree/><Tree/></Node>
</Tree>);

declare function local:empty() { $tree[1]() };
declare function local:leaf($v) { $tree[2]($v) };
declare function local:node($l,$r) { $tree[3]($l,$r) };

declare function local:depth($t)
{
  if(node-name(data:type($t)/..) ne xs:QName("Tree")) then error() else
  data:match($t,
    function() { 0 },
    function($v) { 1 },
    function($l, $r) { 1 + max((local:depth($l),local:depth($r))) }
  )
};

let $t := local:node(
  local:node(
    local:empty(),
    local:leaf(5)
  ),
  local:node(
    local:node(
      local:leaf(2),
      local:node(
        local:leaf(4),
        local:empty()
      )
    ),
    local:empty()
  )
)
return (
  data:type($t),
  data:describe($t),
  local:depth($t)
)
