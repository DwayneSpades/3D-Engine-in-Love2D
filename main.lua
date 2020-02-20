require 'libraries/classHandler'
require 'libraries/3DMath'
require 'libraries/3DDemos'
require 'libraries/3DDrawCalls'
require 'libraries/objParser'
require 'libraries/3DClasses'

--Written by Preston Adams
--steps to render 3d scene 

--1 define camera matrix

--2 calculate & apply world to veiw matrix on all 3d objects

--3 calculate and apply perspective matrix on all 3d objects divide by W for homogenous coordinates

--4 apply NDC to screen matrix on all 3d objects to translate to px coordinates

function love.load()
  

  local imports={}
  models = {}
  
  modelNumber=0
  
  for i=1,1 do
    readObjFile('assets/land.obj')
  end
 
  for i,v in ipairs(models) do
    constructMesh(v)
  end
  
  control = models[1]
  
  spacing=0
  downing=0
  backing=0
  
  for i,v in ipairs(models) do
    v.Xpos = (spacing*20)-1
    v.Ypos = (downing*5)-1
    v.Zpos = (backing*-8)-10
    --v.thetaX = 40
    --v.thetaY = 90
    downing=downing+1
    backing=backing+1
    if (i%4==0)then
      spacing=spacing+1
      downing=0
    end
    
  end
  
  mapX=0
  mapY=0
  
  scaleScreenX = 0.5*screenWidth
  scaleScreenY = 0.5*screenHeight
  scaleMatrix = point:new{x=scaleScreenX,y=scaleScreenY,z=1}
  normMatrix = point:new{x=1,y=1,z=0}
 
  love.window.setTitle('3D Cube Demo')
  love.graphics.setFrontFaceWinding('cw')
  love.graphics.setMeshCullMode('back')
  city=love.graphics.newImage("space.jpg")
  
  --tri1={point1=p1,point2=p2,point3=p3}
 
end


function love.update()
  spinObjectDemo()
end

function love.keypressed(key)
    if key=='escape' then
      love.event.push('quit')
    end
end

function zBuffer(a,b)
  return a.Zpos < b.Zpos 
end

function love.draw()
  
  --[[
  love.graphics.setColor(0.4,1,1,1)
  
  if (mapX<-200) then
      mapX=0
      mapY=0
  end
  
  mapX=mapX-0.03
  mapY=mapY+0.03
  love.graphics.draw(city,mapX,mapY,0,0.2,0.2)
  ]]
  love.graphics.setColor(1,1,1,1)
  love.graphics.draw(city,mapX,mapY,0,2,2)
  
  table.sort(models,zBuffer)
  
  love.graphics.setColor(1,1,1)
  local spinY=0.05
  
  for i,v in ipairs(models) do
    drawMesh(v)
    
   --[[
    if v.Zpos>-1 then
      v.Zpos=math.random(-50,-20)
      v.Xpos=math.random(-10,10)
      v.Ypos=math.random(-20,0)
    end
    ]]
   -- v.Zpos=v.Zpos+0.05
    --v.Ypos=v.Ypos-0.03
    --v.Xpos=v.Xpos+0.06
    --v.rSpeedX=0.005
    
    --v.thetaZ=v.thetaZ+spinY
    --v.thetaY=v.thetaY+spinY
  
  end

  
  love.graphics.print('FPS:'..love.timer.getFPS(),0,580)
  love.graphics.print("Press and hold the arrow keys to rotate manually.",0,0,0,2,2)
  love.graphics.print("wasd to move the object around horizontally.\n Q and E key to move up and down",0,32,0,2,2)
  --love.graphics.print("auto rotation turns on if no valid keys are pressed",0,32,0,1,1)
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


