-- combines top and bottom pipes together
PipePair = Class{}

local pipeDistance = 110
local pipeScrollSpeed = 60

function PipePair:init(centerY)
  self.x = VIRTUAL_WIDTH
  self.y = centerY

  self.pipes = {
    top = Pipe('top', self.y - pipeDistance / 2),
    bottom = Pipe('bottom', self.y + pipeDistance / 2)
  }

  self.width = self.pipes.top.width

  self.remove = false
  self.scored = false
end

function PipePair:render()
  for _, pipe in pairs(self.pipes) do
    pipe:render()
  end
end

function PipePair:update(dt)
  self.x = self.x - dt * pipeScrollSpeed

  for _, pipe in pairs(self.pipes) do
    pipe.x = self.x
  end
end