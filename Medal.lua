Medal = Class{}

function easeInBack(x)
  local c1 = 1.70158;
  local c3 = c1 + 1;
  return c3 * x * x * x - c1 * x * x;
end

local scaleFactor = 0.6
local velocity = 2

function Medal:init(x, y)
  self.image = love.graphics.newImage('assets/medal.png')
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()

  self.x = x
  self.y = y

  self.scale = 1 + scaleFactor
  self.timer = 0
end

function Medal:render()
  love.graphics.draw(
    self.image,
    self.x + self.width / 2,
    self.y + self.height / 2,
    0, -- angle
    self.scale,
    self.scale,
    self.width / 2, -- origin x
    self.height / 2 -- origin y
  )
end

function Medal:update(dt)
  -- simple animation
  if self.scale > 1 then
    self.timer = self.timer + dt
    self.scale = math.max(1 + scaleFactor - scaleFactor * easeInBack(velocity * self.timer), 1)
  end
end