-- Love2D 11.x EmmyLua type annotations
-- Used by lua-language-server and EmmyLua (IntelliJ) for autocomplete.
-- This file is not executed — it's a stub for tooling only.

---@class lovelib
love = {}

-- ─── Core callbacks ───────────────────────────────────────────────────────────

---Called once at startup.
function love.load() end

---Called every frame. Use dt to advance simulation.
---@param dt number Delta time in seconds since last frame
function love.update(dt) end

---Called every frame after update. Pure rendering only.
function love.draw() end

---@param key string The key name (e.g. "space", "return", "a")
---@param scancode string Hardware scancode
---@param isrepeat boolean True if this is a key-repeat event
function love.keypressed(key, scancode, isrepeat) end

---@param key string
---@param scancode string
function love.keyreleased(key, scancode) end

---@param x number
---@param y number
---@param button number  1=left, 2=right, 3=middle
---@param istouch boolean
---@param presses number
function love.mousepressed(x, y, button, istouch, presses) end

---@param x number
---@param y number
---@param button number
---@param istouch boolean
---@param presses number
function love.mousereleased(x, y, button, istouch, presses) end

---@param x number New x position
---@param y number New y position
---@param dx number Delta x
---@param dy number Delta y
---@param istouch boolean
function love.mousemoved(x, y, dx, dy, istouch) end

---@param text string The UTF-8 encoded character
function love.textinput(text) end

---@param w number New window width
---@param h number New window height
---@param flags table
function love.resize(w, h, flags) end

---Called when the game should quit. Return true to cancel.
---@return boolean?
function love.quit() end

-- ─── love.graphics ────────────────────────────────────────────────────────────

---@class love.Image
---@field getWidth fun(self: love.Image): number
---@field getHeight fun(self: love.Image): number
---@field getDimensions fun(self: love.Image): number, number

---@class love.SpriteBatch
---@field add fun(self: love.SpriteBatch, x: number, y: number, r?: number, sx?: number, sy?: number, ox?: number, oy?: number)
---@field clear fun(self: love.SpriteBatch)
---@field draw fun(self: love.SpriteBatch, x?: number, y?: number)

---@class love.Quad
---@field getViewport fun(self: love.Quad): number, number, number, number

---@class love.Font
---@field getHeight fun(self: love.Font): number
---@field getWidth fun(self: love.Font, text: string): number

---@class love.Canvas
---@field getWidth fun(self: love.Canvas): number
---@field getHeight fun(self: love.Canvas): number
---@field getDimensions fun(self: love.Canvas): number, number

---@class love.Shader

---@class love.graphics
love.graphics = {}

---Set the active drawing color.
---@param r number  0–1
---@param g number  0–1
---@param b number  0–1
---@param a? number 0–1 (default 1)
function love.graphics.setColor(r, g, b, a) end

---@return number r, number g, number b, number a
function love.graphics.getColor() end

---Reset color to white (1,1,1,1).
function love.graphics.setColor(r, g, b, a) end

---Set the background clear color.
---@param r number
---@param g number
---@param b number
---@param a? number
function love.graphics.setBackgroundColor(r, g, b, a) end

---Clear the screen (called automatically each frame).
---@param r? number
---@param g? number
---@param b? number
---@param a? number
function love.graphics.clear(r, g, b, a) end

---Draw an image or drawable.
---@param drawable love.Image | love.Canvas | love.SpriteBatch
---@param x? number
---@param y? number
---@param r? number Rotation in radians
---@param sx? number X scale
---@param sy? number Y scale
---@param ox? number X origin offset
---@param oy? number Y origin offset
function love.graphics.draw(drawable, x, y, r, sx, sy, ox, oy) end

---Draw a rectangle.
---@param mode "fill"|"line"
---@param x number
---@param y number
---@param w number
---@param h number
---@param rx? number Corner radius x
---@param ry? number Corner radius y
function love.graphics.rectangle(mode, x, y, w, h, rx, ry) end

---Draw a circle.
---@param mode "fill"|"line"
---@param x number
---@param y number
---@param radius number
---@param segments? number
function love.graphics.circle(mode, x, y, radius, segments) end

---Draw a line between points.
---@param x1 number
---@param y1 number
---@param x2 number
---@param y2 number
---@vararg number Additional x,y pairs
function love.graphics.line(x1, y1, x2, y2, ...) end

---Draw a filled or outlined polygon.
---@param mode "fill"|"line"
---@param ... number  x1, y1, x2, y2, ...
function love.graphics.polygon(mode, ...) end

---Print text at a position.
---@param text string
---@param x? number
---@param y? number
---@param r? number
---@param sx? number
---@param sy? number
function love.graphics.print(text, x, y, r, sx, sy) end

---Print formatted text.
---@param text string|table
---@param x? number
---@param y? number
---@param limit? number Wrap width
---@param align? "left"|"center"|"right"|"justify"
function love.graphics.printf(text, x, y, limit, align) end

---Load an image from disk.
---@param filename string
---@return love.Image
function love.graphics.newImage(filename) end

---Create a new font.
---@param filename? string  nil = default font
---@param size? number      default 12
---@return love.Font
function love.graphics.newFont(filename, size) end

---@param font love.Font
function love.graphics.setFont(font) end

---@return love.Font
function love.graphics.getFont() end

---Create a new canvas (render target).
---@param width? number
---@param height? number
---@return love.Canvas
function love.graphics.newCanvas(width, height) end

---Set the active canvas (nil = screen).
---@param canvas? love.Canvas
function love.graphics.setCanvas(canvas) end

---Create a quad (sub-region of an image).
---@param x number
---@param y number
---@param w number
---@param h number
---@param sw number Source image width
---@param sh number Source image height
---@return love.Quad
function love.graphics.newQuad(x, y, w, h, sw, sh) end

---Draw an image using a quad.
---@param image love.Image
---@param quad love.Quad
---@param x? number
---@param y? number
---@param r? number
---@param sx? number
---@param sy? number
---@param ox? number
---@param oy? number
function love.graphics.draw(image, quad, x, y, r, sx, sy, ox, oy) end

---@return number width, number height
function love.graphics.getDimensions() end

---@return number
function love.graphics.getWidth() end

---@return number
function love.graphics.getHeight() end

---Save the current transform/scissor state.
function love.graphics.push() end

---Restore previous transform/scissor state.
function love.graphics.pop() end

---Reset transform to identity.
function love.graphics.origin() end

---Translate the coordinate system.
---@param x number
---@param y number
function love.graphics.translate(x, y) end

---Scale the coordinate system.
---@param sx number
---@param sy? number
function love.graphics.scale(sx, sy) end

---Rotate the coordinate system.
---@param angle number Radians
function love.graphics.rotate(angle) end

---Set line width.
---@param width number
function love.graphics.setLineWidth(width) end

-- ─── love.keyboard ────────────────────────────────────────────────────────────

---@class love.keyboard
love.keyboard = {}

---Check if a key is currently held down.
---@param key string  e.g. "left", "space", "lshift"
---@return boolean
function love.keyboard.isDown(key) end

---@param scancode string
---@return boolean
function love.keyboard.isScancodeDown(scancode) end

-- ─── love.mouse ───────────────────────────────────────────────────────────────

---@class love.mouse
love.mouse = {}

---@return number x, number y
function love.mouse.getPosition() end

---@return number
function love.mouse.getX() end

---@return number
function love.mouse.getY() end

---@param button number  1=left 2=right 3=middle
---@return boolean
function love.mouse.isDown(button) end

---@param x number
---@param y number
function love.mouse.setPosition(x, y) end

---@param visible boolean
function love.mouse.setVisible(visible) end

-- ─── love.audio ───────────────────────────────────────────────────────────────

---@class love.Source
---@field play fun(self: love.Source)
---@field stop fun(self: love.Source)
---@field pause fun(self: love.Source)
---@field setVolume fun(self: love.Source, v: number)
---@field setLooping fun(self: love.Source, loop: boolean)
---@field isPlaying fun(self: love.Source): boolean
---@field clone fun(self: love.Source): love.Source

---@class love.audio
love.audio = {}

---@param filename string
---@param type? "static"|"stream"  default "static"
---@return love.Source
function love.audio.newSource(filename, type) end

---@param source love.Source
function love.audio.play(source) end

---@param source love.Source
function love.audio.stop(source) end

---@param volume number  0–1
function love.audio.setVolume(volume) end

---@return number
function love.audio.getVolume() end

-- ─── love.math ────────────────────────────────────────────────────────────────

---@class love.math
love.math = {}

---@param min? number  default 0
---@param max? number  default 1
---@return number
function love.math.random(min, max) end

---@param seed number
function love.math.setRandomSeed(seed) end

---@param x number
---@param y number
---@return number  0–1 Perlin noise
function love.math.noise(x, y) end

---@param r number  0–1
---@param g number  0–1
---@param b number  0–1
---@return number h, number s, number v
function love.math.RGBtoHSV(r, g, b) end

-- ─── love.timer ───────────────────────────────────────────────────────────────

---@class love.timer
love.timer = {}

---@return number  Seconds since game started
function love.timer.getTime() end

---@return number  Delta time of the last frame
function love.timer.getDelta() end

---@return number  Average frames per second
function love.timer.getFPS() end

---@param seconds number
function love.timer.sleep(seconds) end

-- ─── love.filesystem ──────────────────────────────────────────────────────────

---@class love.filesystem
love.filesystem = {}

---@param filename string
---@return string? contents, string? err
function love.filesystem.read(filename) end

---@param filename string
---@param data string
---@param size? number
---@return boolean success, string? err
function love.filesystem.write(filename, data, size) end

---@param filename string
---@return boolean
function love.filesystem.getInfo(filename) end

---@param path string
---@return table  Array of filenames
function love.filesystem.getDirectoryItems(path) end

-- ─── love.window ──────────────────────────────────────────────────────────────

---@class love.window
love.window = {}

---@param title string
function love.window.setTitle(title) end

---@return string
function love.window.getTitle() end

---@return number width, number height, table flags
function love.window.getMode() end

---@param width number
---@param height number
---@param flags? table
---@return boolean
function love.window.setMode(width, height, flags) end

---@return boolean
function love.window.isFullscreen() end

---@param fullscreen boolean
---@param fstype? "desktop"|"exclusive"
---@return boolean
function love.window.setFullscreen(fullscreen, fstype) end
