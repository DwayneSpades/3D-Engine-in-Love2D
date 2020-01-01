object=
{
  new=function (self,o)
  o = o or {}
  setmetatable(o,self)
  self.__index = self
  return o
  end,

--more explicitly named function
--there is a possible optimization 
--to make this more appropriate

inherit=function (self,o)
  o = o or {}
  setmetatable(o,self)
  self.__index = self
  return o
  end
}

