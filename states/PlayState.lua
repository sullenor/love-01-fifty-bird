PlayState = Class{__includes = BaseState}

local pipeSpawnInterval = 2

function PlayState:init()
  self.bird = Bird()
  self.pipeCollection = {}
  self.timer = 0
end

function PlayState:render()
  -- render bird behind pipes
  self.bird:render()

  for _, pipePair in ipairs(self.pipeCollection) do
    pipePair:render()
  end
end

function PlayState:update(dt)
  self.timer = self.timer + dt

  if self.timer > pipeSpawnInterval then
    self.timer = self.timer - pipeSpawnInterval

    local positionY = VIRTUAL_HEIGHT / 2
    table.insert(self.pipeCollection, PipePair(positionY))
  end

  self.bird:update(dt)

  -- update pipe position
  for _, pipePair in ipairs(self.pipeCollection) do
    pipePair:update(dt)

    if pipePair.x < -pipePair.width - 5 then
      pipePair.remove = true
    end
  end

  -- cleanup pipes
  for index, pipePair in ipairs(self.pipeCollection) do
    if pipePair.remove then
      table.remove(self.pipeCollection, index)
    end
  end
end