--demo update code

function spinObjectDemo()
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
  
  --WASD controls for 3d Object
  if love.keyboard.isDown('w') then
    
    Zpos = Zpos + speed
  end
  if love.keyboard.isDown('s') then
    
    Zpos = Zpos - speed
  end
  if love.keyboard.isDown('a') then
    
    Xpos = Xpos + speed
  end
  if love.keyboard.isDown('d') then
    
    Xpos = Xpos - speed
  end
  
  if love.keyboard.isDown('q') then
    
    Ypos = Ypos + speed
  end
  if love.keyboard.isDown('e') then
    
    Ypos = Ypos - speed
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
