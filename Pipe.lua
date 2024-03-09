Pipe = Class{}

function Pipe:init(alignment, positionY)
  self.alignment = alignment

  self.image = love.graphics.newImage('assets/pipe.png')
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()

  self.x = 0 -- will be updated by PipePair
  self.y = self.alignment == 'top' and positionY - self.height or positionY
end

function Pipe:render()
  love.graphics.draw(
    self.image,
    self.x,
    self.alignment == 'top' and self.y + self.height or self.y,
    0, -- orientation (radians)
    1, -- scale factor x
    self.alignment == 'top' and -1 or 1 -- scale factor y
  )
end