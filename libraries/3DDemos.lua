--demo update code

function spinObjectDemo()
  
  
  if control.rSpeedX>0 then
    control.rSpeedX=control.rSpeedX-control.drag
    
  elseif control.rSpeedX<0 then
    control.rSpeedX=control.rSpeedX+control.drag
  
  end
  
  if control.rSpeedY>0 then
    control.rSpeedY=control.rSpeedY-control.drag
  elseif mesh.rSpeedY<0 then
    control.rSpeedY=control.rSpeedY+control.drag

  end
  

  control.thetaX=control.thetaX+control.rSpeedX
  control.thetaY=control.thetaY+control.rSpeedY
  
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
    control.rSpeedX=control.rSpeedX-control.accel
  
  elseif love.keyboard.isDown('down') then
    --autoRotActive=false
   -- rotTimer=timeLimit
    control.rSpeedX=control.rSpeedX+control.accel
  end
  if love.keyboard.isDown('left') then
    --autoRotActive=false
    --rotTimer=timeLimit
    control.rSpeedY=control.rSpeedY+control.accel
  
  elseif love.keyboard.isDown('right') then
    --autoRotActive=false
    --rotTimer=timeLimit
    control.rSpeedY=control.rSpeedY-control.accel
  end
  
  --WASD controls for 3d Object
  if love.keyboard.isDown('w') then
    
    control.Zpos = control.Zpos - control.speed
  end
  if love.keyboard.isDown('s') then
    
    control.Zpos = control.Zpos + control.speed
  end
  if love.keyboard.isDown('a') then
    
    control.Xpos = control.Xpos + control.speed
  end
  if love.keyboard.isDown('d') then
    
    control.Xpos = control.Xpos - control.speed
  end
  
  if love.keyboard.isDown('q') then
    
    control.Ypos = control.Ypos - control.speed
  end
  if love.keyboard.isDown('e') then
    
    control.Ypos = control.Ypos + control.speed
  end
  
end
