push = require 'libs/push'
Class = require 'libs/class'

require 'src/Lys'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

local background = love.graphics.newImage('src/assets/to_be_replaced/background.png')
local ground = love.graphics.newImage('src/assets/to_be_replaced/ground.png')
local cursor = love.graphics.newImage('src/assets/cursor-text.png')
local backgroundScroll = 0
local groundScroll = 0

local BACKGROUND_SCROLL_SPEED = 30
local GROUND_SCROLL_SPEED = 60

local BACKGROUND_LOOPING_POINT = 413

local lys = Lys()

function love.load()
   love.graphics.setDefaultFilter('nearest', 'nearest')
   love.window.setTitle('Flapplys')
   love.mouse.setVisible(false)

   push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
       vsync = true,
       fullscreen = false,
       resizable = true
   })
end

function love.resize(width, height)
   push:resize(width, height)
end

function love.keypressed(key)
   if key == 'escape' then
       love.event.quit()
   end
end

function love.update(dt)
   backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt)
      % BACKGROUND_LOOPING_POINT

   groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt)
      % VIRTUAL_WIDTH

   lys:update(dt)
end

function love.draw()
   push:start()
   
   love.graphics.draw(background, -backgroundScroll, 0)
   love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)
   lys:render()
   
   
   love.graphics.draw(cursor, love.mouse.getX(), love.mouse.getY())
   push:finish()
end
