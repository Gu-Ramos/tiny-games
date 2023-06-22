local lg = love.graphics

local pipe_up = {x=1280,height=300,width=60,speed=200,type='PIPEUP'}
function pipe_up:move(x)
    self.x = self.x + x
end
function pipe_up:draw()
    lg.setColor(0.0,0.7,0.2)
    lg.rectangle('fill', self.x,0, self.width,self.height)
    lg.setColor(1,1,1)
end

local pipe_up_meta = {}
pipe_up_meta.__call=function(self, conf)
    local conf = conf or {}
    local newpipe = {}
    for k,v in pairs(pipe_up) do
        newpipe[k] = conf[k] or v
    end
    setmetatable(newpipe, pipe_up_meta)
    return newpipe
end

setmetatable(pipe_up, pipe_up_meta)



local pipe_down = {x=1280,height=300,width=60,speed=200,type='PIPEDOWN'}
function pipe_down:move(x)
    self.x = self.x + x
end
function pipe_down:draw()
    lg.setColor(0.0,0.7,0.2)
    lg.rectangle('fill', self.x,720-self.height, self.width,self.height)
    lg.setColor(1,1,1)
end

local pipe_down_meta = {}
pipe_down_meta.__call=function(self, conf)
    local conf = conf or {}
    local newpipe = {}
    for k,v in pairs(pipe_down) do
        newpipe[k] = conf[k] or v
    end
    setmetatable(newpipe, pipe_down_meta)
    return newpipe
end

setmetatable(pipe_down, pipe_down_meta)

return {pipe_up, pipe_down}