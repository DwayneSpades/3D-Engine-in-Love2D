--.OBJ file parser
function readObjFile(file)
  io.input(file,"r+")

  
  
  local pointOrder=1
  local triOrder=1
  
  local lineNum=1
  
  local verticePattern = '^v (%S+) (%S+) (%S+)'
  local verticePattern = '^vt (%S+) (%S+) (%S+)'
  local facePattern1 = '^f (%d+) (%d+) (%d+)'
  local facePattern2 = '^f (%d+)/%d+ (%d+)/%d+ (%d+)/%d+'
  local bufferOrder = 1
  local pointsBuffer ={}
  local pointList={}
  local triList={}
  
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
      line:gsub(facePattern2,'%2'),
      line:gsub(facePattern2,'%3')
      point11=tonumber(point11)
      point22=tonumber(point22)
      point33=tonumber(point33)
      table.insert(triList, triangle:new{
          point1=pointList[point11],
          point2=pointList[point22],
          point3=pointList[point33]})
     
    end
    
end
models[modelNumber].tris=triList




end