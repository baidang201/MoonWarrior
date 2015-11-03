local scheduler = {}

local ccScheduler = cc.Director:getInstance():getScheduler()

function scheduler.delayGlobal(time, listener)

	local handle
	handle = ccScheduler:scheduleScriptFunc(
	function ()		
		ccScheduler:unscheduleScriptEntry(handle)
		listener()
	end,
	time,
	false
	)
end

return scheduler