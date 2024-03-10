ScoreState = Class{__includes = BaseState}

function ScoreState:init()
  self.medals = {}
  self.scores = 0
end

function ScoreState:enter(payload)
  scrolling = false

  self.scores = payload and payload.scores or 0
  local medals = payload and payload.medals or 0

  -- display earned medals
  if medals and medals > 0 then
    local centerX = -18 * payload.medals / 2

    for i = 1,payload.medals do
      table.insert(
        self.medals,
        Medal(
          0.5 * VIRTUAL_WIDTH + centerX + 18 * (i - 1),
          0.5 * VIRTUAL_HEIGHT + 33
        )
      )
    end
  end
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

  for _, medal in ipairs(self.medals) do
    medal:render()
  end
end

function ScoreState:update(dt)
  for _, medal in ipairs(self.medals) do
    medal:update(dt)
  end

  if love.keyboard.wasPressed('return') then
    gStateMachine:change('play')
  end
end