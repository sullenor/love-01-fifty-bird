ScoreState = Class{__includes = BaseState}

function ScoreState:init()
  self.scores = 0
end

function ScoreState:enter(scores)
  self.scores = scores or 0
end

function ScoreState:render()
  local centerY = -29
  local centerX = self.scores > 9 and -6 or 0

  love.graphics.setColor(255, 255, 255)
  love.graphics.setFont(titleFont)
  love.graphics.print(
    'You scored '..tostring(self.scores),
    0.5 * VIRTUAL_WIDTH + centerX - 110,
    0.5 * VIRTUAL_HEIGHT + centerY
  )

  love.graphics.setFont(displayFont)
  love.graphics.print(
    'Press ENTER to restart',
    0.5 * VIRTUAL_WIDTH - 97,
    0.5 * VIRTUAL_HEIGHT + centerY + 38
  )
end

function ScoreState:update(dt)
  if love.keyboard.wasPressed('return') then
    gStateMachine:change('play')
  end
end