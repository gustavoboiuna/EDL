function love.load()
  love.window.setTitle("Imagens de Dor e Sofrimento")
  windowX = love.graphics.getWidth()
  windowY = love.graphics.getHeight()
  
  font = love.graphics.newFont(15)
  love.graphics.setFont(font)
  
  frase = "Nunca sofri tanto pra arrumar um ambiente de desenvolvimento na vida"
  fraseX = windowX/2 - font:getWidth(frase)/2
  fraseY = 10
  
  dor = love.graphics.newImage("Sofrimento.jpg")
  x = windowX/2 - dor:getWidth()/2
  y = windowY/2 - dor:getHeight()/2
end

function love.draw()
  love.graphics.draw(dor, x, y)
  love.graphics.print(frase,fraseX, fraseY)
end