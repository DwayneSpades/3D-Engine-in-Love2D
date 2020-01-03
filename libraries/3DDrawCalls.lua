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
   for i,v in ipairs(mesh) do
   triProjected = triangle:new()
   
    
    v.point1 = multiplyVectorByMatrix(v.point1,rotationMatrixX)
    v.point2 = multiplyVectorByMatrix(v.point2,rotationMatrixX)
    v.point3 = multiplyVectorByMatrix(v.point3,rotationMatrixX)
    
    v.point1 = multiplyVectorByMatrix(v.point1,rotationMatrixY)
    v.point2 = multiplyVectorByMatrix(v.point2,rotationMatrixY)
    v.point3 = multiplyVectorByMatrix(v.point3,rotationMatrixY)
    
   --can't rotate on 3-axis because of gymbol lock
   -- v.point1 = multiplyVectorByMatrix(v.point1,rotationMatrixZ)
   -- v.point2 = multiplyVectorByMatrix(v.point2,rotationMatrixZ)
   -- v.point3 = multiplyVectorByMatrix(v.point3,rotationMatrixZ)
    
    triProjected.point1 = multiplyVectorByMatrix(v.point1,rotationMatrixX)
    triProjected.point2 = multiplyVectorByMatrix(v.point2,rotationMatrixX)
    triProjected.point3 = multiplyVectorByMatrix(v.point3,rotationMatrixX)
   
    triProjected.point1.x = triProjected.point1.x-Xpos
    triProjected.point2.x = triProjected.point2.x-Xpos
    triProjected.point3.x = triProjected.point3.x-Xpos
    
    triProjected.point1.y = triProjected.point1.y-Ypos
    triProjected.point2.y = triProjected.point2.y-Ypos
    triProjected.point3.y = triProjected.point3.y-Ypos
    
    triProjected.point1.z = triProjected.point1.z-Zpos
    triProjected.point2.z = triProjected.point2.z-Zpos
    triProjected.point3.z = triProjected.point3.z-Zpos
   
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


    drawTriangle(triProjected)
  end
end

function rotateShape(model)
  
end

function rotateAxis()
  
end

function updateShape()
  
end