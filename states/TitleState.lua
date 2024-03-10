TitleState = Class{__includes = BaseState}

function TitleState:init()
end

function TitleState:render()
  local centerY = -29 -- -14

  love.graphics.setColor(255, 255, 255)
  love.graphics.setFont(titleFont)
  love.graphics.print(
    'Fifty Bird',
    0.5 * VIRTUAL_WIDTH - 75,
    0.5 * VIRTUAL_HEIGHT + centerY
  )

  love.graphics.setFont(displayFont)
  love.graphics.print(
    'Press ENTER to start',
    0.5 * VIRTUAL_WIDTH - 88,
    0.5 * VIRTUAL_HEIGHT + centerY + 38
  )

  love.graphics.setFont(smallFont)
  love.graphics.print('Controls:', 16, 0.5 * VIRTUAL_HEIGHT + centerY + 110)
  love.graphics.print('ENTER - pause', 16, 0.5 * VIRTUAL_HEIGHT + centerY + 122)
  love.graphics.print('SPACE - jump', 16, 0.5 * VIRTUAL_HEIGHT + centerY + 134)
end

function TitleState:update(dt)
  if love.keyboard.wasPressed('return') then
    gStateMachine:change('timer')
  end
end