-- Define the ball's attributes
local Ball = {
	radius = 10,
	moveIncrement = 300,
	direction = {0, 0}
}

-- Create the ball object
function Ball:new()
	object = {}
	setmetatable(object, self)
	self.__index = self

	object.x, object.y = Ball.place()

	return object
end

-- Spawn the ball at the correct position
function Ball:place()
	x = love.graphics.getWidth() / 2
	y = love.graphics.getHeight() * 2/3
  Ball.direction[2] = -1
  Ball.direction[1] = 0
  
	return x, y
end

-- Update the ball
function Ball:update(dt)
  self.y = self.y - (self.direction[2] * self.moveIncrement * dt)
  self.x = self.x + (self.direction[1] * self.moveIncrement * dt)
  
  if self.x >= (love.graphics.getWidth() - self.radius) or self.x <= (0 + self.radius) then
    self.direction[1] = self.direction[1] * -1
  end
  
  if self.y <= (0 + self.radius) then
    self.direction[2] = -1
  end
  -- Nome: comando if
  -- Propriedade: sintaxe
  -- Binding time: design
  -- Explicação: A estrutura "if" em Lua teve sua sintaxe definida em tempo de design. 
  -- Por conta disso ela deve ser escrita de uma forma específica seguindo regras previamente definidas. 
  -- Um exemplo de como isso afeta a escrita da linguagem é como em Lua se abre um bloco de instruções usando "then" e se fecha com "end". Em C, por exemplo, se abre com "{" e se fecha com "}".
  
  if self.y >= love.graphics.getHeight() then
    --MORREU
  end
end

-- Draw the ball
function Ball:draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.circle("fill", self.x, self.y, self.radius, 100)
end

function Ball:checkCollision(object)
  if (self.x + self.radius) > (object.x - object.width/2) and 
     (self.x - self.radius) < (object.x + object.width/2) and
     (self.y + self.radius) > (object.y - object.height/2) and
     (self.y - self.radius) < (object.y + object.height/2) then
      self:changeDirection(object.x, object.width)
      return true
  end

  return false
end

function Ball:changeDirection(x, width)
  self.direction[2] = self.direction[2] * -1
  division = width/2
  
  if self.x > x  then
    self.direction[1] = 1
  elseif self.x >= (x - division) then
    self.direction[1] = -1
  end
end

return Ball
