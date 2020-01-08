--demo update code

function spinObjectDemo(mesh)
  
  
  if mesh.rSpeedX>0 then
    mesh.rSpeedX=mesh.rSpeedX-mesh.drag
    
  elseif mesh.rSpeedX<0 then
    mesh.rSpeedX=mesh.rSpeedX+mesh.drag
  
  end
  
  if mesh.rSpeedY>0 then
    mesh.rSpeedY=mesh.rSpeedY-mesh.drag
  elseif mesh.rSpeedY<0 then
    mesh.rSpeedY=mesh.rSpeedY+mesh.drag

  end
  

  mesh.thetaX=mesh.thetaX+mesh.rSpeedX
  mesh.thetaY=mesh.thetaY+mesh.rSpeedY
  
--[[
  rotTimer=rotTimer-1
  
  if (rotTimer<=0) then
    rotTimer = timeLimit
    axisToRot = math.random(1,4)
    autoRotActive=true
  end
 
 
  if autoRotActive then
    if axisToRot==1 then
      rSpeedX=rSpeedX+accel
    elseif axisToRot==2 then
      rSpeedY=rSpeedY+accel
    elseif axisToRot==3 then
      rSpeedX=rSpeedX-accel
    elseif axisToRot==4 then
      rSpeedY=rSpeedY-accel
    end
    
  end
  ]]
  
  if love.keyboard.isDown('up') then
    --autoRotActive=false
    --rotTimer=timeLimit
    mesh.rSpeedX=mesh.rSpeedX-mesh.accel
  
  elseif love.keyboard.isDown('down') then
    --autoRotActive=false
   -- rotTimer=timeLimit
    mesh.rSpeedX=mesh.rSpeedX+mesh.accel
  end
  if love.keyboard.isDown('left') then
    --autoRotActive=false
    --rotTimer=timeLimit
    mesh.rSpeedY=mesh.rSpeedY+mesh.accel
  
  elseif love.keyboard.isDown('right') then
    --autoRotActive=false
    --rotTimer=timeLimit
    mesh.rSpeedY=mesh.rSpeedY-mesh.accel
  end
  
  --WASD controls for 3d Object
  if love.keyboard.isDown('w') then
    
    mesh.Zpos = mesh.Zpos - mesh.speed
  end
  if love.keyboard.isDown('s') then
    
    mesh.Zpos = mesh.Zpos + mesh.speed
  end
  if love.keyboard.isDown('a') then
    
    mesh.Xpos = mesh.Xpos + mesh.speed
  end
  if love.keyboard.isDown('d') then
    
    mesh.Xpos = mesh.Xpos - mesh.speed
  end
  
  if love.keyboard.isDown('q') then
    
    mesh.Ypos = mesh.Ypos - mesh.speed
  end
  if love.keyboard.isDown('e') then
    
    mesh.Ypos = mesh.Ypos + mesh.speed
  end
  
end
