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

declare variable $maybe := data:declare(
<Maybe>
  <Nothing/>
  <Just><data:Sequence/></Just>
</Maybe>);

declare function local:from-maybe($default,$maybe)
{
  data:match($maybe,
    (: Nothing :) function() { $default },
    (: Just :) function($v) { $v }
  )
};

declare function local:cat-maybes($maybes)
{
  $maybes ! data:match(.,
    (: Nothing :) function() { () },
    (: Just :) function($v) { $v }
  )
};

let $data := ($maybe[1](), $maybe[2]("foo"), $maybe[1](), $maybe[2](99))
return (
  local:cat-maybes($data),
  data:describe($data),
  $data ! local:from-maybe("MISSING",.)
)
