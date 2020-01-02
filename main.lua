require 'libraries/classHandler'

--Written by Preston Adams
--steps to render 3d scene 

--1 define camera matrix

--2 calculate & apply world to veiw matrix on all 3d objects

--3 calculate and apply perspective matrix on all 3d objects divide by W for homogenous coordinates

--4 apply NDC to screen matrix on all 3d objects to translate to px coordinates

function love.load()
  
  camera = object:new
  {
    {0,0,0,0},
    {0,1,0,0},
    {0,0,-1,-1},
    {0,0,0,1},
    
  }
  
  nPoint= object:new
  {
    0,0,0,1
  }
  --a point in space
  point = object:new
  {
    x=0,
    y=0,
    z=0,
    w=1,
    
    create = function(self,x1,y1,z1)
      self.x=x1
      self.y=y1
      self.z=z1
    end
  }
  
  --a line in space
  triangle = object:new
  {
    point1=nil,
    point2=nil,
    point3=nil,
    
    create = function(self,p1,p2,p3)
      self.point1=p1
      self.point2=p2
      self.point3=p3
    end
  }
  
  mesh = object:new
  {
    tris={},
  }
  
  --a vector
  vect3D = object:new
  {
    x=0,
    y=0,
    z=0,
    w=0
  }
  
  --a matrix 
  matrix = object:new
  {
    {0,0,0,0},
    {0,0,0,0},
    {0,0,0,0},
    {0,0,0,0}
  }
  
  thetaX = 0.000
  thetaY = 0.000
  thetaZ = 0.000
  accel = 0.0002
  drag=0.0001
  rSpeed = 0

  rotationMatrixX = matrix:new
  {
      {1,0,0,0},
      {0,math.cos(thetaX),-math.sin(thetaX),0},
      {0,math.sin(thetaX),math.cos(thetaX),0},
      {0,0,0,1}
  }
  
  rotationMatrixY = matrix:new
  {
      {math.cos(thetaY),0,math.sin(thetaY),0},
      {0,1,0,0},
      {-math.sin(thetaY),0,math.cos(thetaY),0},
      {0,0,0,1}
  }
  
  rotationMatrixZ = matrix:new
  {
      {math.cos(thetaZ),-math.sin(thetaZ),0,0},
      {math.sin(thetaZ),math.cos(thetaZ),0,0},
      {0,0,1,0},
      {0,0,0,1}
  }
  
  projectionMatrix = matrix:new
  {
      {0,0,0,0},
      {0,0,0,0},
      {0,0,0,0},
      {0,0,0,0}
  }
  
  unitCube=mesh:new()
  
  cube = 
    {
      {
        {-1,-1,-1}, -- points
        {-1,-1,1},
        {1,-1,1},
        {1,-1,-1},
        {-1,1,-1},
        {-1,1,1},
        {1,1,1},
        {1,1,-1}
      },
      {
        {1,2}, -- lines
        {2,3},
        {3,4},
        {4,1},
        {5,6},
        {6,7},
        {7,8},
        {8,5},
        {1,5},
        {2,6},
        {3,7},
        {4,8}
      }
    }
  
--[[  
  unitCube.tris=
  {
    { 
      {-1,-1,1}, 
      {-1,1,1}, 
      {1,1,1},
      {-1,-1,1}, 
      {1,1,1}, 
      {1,-1,1},
 
      {1,-1,1}, 
      {1,1,1}, 
      {1,1,-1},
      {1,-1,1}, 
      {1,1,-1}, 
      {1,-1,-1},
    
      {1,-1,-1}, 
      {1,1,-1}, 
      {-1,1,-1},
      {1,-1,-1}, 
      {-1,1,-1}, 
      {-1,-1,-1},
    
      {-1,-1,-1}, 
      {-1,1,-1}, 
      {-1,1,1},
      {-1,-1,-1}, 
      {-1,1,1}, 
      {-1,-1,1},
    
      {-1,-1,1}, 
      {-1,-1,-1}, 
      {1,-1,-1},
      {-1,-1,1}, 
      {1,-1,-1}, 
      {1,-1,1},
    
      {-1,1,1}, 
      {-1,1,-1}, 
      {1,1,-1} ,
      {-1,1,1}, 
      {1,1,-1}, 
      {1,1,1}

    }
  }
]]
  
  cam = object:inherit{0,0,-2.5}
  scaler =100
  
  tmp=matrix:new()
  tmp2=matrix:new()
  
  tmp = setMatrix()
  tmp2 = setMatrix()
  
  iprojectionMatrix=projectionMatrix:new()
  --iprojectionMatrix:setProjectionMatrix()
  
  setIdentityMatrix(tmp2)
  
  tmp = multiplyMatrices(tmp,tmp2)
  
  --Projection Matrix 
      screenWidth = 600
      screenHeight = 600
      local nearPlane= 0.1
      local farPlane = 1000
      local FOV = 90
        
      local a = screenWidth/screenHeight
      local d = 1/math.tan(FOV *0.5 / 180 * 3.1415926535)
       
      iprojectionMatrix[1][1]=(a/d)
      iprojectionMatrix[2][2]=(d)
      iprojectionMatrix[3][3]=-((farPlane+nearPlane)/(farPlane-nearPlane))
      iprojectionMatrix[4][3]=-((-2*farPlane*nearPlane)/(farPlane-nearPlane))
      iprojectionMatrix[3][4]=-1
  
  printMatrice(iprojectionMatrix)
  
  
  
  vect1 = vect3D:new()
  vect2 = vect3D:new()
  setVector(vect1,-9,8,0)
  setVector(vect2,-559,191,550)
  vect1 = subtractVectors(vect2,vect1)
  vect1 = normalizeVector(vect1)
  vect1 = flipVector(vect1)
  printVector(vect1)
  --printVector(vect2)
  
  p1 = point:new()
  p2 = point:new()
  p3 = point:new()
  p4 = point:new()
  p5 = point:new()
  p6 = point:new()
  
  p7 = point:new()
  p8 = point:new()
  p9 = point:new()
  p10 = point:new()
  p11 = point:new()
  p12 = point:new()
  
  p13 = point:new()
  p14 = point:new()
  p15 = point:new()
  p16 = point:new()
  p17 = point:new()
  p18 = point:new()
  
  p19 = point:new()
  p20 = point:new()
  p21 = point:new()
  p22 = point:new()
  p23 = point:new()
  p24 = point:new()
  p25 = point:new()
  p26 = point:new()
  p27 = point:new()
  p28 = point:new()
  p29 = point:new()
  p30 = point:new()
  p31 = point:new()
  p32 = point:new()
  p33 = point:new()
  p34 = point:new()
  p35 = point:new()
  p36 = point:new()
  
  
  p1:create(-1,-1,1)
  p2:create(-1,1,1)
  p3:create(1,1,1)
  p4:create(-1,-1,1)
  p5:create(1,1,1)
  p6:create(1,-1,1)
  
  p7:create(1,-1,1)
  p8:create(1,1,1)
  p9:create(1,1,-1)
  p10:create(1,-1,1)
  p11:create(1,1,-1)
  p12:create(1,-1,-1)
  
  p13:create(1,-1,-1)
  p14:create(1,1,-1)
  p15:create(-1,1,-1)
  p16:create(1,-1,-1)
  p17:create(-1,1,-1)
  p18:create(-1,-1,-1)
  
  p19:create(-1,-1,-1)
  p20:create(-1,1,1)
  p21:create(-1,1,-1)
  p22:create(-1,-1,-1)
  p23:create(-1,-1,1)
  p24:create(-1,1,1)
  
  p25:create(-1,1,1)
  p26:create(-1,1,-1)
  p27:create(1,1,-1)
  p28:create(-1,1,1)
  p29:create(1,1,-1)
  p30:create(1,1,1)
  
  p31:create(-1,-1,1)
  p32:create(-1,-1,-1)
  p33:create(1,-1,-1)
  p34:create(-1,-1,1)
  p35:create(1,-1,-1)
  p36:create(1,-1,1)
  
  tri1 = triangle:new()
  tri2 = triangle:new()
  tri3 = triangle:new()
  tri4 = triangle:new()
  tri5 = triangle:new()
  tri6 = triangle:new()
  tri7 = triangle:new()
  tri8 = triangle:new()
  tri9 = triangle:new()
  tri10 = triangle:new()
  tri11 = triangle:new()
  tri12 = triangle:new()
  
  tri1:create(p1,p2,p3)
  tri2:create(p4,p5,p6)
  tri3:create(p7,p8,p9)
  tri4:create(p10,p11,p12)
  tri5:create(p13,p14,p15)
  tri6:create(p16,p17,p18)
  tri7:create(p19,p20,p21)
  tri8:create(p22,p23,p24)
  tri9:create(p25,p26,p27)
  tri10:create(p28,p29,p30)
  tri11:create(p31,p32,p33)
  tri12:create(p34,p35,p36)
  
  
  triTranslated = triangle:new()
  
  pp = point:new()
  pp:create(0,0,0)
  
  triTranslated:create(p1,p2,p3)

  
  model5 = {tri1,tri2,tri3,tri4,tri5,tri6,tri7,tri8,tri9,tri10,tri11,tri12}
  
  origin = {tri1,tri2,tri3,tri4,tri5,tri6,tri7,tri8,tri9,tri10,tri11,tri12}
  
  
  timeLimit =200
  rotTimer = timeLimit
  rotTimer2 = timeLimit
  
  autoRotActive=true
  axisToRot =1
  
  love.window.setTitle('3D Cube Demo')
  --tri1={point1=p1,point2=p2,point3=p3}
 
end

function drawMesh(mesh)
  for i,v in ipairs(mesh[1]) do
    drawLine(mesh[1][i],mesh[1][i])
  end
 
end

function drawLine(p1,p2)
  x0, y0 = project(p1) -- get the 2d location of the 3d points...
  x1, y1 = project(p2)
  love.graphics.line(x0, y0, x1,y1) -- and draw a line between them
end

function project(p)
  x = (p[1]-cam[1])*scaler/(p[3]-cam[3]) + (800)/2
 -- calculate x and center it
  y = -(p[2]-cam[2])*scaler/(p[3]-cam[3]) + (600)/2 
 -- calculate y and center it
 return x, y 
end

function projectPoint(mesh,i,v)

end

function NDCToScreen()
  
end

function setIdentityMatrix()

  temp = 
  {
    {1,0,0,0},
    {0,1,0,0},
    {0,0,1,0},
    {0,0,0,1},
  }

  return temp
end
    
function setZeroMatrix()
  temp = 
  {
    {0,0,0,0},
    {0,0,0,0},
    {0,0,0,0},
    {0,0,0,0},
  }

  return temp
end

function setMatrix()
  temp = 
  {
    {2,2,2,0},
    {0,0,0,0},
    {0,0,0,0},
    {0,3,3,3},
  }

  return temp
end

function printPoint(pon)
  
  print('-----------')
  print('Point:')

  print(pon.x)
  print(pon.y)
  print(pon.z)
  print(pon.w)
end

function printVector(vec)
  
  print('-----------')
  print('Vertex:')

  print(vec.x)
  print(vec.y)
  print(vec.z)
  print(vec.w)
end

function setVector(vec,x,y,z)
  vec.x=x
  vec.y=y
  vec.z=z
end

function printMatrice(mat)
  
  print('-----------')
  print('matrix:')
  
  for i=1 , 4 do
  
    print(mat[i][1]..' '..mat[i][2]..' '..mat[i][3]..' '..mat[i][4])
    
  end
  
end

function multiplyMatrices(mat1,mat2)
  
  res = matrix:new()
  res = setZeroMatrix()

  print('multiplying:')
  
  --row 1
  res[1][1]= mat1[1][1] * mat2[1][1] + mat1[2][1] * mat2[1][2] + mat1[3][1] * mat2[1][3] + mat1[4][1] * mat2[1][4]
  res[2][1]= mat1[1][1] * mat2[2][1] + mat1[2][1] * mat2[2][2] + mat1[3][1] * mat2[2][3] + mat1[4][1] * mat2[2][4]
  res[3][1]= mat1[1][1] * mat2[3][1] + mat1[2][1] * mat2[3][2] + mat1[3][1] * mat2[3][3] + mat1[4][1] * mat2[3][4]
  res[4][1]= mat1[1][1] * mat2[4][1] + mat1[2][1] * mat2[4][2] + mat1[3][1] * mat2[4][3] + mat1[4][1] * mat2[4][4]
  
    --row 2
  res[1][2]= mat1[1][2] * mat2[1][1] + mat1[2][2] * mat2[1][2] + mat1[3][2] * mat2[1][3] + mat1[4][2] * mat2[1][4]
  res[2][2]= mat1[1][2] * mat2[2][1] + mat1[2][2] * mat2[2][2] + mat1[3][2] * mat2[2][3] + mat1[4][2] * mat2[2][4]
  res[3][2]= mat1[1][2] * mat2[3][1] + mat1[2][2] * mat2[3][2] + mat1[3][2] * mat2[3][3] + mat1[4][2] * mat2[3][4]
  res[4][2]= mat1[1][2] * mat2[4][1] + mat1[2][2] * mat2[4][2] + mat1[3][2] * mat2[4][3] + mat1[4][2] * mat2[4][4]
  
    --row 3
  res[1][3]= mat1[1][3] * mat2[1][1] + mat1[2][3] * mat2[1][2] + mat1[3][3] * mat2[1][3] + mat1[4][3] * mat2[1][4]
  res[2][3]= mat1[1][3] * mat2[2][1] + mat1[2][3] * mat2[2][2] + mat1[3][3] * mat2[2][3] + mat1[4][3] * mat2[2][4]
  res[3][3]= mat1[1][3] * mat2[3][1] + mat1[2][3] * mat2[3][2] + mat1[3][3] * mat2[3][3] + mat1[4][3] * mat2[3][4]
  res[4][3]= mat1[1][3] * mat2[4][1] + mat1[2][3] * mat2[4][2] + mat1[3][3] * mat2[4][3] + mat1[4][3] * mat2[4][4]
  
    --row 4
  res[1][4]= mat1[1][4] * mat2[1][1] + mat1[2][4] * mat2[1][2] + mat1[3][4] * mat2[1][3] + mat1[4][4] * mat2[1][4]
  res[2][4]= mat1[1][4] * mat2[2][1] + mat1[2][4] * mat2[2][2] + mat1[3][4] * mat2[2][3] + mat1[4][4] * mat2[2][4]
  res[3][4]= mat1[1][4] * mat2[3][1] + mat1[2][4] * mat2[3][2] + mat1[3][4] * mat2[3][3] + mat1[4][4] * mat2[3][4]
  res[4][4]= mat1[1][4] * mat2[4][1] + mat1[2][4] * mat2[4][2] + mat1[3][4] * mat2[4][3] + mat1[4][4] * mat2[4][4]
  
  
   --printMatrice(res)
  
  return res
end
 
 function multiplyVectorByMatrix(vect,mat)
  res = point:new()
  
  res.x = vect.x * mat[1][1] + vect.y * mat[2][1] + vect.z * mat[3][1] + mat[4][1] 
  res.y = vect.x * mat[1][2] + vect.y * mat[2][2] + vect.z * mat[3][2] + mat[4][2]
  res.z = vect.x * mat[1][3] + vect.y * mat[2][3] + vect.z * mat[3][3] + mat[4][3]
  res.w = vect.x * mat[1][4] + vect.y * mat[2][4] + vect.z * mat[3][4] + mat[4][4]
  
  if res.w~=0 then
    res = divideVector(res,res.w)
  end
  
  --printVector(res)
  
  return res
   
 end 

function addVectors(vec1,vec2)
  res = vect3D:new()
  
  res.x = vec1.x + vec2.x
  res.y = vec1.y + vec2.y
  res.z = vec1.z + vec2.z
  --res.w = vec1.w + vec2.w
  
  return res
end


function subtractVectors(vec1,vec2)
  res = vect3D:new()
  
  res.x = vec1.x - vec2.x
  res.y = vec1.y - vec2.y
  res.z = vec1.z - vec2.z
  --res.w = vec1.w - vec2.w
  
  return res
end

function multiplyVectors(vec1,vec2)
  res = vect3D:new()
  
  res.x = vec1.x * vec2.x
  res.y = vec1.y * vec2.y
  res.z = vec1.z * vec2.z
  --res.w = vec1.w * vec2.w
  
  return res
end


function divideVectors(vec1,vec2)
  res = vect3D:new()
  
  res.x = vec1.x / vec2.x
  res.y = vec1.y / vec2.y
  res.z = vec1.z / vec2.z
  --res.w = vec1.w / vec2.w
  
  return res
end

function addToVector(vec1,num)
  res = vect3D:new()
  
  res.x = vec1.x + num
  res.y = vec1.y + num
  res.z = vec1.z + num
  --res.w = vec1.w / num
  
  return res
end


function divideVector(vec1,num)
  res = vect3D:new()
  
  res.x = vec1.x / num
  res.y = vec1.y / num
  res.z = vec1.z / num
  --res.w = vec1.w / num
  
  return res
end

function flipVector(vec)
    
    res = vect3D:new()
    
    res.x = vec.x*-1
    res.y = vec.y*-1
    res.z = vec.z*-1
    
    return res
end

function normLengthVector(vec)
  res = vect3D:new()
  
  res.x = vec.x * vec.x
  res.y = vec.y * vec.y
  res.z = vec.z * vec.z
  --res.w = vec.w * vec.w
  
  result = math.sqrt(res.x + res.y + res.z )
  
  return result
end

function normalizeVector(vec)
  
  res = vect3D:new()
  length = normLengthVector(vec)
  
  res.x = vec.x/length
  res.y = vec.y/length
  res.z = vec.z/length
  
  return res
end

function drawMseh(mesh)
  for i,v in ipairs(mesh.tris) do
    
    for j,k in ipairs(v) do
      multiplyVectorByMatrix(v[i],projectionMatrix)
    end
  end
end


function drawTriangle(tri)
 
  love.graphics.line(tri.point1.x,tri.point1.y,tri.point2.x,tri.point2.y)
  love.graphics.line(tri.point2.x,tri.point2.y,tri.point3.x,tri.point3.y)
  love.graphics.line(tri.point3.x,tri.point3.y,tri.point1.x,tri.point1.y)
end

function rotateShape(model)
  
end

function rotateAxis()
end

function updateShape()
  
end


function love.update()
  if thetaX>0 then
    thetaX=thetaX-drag
  end
  
  if thetaX<0 then
    thetaX=thetaX+drag
  end
  
  if thetaY>0 then
    thetaY=thetaY-drag
  end
  
  if thetaY<0 then
    thetaY=thetaY+drag
  end
  
  
  
 
  rotTimer=rotTimer-1
  
  if (rotTimer<=0) then
    rotTimer = timeLimit
    axisToRot = math.random(1,4)
    autoRotActive=true
  end
  
  if autoRotActive then
    if axisToRot==1 then
      thetaX=thetaX+accel
    elseif axisToRot==2 then
      thetaY=thetaY+accel
    elseif axisToRot==3 then
      thetaX=thetaX-accel
    elseif axisToRot==4 then
      thetaY=thetaY-accel
    end
    
  end
  
  if love.keyboard.isDown('up') then
    autoRotActive=false
    thetaX=thetaX-accel
  end
  if love.keyboard.isDown('down') then
    autoRotActive=false
    thetaX=thetaX+accel
  end
  if love.keyboard.isDown('left') then
    autoRotActive=false
    thetaY=thetaY+accel
  end
  if love.keyboard.isDown('right') then
    autoRotActive=false
    thetaY=thetaY-accel
  end
  
  rotationMatrixX = matrix:new
  {
      {1,0,0,0},
      {0,math.cos(thetaX),-math.sin(thetaX),0},
      {0,math.sin(thetaX),math.cos(thetaX),0},
      {0,0,0,1}
  }
  
  rotationMatrixY = matrix:new
  {
      {math.cos(thetaY),0,math.sin(thetaY),0},
      {0,1,0,0},
      {-math.sin(thetaY),0,math.cos(thetaY),0},
      {0,0,0,1}
  }
  
  rotationMatrixZ = matrix:new
  {
      {math.cos(thetaZ),-math.sin(thetaZ),0,0},
      {math.sin(thetaZ),math.cos(thetaZ),0,0},
      {0,0,1,0},
      {0,0,0,1}
  }
  
  
end

function love.keypressed(key)
    if key=='escape' then
      love.event.push('quit')
    end
    
end


function love.draw()
  love.graphics.print("Press and hold the arrow keys to rotate manually.",0,0,0,2,2)
  love.graphics.print("auto rotation turns on if no valid keys are pressed",0,32,0,1,1)
  love.graphics.print("press escape to close program.",0,560,0,2,2)
  love.graphics.print("Written by Preston Adams",380,580,0,1,1)
  temp1=point:new()
  temp2=point:new()
  temp3=point:new()
  
 for i,v in ipairs(model5) do
   triProjected = triangle:new()
   triProjected:create(temp1,temp2,temp3)
    
    v.point1 = multiplyVectorByMatrix(v.point1,rotationMatrixX)
    v.point2 = multiplyVectorByMatrix(v.point2,rotationMatrixX)
    v.point3 = multiplyVectorByMatrix(v.point3,rotationMatrixX)
    
    v.point1 = multiplyVectorByMatrix(v.point1,rotationMatrixY)
    v.point2 = multiplyVectorByMatrix(v.point2,rotationMatrixY)
    v.point3 = multiplyVectorByMatrix(v.point3,rotationMatrixY)
    
   -- v.point1 = multiplyVectorByMatrix(v.point1,rotationMatrixZ)
   -- v.point2 = multiplyVectorByMatrix(v.point2,rotationMatrixZ)
   -- v.point3 = multiplyVectorByMatrix(v.point3,rotationMatrixZ)
    
    triProjected.point1 = multiplyVectorByMatrix(v.point1,rotationMatrixX)
    triProjected.point2 = multiplyVectorByMatrix(v.point2,rotationMatrixX)
    triProjected.point3 = multiplyVectorByMatrix(v.point3,rotationMatrixX)
    
    triProjected.point1.y = triProjected.point1.y
    triProjected.point2.y = triProjected.point2.y
    triProjected.point3.y = triProjected.point3.y
    
    triProjected.point1.x = triProjected.point1.x
    triProjected.point2.x = triProjected.point2.x
    triProjected.point3.x = triProjected.point3.x
    
    triProjected.point1.y = triProjected.point1.y
    triProjected.point2.y = triProjected.point2.y
    triProjected.point3.y = triProjected.point3.y
    
    triProjected.point1.z = triProjected.point1.z-2.5
    triProjected.point2.z = triProjected.point2.z-2.5
    triProjected.point3.z = triProjected.point3.z-2.5
   
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
  
  --drawTriangle(tri1)
  --drawMesh(cube)
end


