local lg = love.graphics
local bird = {
    x=0,y=316,
    width=120,height=87,
    speed=500,

    img=lg.newImage('bird.png'),
}
function bird:draw() lg.draw(self.img, self.x,self.y, 0, 0.1) end
function bird:draw_hitbox() lg.rectangle('line', self.x,self.y, self.width,self.height) end
function bird:move(x,y) self.x = self.x + x; self.y = self.y + y end
return bird