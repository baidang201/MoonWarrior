require "config"
require "cocos.init"

-- cclog
local cclog = function(...)
    release_print(string.format(...))
	--print(string.format(...))
end


-- for CCLuaEngine traceback
function __G__TRACKBACK__(msg)
    cclog("----------------------------------------")
    cclog("LUA ERROR: " .. tostring(msg) .. "\n")
    cclog(debug.traceback())
    cclog("----------------------------------------")
    return msg
end

local function main()


    collectgarbage("collect")
    collectgarbage("setpause",100)
    collectgarbage("setstepmul",5000)

    cc.FileUtils:getInstance():setPopupNotify(false)
    cc.FileUtils:getInstance():addSearchPath("src")
    cc.FileUtils:getInstance():addSearchPath("res")    

    
    local glview = cc.Director:getInstance():getOpenGLView()
    local targetPlatform = cc.Application:getInstance():getTargetPlatform()

--[[
    if cc.PLATFORM_OS_WINDOWS == targetPlatform then
        glview:setFrameSize(640, 960)
    end
    ]]
    cc.Director:getInstance():getOpenGLView():setDesignResolutionSize(600, 900, cc.ResolutionPolicy.NO_BORDER) -- NO_BORDER可以修改成上面任意一种模式


    local scene = require("gameScene")
    

    if cc.Director:getInstance():getRunningScene() then
    cc.Director:getInstance():replaceScene(scene)
    else
    cc.Director:getInstance():runWithScene(scene)
    end
    
    cclog("hello world!!!")
end


local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end
