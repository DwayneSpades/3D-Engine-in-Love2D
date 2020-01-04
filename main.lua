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
  
  cam = object:inherit{0,0,-2.5}
  scaler =100
  
  iprojectionMatrix=projectionMatrix:new()
  
  --Projection Matrix 
      screenWidth = 600
      screenHeight = 600
      
      --setting depth Buffer
      depthBuffer={}
      for i=1,(screenWidth*screenHeight) do
        table.insert(depthBuffer,0)
      end
      
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
  
  local models={}
  modelNumber=1
  readObjFile('assets/deer.obj')
  
  recursiveEnumerate('importedModels',models)
  requireFiles(models)
  
  makeObject()
  
  speed = 5.05
  Zpos = 2.5
  Ypos = 0
  Xpos = 0
  
  constructMesh(model)
  
  timeLimit =200
  rotTimer = timeLimit
  rotTimer2 = timeLimit
  
  autoRotActive=true
  axisToRot =1
  
  love.window.setTitle('3D Cube Demo')
  --tri1={point1=p1,point2=p2,point3=p3}
 
end

function drawObject(Mesh)
  for i,v in ipairs(mesh[2]) do
    
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

function love.update()
  spinObjectDemo()
end

function love.keypressed(key)
    if key=='escape' then
      love.event.push('quit')
    end
end

function love.draw()
  drawMesh(model)
  
  love.graphics.print('FPS:'..love.timer.getFPS(),0,400)
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


