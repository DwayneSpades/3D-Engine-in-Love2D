--3D draw functions

function drawTriangle(tri)
  love.graphics.polygon('fill',
    tri.point1.x,tri.point1.y,
    tri.point2.x,tri.point2.y,
    tri.point3.x,tri.point3.y)
  
  love.graphics.line(tri.point1.x,tri.point1.y,tri.point2.x,tri.point2.y)
  love.graphics.line(tri.point2.x,tri.point2.y,tri.point3.x,tri.point3.y)
  love.graphics.line(tri.point3.x,tri.point3.y,tri.point1.x,tri.point1.y)
end

function drawMesh(mesh)

  local verts = {}
  rotationMatrix = multiplyMatrices(rotationMatrixX,rotationMatrixY)
   for i,v in ipairs(mesh) do
     if i <1300 then
    local triProjected = triangle:new()
   
    
    v.point1 = multiplyVectorByMatrix(v.point1,rotationMatrix)
    v.point2 = multiplyVectorByMatrix(v.point2,rotationMatrix)
    v.point3 = multiplyVectorByMatrix(v.point3,rotationMatrix)
    --[[
    v.point1 = multiplyVectorByMatrix(v.point1,rotationMatrixX)
    v.point2 = multiplyVectorByMatrix(v.point2,rotationMatrixX)
    v.point3 = multiplyVectorByMatrix(v.point3,rotationMatrixX)
    
    v.point1 = multiplyVectorByMatrix(v.point1,rotationMatrixY)
    v.point2 = multiplyVectorByMatrix(v.point2,rotationMatrixY)
    v.point3 = multiplyVectorByMatrix(v.point3,rotationMatrixY)
    ]]
    
   --can't rotate on 3-axis because of gymbol lock
   -- v.point1 = multiplyVectorByMatrix(v.point1,rotationMatrixZ)
   -- v.point2 = multiplyVectorByMatrix(v.point2,rotationMatrixZ)
   -- v.point3 = multiplyVectorByMatrix(v.point3,rotationMatrixZ)
    
    triProjected.point1 = multiplyVectorByMatrix(v.point1,rotationMatrix)
    triProjected.point2 = multiplyVectorByMatrix(v.point2,rotationMatrix)
    triProjected.point3 = multiplyVectorByMatrix(v.point3,rotationMatrix)
    
    triProjected.point1.x = triProjected.point1.x-Xpos
    triProjected.point2.x = triProjected.point2.x-Xpos
    triProjected.point3.x = triProjected.point3.x-Xpos
    
    triProjected.point1.y = triProjected.point1.y-Ypos
    triProjected.point2.y = triProjected.point2.y-Ypos
    triProjected.point3.y = triProjected.point3.y-Ypos
    
    triProjected.point1.z = triProjected.point1.z-Zpos
    triProjected.point2.z = triProjected.point2.z-Zpos
    triProjected.point3.z = triProjected.point3.z-Zpos
    
    local depthX = (triProjected.point1.x + triProjected.point2.x + triProjected.point3.x)/3
    local depthY = (triProjected.point1.y + triProjected.point2.y + triProjected.point3.y)/3
    
    triProjected.point1 = multiplyVectorByMatrix(triProjected.point1,iprojectionMatrix)
    triProjected.point2 = multiplyVectorByMatrix(triProjected.point2,iprojectionMatrix)
    triProjected.point3 = multiplyVectorByMatrix(triProjected.point3,iprojectionMatrix)
      
    triProjected.point1.x=triProjected.point1.x+1
    triProjected.point1.y=triProjected.point1.y+1

    triProjected.point2.x=triProjected.point2.x+1
    triProjected.point2.y=triProjected.point2.y+1

    triProjected.point3.x=triProjected.point3.x+1
    triProjected.point3.y=triProjected.point3.y+1
  
  
    triProjected.point1.x=triProjected.point1.x*(0.5*screenWidth)
    triProjected.point1.y=triProjected.point1.y*(0.5*screenHeight)

    triProjected.point2.x=triProjected.point2.x*(0.5*screenWidth)
    triProjected.point2.y=triProjected.point2.y*(0.5*screenHeight)

    triProjected.point3.x=triProjected.point3.x*(0.5*screenWidth)
    triProjected.point3.y=triProjected.point3.y*(0.5*screenHeight)
    
    table.insert(verts,triProjected)
    end
  --wire frame mode
    --drawTriangle(triProjected)
end
    
  
  table.sort(verts,sortDepth)
  
  local vv={}
  
  for i,v in ipairs(verts) do
   
    table.insert(vv,{v.point1.x,v.point1.y,0,0,1,0,0,1})
    table.insert(vv,{v.point2.x,v.point2.y,0,1,1,0,0,1})
    table.insert(vv,{v.point3.x,v.point3.y,1,1,1,1,1,1})
    
  end
  
  finalMesh:setVertices(vv,1)
  love.graphics.draw(finalMesh,0,0)
end

function sortDepth(a,b)
  local depth1 = (a.point1.z + a.point2.z + a.point3.z)/3
  local depth2 = (b.point1.z + b.point2.z + b.point3.z)/3
  
  if (depth1<depth2) then
    return true
  end
  return false
end

function constructMesh(mesh)

  love.graphics.setFrontFaceWinding('cw')
  love.graphics.setMeshCullMode('back')
  
  local verts={}
  local index={}
  local num=1
  
   for i,v in ipairs(mesh) do
    table.insert(verts,{v.point1.x,v.point1.y,0,0,0,0,0,0})
    table.insert(verts,{v.point2.x,v.point2.y,0,0,0,0,0,0})
    table.insert(verts,{v.point3.x,v.point3.y,0,0,0,0,0,0})
  end
  
  finalMesh = love.graphics.newMesh(verts,'triangles')
  image=love.graphics.newImage('skin.jpg')
  finalMesh:setTexture(image)

end

function rotateShape(model)
  
end

function rotateAxis()
  
end

function updateShape()
  
end