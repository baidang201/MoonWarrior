local hero = {}

local hero_sprite

-- cclog
local cclog = function(...)
    release_print(string.format(...))
    --print(string.format(...))
end

local winsize = cc.Director:getInstance():getWinSize()

function hero:create_hero_sprite(root)  
    
    self.array = {} 
    
    cc.SpriteFrameCache:getInstance():addSpriteFrames("bullet.plist")
    self.bulletBatchNode = cc.SpriteBatchNode:create("bullet.png")
    self.bulletBatchNode:retain()
    root:addChild(self.bulletBatchNode, 999)
    
    local rect = cc.rect(0,0,60,43)
	hero_sprite = cc.Sprite:create("ship01.png")
	root:addChild(hero_sprite, 1000)
	hero_sprite:setPosition(400, 400)	
		
	--play animate
	local frame1 = cc.SpriteFrame:create("ship01.png",rect)	
	rect = cc.rect(60,0,60,43)	
	local frame2 = cc.SpriteFrame:create("ship01.png",rect)	
    local array = {}
    array[1] = frame1
    array[2] = frame2    
    local animation = cc.Animation:createWithSpriteFrames(array, 0.1)
    local animate = cc.Animate:create(animation)
    hero_sprite:runAction( cc.RepeatForever:create(animate))
    
    local function create_new_bullet()
    	local b = cc.Sprite:createWithSpriteFrameName("W1.png")
    	self.bulletBatchNode:addChild(b)
    	b:setPosition(hero_sprite:getPosition())
    	
    	table.insert(self.array, b)
    end
    
    local function move_bullets()
        local speed = 15
        for key, var in ipairs(self.array) do
            b = var
    		b = tolua.cast(b, "Sprite")
    		b:setPositionY(b:getPositionY() + speed)
    	end
    end
    
    cclog("create_hero_sprite ok") 
    
    cc.Director:getInstance():getScheduler():scheduleScriptFunc(create_new_bullet, 1.0/10.0, false)
    cc.Director:getInstance():getScheduler():scheduleScriptFunc(move_bullets, 1.0/ 30.0, false)
       
    return hero_sprite
end

function hero:getBulletsArray()
	return self.array
end

function hero:move(x, y)
    hero_sprite:setPosition(ccp(x,y))
end

function hero:getPoint()
    return hero_sprite:getPositionX(), hero_sprite:getPositionY()
end

return hero