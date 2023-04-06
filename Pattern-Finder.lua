local match_found=false
local g=golly()
local space_layer=g.getlayer()
local term_layer=space_layer+1
if term_layer==g.numlayers() then
 g.exit("no next layer")
end
g.setlayer(term_layer)
local term_rectangle=g.getrect()
if #term_rectangle==0 then
 g.setlayer(space_layer)
 g.exit("no pattern in next layer")
end
local term=g.getcells(term_rectangle)
local term_hash=g.hash(term_rectangle)
g.setlayer(space_layer)
local search_rectangle=g.getrect()
local search_left=search_rectangle[1]
local term_left=term_rectangle[1]
local search_top=search_rectangle[2]
local term_top=term_rectangle[2]
local term_length=term_rectangle[3]
local search_height=search_rectangle[4]
local term_height=term_rectangle[4]
if #search_rectangle~=0 and term_length<=search_rectangle[3] and term_height<=search_height then
 for delta_x=0,search_rectangle[3]-term_length do
  for delta_y=0,search_height-term_height do
   if g.hash({search_left+delta_x,search_top+delta_y,term_length,term_height})==term_hash then
    local matching=true
    local pattern=g.getcells({search_left+delta_x,search_top+delta_y,term_length,term_height})
    if #term~=#pattern then
     matching=false
    else
     for point=1,#term/2 do
      if term[2*point-1]-term_left~=pattern[2*point-1]-search_left-delta_x or term[2*point]-term_top~=pattern[2*point]-search_top-delta_y then
       matching=false
       break
      end
     end
    end
    if matching then
     match_found=true
     g.show("match found at ("..search_left+delta_x..","..search_top+delta_y..")")
     goto there
    end
   end
  end
 end
end
::there::
if not match_found then
 g.show("no match found")
end