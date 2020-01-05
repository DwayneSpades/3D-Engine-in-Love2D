--demo update code

function spinObjectDemo()
  
  
  if rSpeedX>0 then
    rSpeedX=rSpeedX-drag
    
  elseif rSpeedX<0 then
    rSpeedX=rSpeedX+drag
  
  end
  
  if rSpeedY>0 then
    rSpeedY=rSpeedY-drag
  elseif rSpeedY<0 then
    rSpeedY=rSpeedY+drag

  end
  

  thetaX=thetaX+rSpeedX
  thetaY=thetaY+rSpeedY
  

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
  
  
  if love.keyboard.isDown('up') then
    autoRotActive=false
    rotTimer=timeLimit
    rSpeedX=rSpeedX-accel
  
  elseif love.keyboard.isDown('down') then
    autoRotActive=false
    rotTimer=timeLimit
    rSpeedX=rSpeedX+accel
  end
  if love.keyboard.isDown('left') then
    autoRotActive=false
    rotTimer=timeLimit
    rSpeedY=rSpeedY+accel
  
  elseif love.keyboard.isDown('right') then
    autoRotActive=false
    rotTimer=timeLimit
    rSpeedY=rSpeedY-accel
  end
  
  --WASD controls for 3d Object
  if love.keyboard.isDown('w') then
    
    Zpos = Zpos - speed
  end
  if love.keyboard.isDown('s') then
    
    Zpos = Zpos + speed
  end
  if love.keyboard.isDown('a') then
    
    Xpos = Xpos + speed
  end
  if love.keyboard.isDown('d') then
    
    Xpos = Xpos - speed
  end
  
  if love.keyboard.isDown('q') then
    
    Ypos = Ypos - speed
  end
  if love.keyboard.isDown('e') then
    
    Ypos = Ypos + speed
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
  
  

end
