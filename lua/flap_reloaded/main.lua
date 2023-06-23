local lg = love.graphics
local lk = love.keyboard
local rand = love.math.newRandomGenerator(os.time())
local min,max = math.min, math.max

local Bird = require('bird')
local PipeUP, PipeDOWN = unpack(require('pipes'))
local collision_test = require('collide')

local pipe_list = {}
local pipe_speed = 300
local timer = 0
local dead = false
local death_timer = -1
local total_timer = 0

local ScoreFont = lg.newFont(50)
local DeathFont = lg.newFont(165)

lg.setDefaultFilter('nearest','nearest')

function love.update(dt)
    if death_timer >= 0 then
        death_timer = death_timer - dt
    elseif dead then
        dead = false
        Bird.x=0
        Bird.y=316
        Bird.yspeed = 0
        pipe_list={}
        timer=0
        total_timer = 0
    else
        total_timer = total_timer + dt
        timer = timer - dt

        local velocity = 0
        -- if lk.isDown('up') then velocity.y = velocity.y - Bird.speed*dt end
        -- if lk.isDown('down') then velocity.y = velocity.y + Bird.speed*dt end
        if lk.isDown('right') then velocity = velocity + Bird.xspeed*dt end
        if lk.isDown('left') then velocity = velocity - Bird.xspeed*dt end
        Bird:move(velocity)
        Bird:update(dt)

        for _,pipe in ipairs(pipe_list) do
            pipe:move(-pipe.speed*dt)
        end

        if timer <= 0 then
            local rand_height = rand:random(0, 520)
            local comp_height = 720-rand_height-200
            table.insert(pipe_list, PipeUP({height=rand_height, speed=pipe_speed}))
            table.insert(pipe_list, PipeDOWN({height=comp_height, speed=pipe_speed}))
            timer = 1.5
        end
    
        for _,pipe in ipairs(pipe_list) do
            if pipe.x > -64 then
                local pipe_coords = {x=pipe.x, width=pipe.width}
                if pipe.type == 'PIPEUP' then
                    pipe_coords.y = -math.huge
                    pipe_coords.bottom = pipe.height
                else
                    pipe_coords.y = 720-pipe.height
                    pipe_coords.bottom = math.huge
                end

                if collision_test(Bird,pipe_coords) then
                    dead = true
                    death_timer = 1
                end
            else
                table.remove(pipe_list, 1)
            end
        end
    end
end

function love.draw()
    Bird:draw()
    Bird:draw_hitbox()

    for _,pipe in ipairs(pipe_list) do
        pipe:draw()
    end

    if dead then
        lg.setFont(DeathFont)
        lg.print("PELO AMOR DE DEUS\nCOMO Q DIMINUI\nA FONTE",0,100)
    end
    
    lg.setFont(ScoreFont)
    lg.print(string.format("%.2f", total_timer), 10,5)
end

function love.keypressed(k)
    if k == 'space' or k == 'up' then
        if Bird.yspeed > 0 then
            Bird.yspeed = 0
        end
        Bird.yspeed = max(min(-500, Bird.yspeed -250), -800)
    end
end