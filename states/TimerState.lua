TimerState = Class{__includes = BaseState}

local countInterval = 0.7

function TimerState:init()
  self.count = 3
  self.timer = 0
end

function TimerState:render()
  love.graphics.setColor(255, 255, 255)
  love.graphics.setFont(titleFont)
  love.graphics.print(
    tostring(self.count),
    0.5 * VIRTUAL_WIDTH - 6,
    0.5 * VIRTUAL_HEIGHT - 16
  )
end

function TimerState:update(dt)
  self.timer = self.timer + dt

  if self.timer > countInterval then
    self.timer = self.timer - countInterval
    self.count = self.count - 1
  end

  if self.count == 0 then
    gStateMachine:change('play')
  end
end