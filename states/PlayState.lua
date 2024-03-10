PlayState = Class{__includes = BaseState}

function PlayState:init()
  self.bird = Bird()
  self.pipeCollection = {}
  self.pipeSpawnInterval = 2
  self.timer = 1

  self.scores = 0
  self.scoreThreshold = (VIRTUAL_WIDTH - self.bird.width) / 2

  self.paused = false
end

function PlayState:enter()
  scrolling = true
  -- generate the same level on each run
  math.randomseed(1)
end

function PlayState:render()
  -- render bird behind pipes
  self.bird:render()

  for _, pipePair in ipairs(self.pipeCollection) do
    pipePair:render()
  end

  love.graphics.setColor(255, 255, 255)
  love.graphics.setFont(displayFont)
  love.graphics.print(
    'SCORES: '..tostring(self.scores),
    0.78 * VIRTUAL_WIDTH,
    8
  )

  if self.paused then
    love.graphics.setFont(titleFont)
    love.graphics.print(
      'PAUSED',
      0.5 * VIRTUAL_WIDTH - 57,
      0.5 * VIRTUAL_HEIGHT - 14
    )
  end
end

function PlayState:update(dt)
  if love.keyboard.wasPressed('return') then
    self.paused = not self.paused
    scrolling = not self.paused
  end

  if self.paused then
    return
  end

  self.timer = self.timer + dt

  if self.timer > self.pipeSpawnInterval then
    self.timer = self.timer - self.pipeSpawnInterval
    self.pipeSpawnInterval = math.random(2, 3)

    local positionY = math.floor(VIRTUAL_HEIGHT / 2 + 25 - math.random(0, 50))
    table.insert(self.pipeCollection, PipePair(positionY))
  end

  self.bird:update(dt)

  for _, pipePair in ipairs(self.pipeCollection) do
    -- update pipe position
    pipePair:update(dt)

    if -- updates scores when bird passes pipe
      pipePair.x < self.scoreThreshold and
      pipePair.scored == false
    then
      pipePair.scored = true
      self.scores = self.scores + 1
    end

    -- schedule invisible pipes for delition
    if pipePair.x < -pipePair.width - 5 then
      pipePair.remove = true
    end

    -- detect collisions
    for _, pipe in pairs(pipePair.pipes) do
      if self.bird:collides(pipe) then
        sounds.hurt:play()
        gStateMachine:change('score', self.scores)
      end
    end
  end

  -- check ground
  if self.bird.y + self.bird.height > VIRTUAL_HEIGHT - 16 then
    sounds.hurt:play()
    gStateMachine:change('score', self.scores)
  end

  -- cleanup pipes
  for index, pipePair in ipairs(self.pipeCollection) do
    if pipePair.remove then
      table.remove(self.pipeCollection, index)
    end
  end
end