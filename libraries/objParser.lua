--.OBJ file parser
function readObjFile(file)
  io.input(file,"r+")

  
  
  local pointOrder=1
  local triOrder=1
  
  local lineNum=1
  
  local verticePattern = '^v (%S+) (%S+) (%S+)'
  local uvPattern = '^vt (%S+) (%S+)'
  local facePattern1 = '^f (%d+) (%d+) (%d+)'
  local facePattern2 = '^f (%d+)/(%d+) (%d+)/(%d+) (%d+)/(%d+)'
  
  local bufferOrder = 1
  
  local pointsBuffer ={}
  local pointList={}
  local triList={}
  local uvList={}
  local uvMap={}
  
  table.insert(models,mesh:new())
  modelNumber=modelNumber+1
  
  for line in io.lines(file) do

    --print(line)
    if line:find(verticePattern) then
      local x2,y2,z2 = 
      line:gsub(verticePattern,'%1'),
      line:gsub(verticePattern,'%2'),
      line:gsub(verticePattern,'%3')
      x2=tonumber(x2)
      y2=tonumber(y2)
      z2=tonumber(z2)
      
      table.insert(pointList,point:new{x=x2,y=y2,z=z2})
    end
    
    if line:find(uvPattern) then
      local u2,v2 = 
      line:gsub(uvPattern,'%1'),
      line:gsub(uvPattern,'%2')
      u2=tonumber(u2)
      v2=tonumber(v2)
      
      table.insert(uvList,uvCoordinate:new{u=u2,v=v2})
    end
    
    if line:find(facePattern1) then
      local point11,point22,point33 = 
      line:gsub(facePattern1,'%1'),
      line:gsub(facePattern1,'%2'),
      line:gsub(facePattern1,'%3')
      point11=tonumber(point11)
      point22=tonumber(point22)
      point33=tonumber(point33)
      table.insert(triList, triangle:new{
          point1=pointList[point11],
          point2=pointList[point22],
          point3=pointList[point33]})
     
    end
    
    if line:find(facePattern2) then
      local point11,point22,point33 = 
      line:gsub(facePattern2,'%1'),
      line:gsub(facePattern2,'%3'),
      line:gsub(facePattern2,'%5')
      point11=tonumber(point11)
      point22=tonumber(point22)
      point33=tonumber(point33)
    
      local mapPoint11,mapPoint22,mapPoint33 = 
      line:gsub(facePattern2,'%2'),
      line:gsub(facePattern2,'%4'),
      line:gsub(facePattern2,'%6')
      mapPoint11=tonumber(mapPoint11)
      mapPoint22=tonumber(mapPoint22)
      mapPoint33=tonumber(mapPoint33)
      
      local t=
      triangle:new{
          point1=pointList[point11],
          point2=pointList[point22],
          point3=pointList[point33]
      }

      t.point1.uv=uvList[mapPoint11]
      t.point2.uv=uvList[mapPoint22]
      t.point3.uv=uvList[mapPoint33]
    
      table.insert(triList,t )
    end
end

models[modelNumber].tris=triList
 
models[modelNumber].uvCoords=uvList



end