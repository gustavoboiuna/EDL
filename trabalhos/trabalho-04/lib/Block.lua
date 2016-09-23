-- Define the block's attributes
local Block = {
	width = 95,
	height = 15,
	col = 0,
	color = {255, 255, 255},
}

-- Create the block object
function Block:new(x, y, col)
	object = {}
	setmetatable(object, self)
	self.__index = self

	object.x, object.y, object.col = x, y, col
	object:setColor()

	return object
end

-- Draw the block
function Block:draw()
	love.graphics.setColor(self.color)
	love.graphics.polygon('fill', 
		self.x - Block.width/2, self.y - Block.height/2,
		self.x + Block.width/2, self.y - Block.height/2,
		self.x + Block.width/2, self.y + Block.height/2,
		self.x - Block.width/2, self.y + Block.height/2)
end
-- Nome: operador "+"
-- Propriedade: valor da instrução em baixo nível
-- Binding time: compile
-- Explicação: A instrução de adição varia de acordo com os tipos dos termos que serão somados (e.g int, double, float etc). Dessa forma, a sua instrução é definida em tempo de compilação.

-- Set the color of the block based on its column
function Block:setColor()
	    if self.col == 0 then self.color = {237,  50,  55} -- red
	elseif self.col == 1 then self.color = {245, 134,  52} -- orange
	elseif self.col == 2 then self.color = {255, 242,  18} -- yellow
	elseif self.col == 3 then self.color = {  0, 168,  89} -- green
	elseif self.col == 4 then self.color = {  0, 175, 239} -- blue
	elseif self.col == 5 then self.color = { 62,  64, 149} -- purple
	elseif self.col == 6 then self.color = {129,  90, 164} -- pink
	elseif self.col < 0 or self.col > 6 then self.color = {255, 0, 255} end -- white
end

return Block
