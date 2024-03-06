Bird = Class{}

-- acceleration of gravity
local g = 980

function Bird:init()
  self.image = love.graphics.newImage('assets/bird.png')
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()

  self.x = (VIRTUAL_WIDTH - self.width) / 2
  self.y = (VIRTUAL_HEIGHT - self.height) / 2

  self.dy = 0
end

function Bird:render()
  love.graphics.draw(self.image, self.x, self.y)
end

function Bird:update(dt)
  self.dy = self.dy + 0.5 * g * dt * dt

  if love.keyboard.wasPressed('space') then
    self.dy = -0.004 * g
  end

  self.y = self.y + self.dy
end