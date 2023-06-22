local lg = love.graphics
local lk = love.keyboard
local rand = love.math.newRandomGenerator(os.time())

local Bird = require('bird')
local PipeUP, PipeDOWN = unpack(require('pipes'))
local collision_test = require('collide')

local pipe_list = {}
local pipe_speed = 300
local timer = 0
local dead = false
local death_timer = -1
local total_timer = 0

function love.load()
    require('load')
end

lg.setDefaultFilter('nearest','nearest')

function love.update(dt)
    if death_timer >= 0 then
        death_timer = death_timer - dt
    elseif dead then
        dead = false
        Bird.x=0
        Bird.y=316
        pipe_list={}
        timer=0
        total_timer = 0
    else
        total_timer = total_timer + dt
        timer = timer - dt

        local velocity = {x=0,y=0}
        if lk.isDown('up') then velocity.y = velocity.y - Bird.speed*dt end
        if lk.isDown('down') then velocity.y = velocity.y + Bird.speed*dt end
        if lk.isDown('right') then velocity.x = velocity.x + Bird.speed*dt end
        if lk.isDown('left') then velocity.x = velocity.x - Bird.speed*dt end
        Bird:move(velocity.x, velocity.y)

        for _,pipe in ipairs(pipe_list) do
            pipe:move(-pipe.speed*dt)
        end

        if timer <= 0 then
            local rand_height = rand:random(0, 520)
            local comp_height = 720-rand_height-200
            table.insert(pipe_list, PipeUP({height=rand_height, speed=pipe_speed}))
            table.insert(pipe_list, PipeDOWN({height=comp_height, speed=pipe_speed}))
            timer = 1.15
        end
    
        for _,pipe in ipairs(pipe_list) do
            local pipe_coords = {x=pipe.x, width=pipe.width, height=pipe.height}
            if pipe.type == 'PIPEUP' then
                pipe_coords.y = 0
            else
                pipe_coords.y = 720-pipe.height
            end

            if collision_test(Bird,pipe_coords) then
                dead = true
                death_timer = 3
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
        lg.print("COMO DIMINUI\nA FONTE", 0,100, 0, 20)
    end
    lg.print(string.format("%.2f", total_timer), 10,5, 0, 3)
end