Class = require 'class'
push = require 'push'

-- import objects
require 'Bird'
require 'Pipe'
require 'PipePair'
-- import states
require 'StateMachine'
require 'States/BaseState'
require 'States/PlayState'

-- physical screen dimensions
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
-- virtual resolution dimensions
VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

local backgroundImage = love.graphics.newImage('assets/background.png')
local groundImage = love.graphics.newImage('assets/ground.png')

local backgroundScroll = 0
local backgroundScrollSpeed = 30
-- empirical value obtrained through image copy overlay shifted by this value
local backgroundLoopingPoint = 413
local groundScroll = 0
local groundScrollSpeed = 60
-- empirical value obtrained through image copy overlay shifted by this value
local groundLoopingPoint = 136

function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest')
  love.window.setTitle('Fifty Bird')

  math.randomseed(os.time())

  -- "g" prefix is a naming convention used for the global variables
  gStateMachine = StateMachine {
    play = function () return PlayState() end
  }
  gStateMachine:change('play')

  push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    vsync = true,
    fullscreen = false,
    resizable = true
  })

  -- initialize input table
  -- (not a part of the love engine, i.e. custom implementation)
  love.keyboard.keyPressed = {}
end

function love.resize(width, height)
  push:resize(width, height)
end

function love.keypressed(key)
  love.keyboard.keyPressed[key] = true

  if key == 'escape' then
    love.event.quit()
  end
end

-- helper to check if the key is currently pressed
function love.keyboard.wasPressed(key)
  return love.keyboard.keyPressed[key] == true
end

function love.update(dt)
  backgroundScroll = (backgroundScroll + dt * backgroundScrollSpeed) %
    backgroundLoopingPoint
  groundScroll = (groundScroll + dt * groundScrollSpeed) %
    groundLoopingPoint

  gStateMachine:update(dt)

  -- reset input table
  love.keyboard.keyPressed = {}
end

function love.draw()
  push:start()

  love.graphics.draw(backgroundImage, -backgroundScroll, 0)
  gStateMachine:render()
  love.graphics.draw(groundImage, -groundScroll, VIRTUAL_HEIGHT - 16)

  push:finish()
end