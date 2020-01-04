--.OBJ file parser
function readObjFile(file)
  inn = assert(io.input(file,"r+"))
  out = assert(io.output("importedModels/model-"..modelNumber..".lua","w"))
  modelNumber=modelNumber+1
  
  local pointOrder=1
  local triOrder=1
  
  local lineNum=1
  
  local verticePattern = '^v (%S+) (%S+) (%S+)'
  local facePattern1 = '^f (%d+) (%d+) (%d+)'
  local facePattern2 = '^f (%d+)/%d+ (%d+)/%d+ (%d+)/%d+'
  
  out:write("function makeObject()\n\n")
  
  for line in io.lines(file) do

    --print(line)
    if line:find(verticePattern) then
      line = line:gsub(verticePattern,'p'..pointOrder..' = point:new{ x=%1, y=%2, z=%3}\n')
      out:write(line)
      --print(line)
      pointOrder=pointOrder+1
    end
    
    if line:find(facePattern1) then
      line = line:gsub(facePattern1,'f'..triOrder..' = triangle:new{ point1=p%1, point2=p%2, point3=p%3}\n')
      out:write(line)
      --print(line)
      triOrder=triOrder+1
    end
    
    if line:find(facePattern2) then
      line = line:gsub(facePattern2,'f'..triOrder..' = triangle:new{ point1=p%1, point2=p%2, point3=p%3}\n')
      out:write(line)
      --print(line)
      triOrder=triOrder+1
    end
    
    if(string.find(line,'v'))then
      num=io.read("*number")
      --print('found vertex')
    end
  
    if(string.find(line,'f'))then
      --print ('found face')
    end

    lineNum = lineNum+1
end
out:write('model={')
  
  for i=1 , triOrder do
    if(i==triOrder-1)then
      out:write('f'..i..'}')
      break
    end
    
    out:write('f'..i..',')
    if(i%20==0)then
      out:write('\n')
    end
    
  end
  
  out:write("\n\nend")

out:flush()
out:close()


end