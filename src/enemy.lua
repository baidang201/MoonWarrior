local enemy = {}

-- cclog
local cclog = function(...)
    release_print(string.format(...))
    --print(string.format(...))
end

local scheduler = require("schedler")

function enemy:create_enemy(root, x, y, type)
    self.enemysprite = cc.Sprite:createWithSpriteFrameName("E0.png")
	root:addChild(self.enemysprite, 2000)
	self.enemysprite:setPosition( ccp(x,y) )
end

function enemy:move(point)
    cclog(string.format("moving  x:%d  y:%d", point.x, point.y))
	self.enemysprite:runAction(cc.MoveTo:create(1.0, point))
end

function enemy:startMove(point, delay)
	scheduler.delayGlobal(delay, function()	    
		enemy:move(point)
	end)
end

function enemy:getSprite()
    return self.enemysprite
end

return enemy