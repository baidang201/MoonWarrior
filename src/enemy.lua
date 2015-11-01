local enemy = {}

local enemysprite = nil

function enemy:create_enemy(root, x, y, type)
    enemysprite = cc.Sprite:createWithSpriteFrameName("E0.png")
	root:addChild(enemysprite, 2000)
	enemysprite:setPosition( ccp(x,y) )
end


return enemy