
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
    Zpos = -100,
  
    accel = 0.0008,
    drag = 0.00025,
    
  }
  
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
  