local function test_collision(obj1, obj2)
    local obj1_left = obj1.x
    local obj1_right = obj1.x + obj1.width
    local obj1_top = obj1.y
    local obj1_bottom = obj1.bottom or obj1.y + obj1.height

    local obj2_left = obj2.x
    local obj2_right = obj2.x + obj2.width
    local obj2_top = obj2.y
    local obj2_bottom = obj2.bottom or obj2.y + obj2.height

    return obj1_right > obj2_left and obj1_left < obj2_right
       and obj1_bottom > obj2_top 
       and obj1_top < obj2_bottom
end

return test_collision