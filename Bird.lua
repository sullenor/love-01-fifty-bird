Bird = Class{}

-- acceleration of gravity
local g = 980
-- max allowed offset for collision
local mistake = 5

function Bird:init()
  self.image = love.graphics.newImage('assets/bird.png')
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()

  self.x = (VIRTUAL_WIDTH - self.width) / 2
  self.y = (VIRTUAL_HEIGHT - self.height) / 2

  self.dy = 0
end

function Bird:collides(pipe)
  if
    self.x > pipe.x + pipe.width - mistake or
    self.x + self.width < pipe.x + mistake
  then
    return false
  end

  if
    self.y > pipe.y + pipe.height - mistake or
    self.y + self.height < pipe.y + mistake
  then
    return false
  end

  return true
end

function Bird:render()
  local angle = self.dy > 0 and 0.1 * math.pi
    or self.dy < 0 and -0.1 * math.pi
    or 0

  love.graphics.draw(
    self.image,
    self.x + self.width / 2,
    self.y + self.height / 2,
    angle,
    1,
    1,
    self.width / 2,
    self.height / 2
  )
end

function Bird:update(dt)
  self.dy = self.dy + 0.5 * g * dt * dt

  if love.keyboard.wasPressed('space') then
    self.dy = -0.004 * g
  end

  self.y = self.y + self.dy
end