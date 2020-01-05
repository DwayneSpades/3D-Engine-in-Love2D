--3d math funtions
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
  
local  res = matrix:new()

  --print('multiplying:')
  
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
 local res = point:new{x=0,y=0,z=0,w=1}
  
  res.x = vect.x * mat[1][1] + vect.y * mat[1][2] + vect.z * mat[1][3] + vect.w * mat[1][4] 
  res.y = vect.x * mat[2][1] + vect.y * mat[2][2] + vect.z * mat[2][3] + vect.w * mat[2][4]
  res.z = vect.x * mat[3][1] + vect.y * mat[3][2] + vect.z * mat[3][3] + vect.w * mat[3][4]
  res.w = vect.x * mat[4][1] + vect.y * mat[4][2] + vect.z * mat[4][3] + vect.w * mat[4][4]

  return res
   
 end 

function multiplyVectorByMatrixP(vect,mat)
 local res = point:new{x=0,y=0,z=0,w=1}
  
  res.x = vect.x * mat[1][1] + vect.y * mat[1][2] + vect.z * mat[1][3] + mat[1][4] 
  res.y = vect.x * mat[2][1] + vect.y * mat[2][2] + vect.z * mat[2][3] + mat[2][4]
  res.z = vect.x * mat[3][1] + vect.y * mat[3][2] + vect.z * mat[3][3] + mat[3][4]
  res.w = vect.x * mat[4][1] + vect.y * mat[4][2] + vect.z * mat[4][3] + mat[4][4]

  if(w~=0)then
    res = divideVector(res,res.w)
  end
  
  return res
   
 end 

function addVectors(vec1,vec2)
 local res = vect3D:new()
  
  res.x = vec1.x + vec2.x
  res.y = vec1.y + vec2.y
  res.z = vec1.z + vec2.z
  --res.w = vec1.w + vec2.w
  
  return res
end


function subtractVectors(vec1,vec2)
 local res = vect3D:new()
  
  res.x = vec1.x - vec2.x
  res.y = vec1.y - vec2.y
  res.z = vec1.z - vec2.z
  --res.w = vec1.w - vec2.w
  
  return res
end

function multiplyVectors(vec1,vec2)
 local res = vect3D:new()
  
  res.x = vec1.x * vec2.x
  res.y = vec1.y * vec2.y
  res.z = vec1.z * vec2.z
  --res.w = vec1.w * vec2.w
  
  return res
end


function divideVectors(vec1,vec2)
local  res = vect3D:new()
  
  res.x = vec1.x / vec2.x
  res.y = vec1.y / vec2.y
  res.z = vec1.z / vec2.z
  --res.w = vec1.w / vec2.w
  
  return res
end

function addToVector(vec1,num)
  local res = vect3D:new()
  
  res.x = vec1.x + num
  res.y = vec1.y + num
  res.z = vec1.z + num
  --res.w = vec1.w / num
  
  return res
end

function subtractFromVector(vec1,num)
 local res = vect3D:new()
  
  res.x = vec1.x - num
  res.y = vec1.y - num
  res.z = vec1.z - num
  --res.w = vec1.w / num
  
  return res
end

function multiplyVector(vec1,num)
 local res = vect3D:new()
  
  res.x = vec1.x * num
  res.y = vec1.y * num
  res.z = vec1.z * num
  --res.w = vec1.w / num
  
  return res
end

function multiplyVectorXY(vec1,num)
  local res = vect3D:new()
  
  res.x = vec1.x * num
  res.y = vec1.y * num
  --res.z = vec1.z * num
  --res.w = vec1.w / num
  
  return res
end

function divideVector(vec1,num)
local  res = vect3D:new()
  
  res.x = vec1.x / num
  res.y = vec1.y / num
  res.z = vec1.z / num
  --res.w = vec1.w / num
  
  return res
end

function flipVector(vec)
    
 local   res = vect3D:new()
    
    res.x = vec.x*-1
    res.y = vec.y*-1
    res.z = vec.z*-1
    
    return res
end

function normLengthVector(vec)
local  res = vect3D:new()
  
  res.x = vec.x * vec.x
  res.y = vec.y * vec.y
  res.z = vec.z * vec.z
  --res.w = vec.w * vec.w
  
  result = math.sqrt(res.x + res.y + res.z )
  
  return result
end

function normalizeVector(vec)
  
local  res = vect3D:new()
  length = normLengthVector(vec)
  
  res.x = vec.x/length
  res.y = vec.y/length
  res.z = vec.z/length
  
  return res
end




