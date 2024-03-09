ScoreState = Class{__includes = BaseState}

function ScoreState:init()
  self.scores = 0
end

function ScoreState:enter(scores)
  self.scores = scores or 0
end

function ScoreState:render()
  love.graphics.setColor(255, 255, 255)
  love.graphics.setFont(messageFont)
  love.graphics.print(
    'You scored '..tostring(self.scores),
    0.5 * VIRTUAL_WIDTH - 80,
    0.5 * VIRTUAL_HEIGHT - 12
  )
end