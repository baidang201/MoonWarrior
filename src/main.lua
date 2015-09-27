require "config"
require "cocos.init"

-- cclog  
local cclog = function(...)  
    print(string.format(...)) 
end  
   
   
-- for CCLuaEngine traceback  
function __G__TRACKBACK__(msg)
    cclog("----------------------------------------")  
    cclog("LUA ERROR: " .. tostring(msg) .. "\n")  
    cclog(debug.traceback())  
    cclog("----------------------------------------")  
    return msg  
end  

local function file_exists(path)
    local file = io.open(path, "rb")
    if file then file:close() end
    return file ~= nil
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
	
	if cc.PLATFORM_OS_WINDOWS == targetPlatform then
	   glview:setFrameSize(960, 640)
	end
			
	
	local scene = cc.Scene:create()
    local rootNode = cc.CSLoader:createNode("MainScene.csb")
    scene:addChild(rootNode)    
    
    local root = rootNode:getChildByName("root")      
	
	
    local btnLogin = ccui.Helper:seekWidgetByName(root, "btnLogin")
    local txtUserName = ccui.Helper:seekWidgetByName(root, "txtUserName")
    local txtUserName = ccui.Helper:seekWidgetByName(root, "txtPassword")
	
	
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
