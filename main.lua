require 'libraries/classHandler'
require 'libraries/3DMath'
require 'libraries/3DDemos'
require 'libraries/3DDrawCalls'
require 'libraries/objParser'


--Written by Preston Adams
--steps to render 3d scene 

--1 define camera matrix

--2 calculate & apply world to veiw matrix on all 3d objects

--3 calculate and apply perspective matrix on all 3d objects divide by W for homogenous coordinates

--4 apply NDC to screen matrix on all 3d objects to translate to px coordinates

function love.load()
  
  --a point in space
  point = object:new
  {
    x=0,
    y=0,
    z=0,
    w=1,
    uv=nil,
    
    create = function(self,x1,y1,z1)
      self.x=x1
      self.y=y1
      self.z=z1
    end
  }
  
  uvCoordinate= object:new
  {
    u=0,
    v=0
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
  
  
  
  --a vector
  vect3D = object:new
  {
    x=0,
    y=0,
    z=0,
    w=0,
    uv=nil
  }
  
  --a matrix 
  matrix = object:new
  {
    {0,0,0,0},
    {0,0,0,0},
    {0,0,0,0},
    {0,0,0,0}
  }
  
  
  projectionMatrix = matrix:new
  {
      {0,0,0,0},
      {0,0,0,0},
      {0,0,0,0},
      {0,0,0,0}
  }
  
  mesh = object:new
  {
    transform={},
    points={},
    tris={},
    uvCoords={},
    uvMat={},
    geomtry = 0,
    
    rSpeedX = 0,
    rSpeedY = 0,
  
    thetaX = 113,
    thetaY = 0,
    thetaZ = 0,

    speed = 0.5,
  
    Xpos = 0,
    Ypos = 0,
    Zpos = 0,
  
    accel = 0.0008,
    drag = 0.00025,
    
  }
--hello
  cam = object:inherit{0,0,-2.5}
  scaler =100
  
  iprojectionMatrix=projectionMatrix:new()
  
  --Projection Matrix 
      screenWidth = love.graphics.getWidth()
      screenHeight = love.graphics.getHeight()

      local nearPlane= 0.3
      local farPlane = 100
      local FOV = 90 --90 for square screen --60 for widescreen
        
      local a = screenWidth/screenHeight
      local d = 1/math.tan(FOV *0.5 / 180 * 3.1415926535)
       
      iprojectionMatrix[1][1]=(a/d)
      iprojectionMatrix[2][2]=(d)
      iprojectionMatrix[3][3]=-((farPlane+nearPlane)/(farPlane-nearPlane))
      iprojectionMatrix[4][3]=-((-2*farPlane*nearPlane)/(farPlane-nearPlane))
      iprojectionMatrix[3][4]=-1
  
  local imports={}
  models = {}
  
  modelNumber=0
  
  readObjFile('assets/Gull.obj')
    
    
  for i,v in ipairs(models) do
    constructMesh(v)
  end
  
  spacing=0
  downing=0
  --[[
  for i,v in ipairs(models) do
    v.Xpos = (spacing*85)-15
    v.Ypos = (downing*8)-15
    downing=downing+1
    if (i%20==0)then
      spacing=spacing+1
      downing=0
    end
    
  end
  ]]
  
  
  timeLimit =10000
  rotTimer = timeLimit
  rotTimer2 = timeLimit
  
  autoRotActive=true
  axisToRot =1
   
  scaleScreenX = 0.5*screenWidth
  scaleScreenY = 0.5*screenHeight
  scaleMatrix = point:new{x=scaleScreenX,y=scaleScreenY,z=1}
  normMatrix = point:new{x=1,y=1,z=0}
 
  love.window.setTitle('3D Cube Demo')
  love.graphics.setFrontFaceWinding('cw')
  love.graphics.setMeshCullMode('back')
  
  
  --tri1={point1=p1,point2=p2,point3=p3}
 
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

function love.update()
  spinObjectDemo(models[1])
end

function love.keypressed(key)
    if key=='escape' then
      love.event.push('quit')
    end
end

function love.draw()
  
  for i,v in ipairs(models) do
    drawMesh(v)
  end
  
  love.graphics.print('FPS:'..love.timer.getFPS(),0,580)
  love.graphics.print("Press and hold the arrow keys to rotate manually.",0,0,0,2,2)
  love.graphics.print("auto rotation turns on if no valid keys are pressed",0,32,0,1,1)
  love.graphics.print("press escape to close program.",0,560,0,2,2)
  love.graphics.print("Written by Preston Adams",380,580,0,1,1)
  
end

function requireFiles(files)

    for _, filed in ipairs(files) do

        local filed = filed:sub(1, -5)

        require(filed)

    end

end



function recursiveEnumerate(folder, file_list)

    local items = love.filesystem.getDirectoryItems(folder)

    for _, item in ipairs(items) do

        local file = folder .. '/' .. item

        if love.filesystem.getInfo(file) then

            table.insert(file_list, file)

        elseif love.filesystem.isDirectory(file) then

            recursiveEnumerate(file, file_list)

        end

    end

end


