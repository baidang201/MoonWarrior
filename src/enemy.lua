local enemy = {}

-- cclog
local cclog = function(...)
    release_print(string.format(...))
    --print(string.format(...))
end

function enemy:create_enemy(root, x, y, type)
    self.enemysprite = cc.Sprite:createWithSpriteFrameName("E0.png")
	root:addChild(self.enemysprite, 2000)
	self.enemysprite:setPosition( ccp(x,y) )
end

function enemy:getSprite()
    return self.enemysprite
end

return enemy