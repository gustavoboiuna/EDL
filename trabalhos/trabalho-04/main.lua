local Manager = require('./lib/Manager')
-- Nome: comando local
-- Propriedade: sintaxe
-- Binding time: design
-- Explicação: Dado que "local" é uma palavra reservada de Lua, sua amarração só pode ter sido feita em tempo de design.
  
io.stdout:setvbuf("no")
function love.load()
  love.window.setTitle("Arkanoid")
	manager = Manager:new()
	manager:load()
end

function love.update(dt)
	manager:update(dt)
end

function love.draw()
	manager:draw()
end
