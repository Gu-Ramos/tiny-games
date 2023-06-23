local lg = love.graphics
local min, max = math.min, math.max
local bird = {
    x=0,y=316,
    width=120,height=87,
    xspeed=500, yspeed=0,
    max_speed=2000,
    acceleration=2000,

    img=lg.newImage('bird.png'),
}
function bird:draw() lg.draw(self.img, self.x,self.y, 0, 0.1) end
function bird:draw_hitbox() lg.rectangle('line', self.x,self.y, self.width,self.height) end
function bird:move(x,y)
    self.x = min(max(0, self.x + x), 1160)
end
function bird:update(dt)
    self.yspeed = self.yspeed + self.acceleration*dt
    self.yspeed = min(max(-self.max_speed,self.yspeed),self.max_speed)
    self.y = self.y + self.yspeed*dt
end

return bird