--3D draw functions

function drawTriangle(tri)
  love.graphics.polygon('fill',
    tri.point1.x,tri.point1.y,
    tri.point2.x,tri.point2.y,
    tri.point3.x,tri.point3.y)
  --[[
  love.graphics.line(tri.point1.x,tri.point1.y,tri.point2.x,tri.point2.y)
  love.graphics.line(tri.point2.x,tri.point2.y,tri.point3.x,tri.point3.y)
  love.graphics.line(tri.point3.x,tri.point3.y,tri.point1.x,tri.point1.y)
  ]]
end

function drawMesh(mesh)

  local verts = {}
  local vv={}
  local worldMatrix = multiplyMatrices(rotationMatrixY,rotationMatrixX)
  local translationMatrix = matrix:new
  {
    {1,0,0,Xpos},
    {0,1,0,Ypos},
    {0,0,1,Zpos},
    {0,0,0,1}
  }

  --point:new{x=-Xpos,y=-Ypos,z=-Zpos}
  
   worldMatrix = multiplyMatrices(worldMatrix,translationMatrix)
   --worldMatrix = multiplyMatrices(worldMatrix,iprojectionMatrix)
   for i,v in ipairs(mesh) do
    
    local triProjected = triangle:new{
  
    point1 = multiplyVectorByMatrix(v.point1,worldMatrix),--v.point1
    point2 = multiplyVectorByMatrix(v.point2,worldMatrix),--v.point2
    point3 = multiplyVectorByMatrix(v.point3,worldMatrix)--v.point3
  }
 
    triProjected.point1 = multiplyVectorByMatrixP(triProjected.point1,iprojectionMatrix)
    triProjected.point2 = multiplyVectorByMatrixP(triProjected.point2,iprojectionMatrix)
    triProjected.point3 = multiplyVectorByMatrixP(triProjected.point3,iprojectionMatrix)
     
    triProjected.point1 = addVectors(triProjected.point1,normMatrix)
    triProjected.point2 = addVectors(triProjected.point2,normMatrix)
    triProjected.point3 = addVectors(triProjected.point3,normMatrix)
    
    triProjected.point1 = multiplyVectors(triProjected.point1,scaleMatrix)
    triProjected.point2 = multiplyVectors(triProjected.point2,scaleMatrix)
    triProjected.point3 = multiplyVectors(triProjected.point3,scaleMatrix)
    
    table.insert(verts,triProjected)
    
  --wire frame mode
  --drawTriangle(triProjected)
end

  table.sort(verts,sortDepth)

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
  
  return(depth1<depth2) 
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