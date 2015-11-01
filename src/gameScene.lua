local scene

-- cclog
local cclog = function(...)
    release_print(string.format(...))
    --print(string.format(...))
end


local hero_sprite = require("hero")
local enemys = require("enemy")

local touchX = 0
local touchY = 0


local function create_play(root)
    hero_sprite:create_hero_sprite(root)
end

--创建小怪阵列
local function create_enemys(root)
	--enemy = enemy:create_hero_sprite(root, 100, 200)
end

local winsize = cc.Director:getInstance():getWinSize()

local function init(parameters)

    cc.SpriteFrameCache:getInstance():addSpriteFrames("Enemy.plist")

	scene = cc.Scene:create()
		
	local bglayer = cc.Layer:create()	
	 
	local bgsprite1 = cc.Sprite:create("bg01.jpg")
    local bgsprite2 = cc.Sprite:create("bg01.jpg")
    
    bgsprite1:setPosition(0, 0)
    bgsprite1:setAnchorPoint(ccp(0, 0))
    bglayer:addChild(bgsprite1, 1)
    
    bgsprite2:setPosition(0, bgsprite1:getPositionY() + bgsprite1:getContentSize().height)
    bgsprite2:setAnchorPoint(ccp(0,0))
    bglayer:addChild(bgsprite2, 2)
	
    cclog(bgsprite1:getContentSize().height)
	
	local function bg_run()
		--cclog("run")
		local speed = 2
		
		bgsprite1:setPositionY( bgsprite1:getPositionY() - speed)
		bgsprite2:setPositionY( bgsprite1:getPositionY() + bgsprite1:getContentSize().height )
		
		if bgsprite2:getPositionY() <= 0 then
		  bgsprite1:setPositionY(0)
		end
	end	
    
    create_play(bglayer)
    
    
    local function register_touch_event( )
    	local function onTouchBegan(x, y)
    	   cclog("began")
    	   touchX = x
    	   touchY = y
           --hero_sprite:move(x, y)
    	   return true
    	end 
    	
        local function onTouchMoved(x, y)
            cclog("moved")
            
            local subX = x-touchX
            local subY = y-touchY
            
            local heroCurrentX, heroCurrentY = hero_sprite:getPoint()
            
            hero_sprite:move(heroCurrentX + subX, heroCurrentY + subY)
            
            touchX = x
            touchY = y
            
            return true
        end 
        
        local function onTouchEnded(x, y)
            cclog("ended")
            return true;
        end
        
        local function onTouch(eventType, x, y)
            if eventType == "began" then
        	       return onTouchBegan(x,y)
        	   elseif eventType == "moved" then
        	       return onTouchMoved(x,y)
        	   else
        	       return onTouchEnded(x,y)
        	       
        	end
        end
        
        bglayer:registerScriptTouchHandler(onTouch, false, 0, true)
        bglayer:setTouchEnabled(true)  
    end
    
    register_touch_event() 
    
	--add layer to scene
	scene:addChild(bglayer)
	
	
    cc.Director:getInstance():getScheduler():scheduleScriptFunc(bg_run, 1.0/60.0, fasle)
    
    
    
    --play music
    --[[
    local musicPath = "Music/bgMusic.mp3"
    cc.SimpleAudioEngine:getInstance():preloadMusic(musicPath)
    cc.SimpleAudioEngine:getInstance():playBackgroundMusic(musicPath, true)
    ]]
end


init()

return scene