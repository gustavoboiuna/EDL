local Manager = require('./lib/Manager')
-- Nome: comando local
-- Propriedade: sintaxe
-- Binding time: design
-- Explicação: Dado que "local" é uma palavra reservada de Lua, sua amarração só pode ter sido feita em tempo de design.

titulo = "Arkanoid"
-- Nome: variável titulo
-- Propriedade: endereço
-- Binding time: compile
-- Explicação: Como "titulo" é uma variável global com valor inicial já atribuido, seu espaço em memória será alocado em tempo de compilação.

function love.load()
  love.window.setTitle(titulo)
	manager = Manager:new()
	manager:load()
end

function love.update(dt)
	manager:update(dt)
end

function love.draw()
	manager:draw()
end
