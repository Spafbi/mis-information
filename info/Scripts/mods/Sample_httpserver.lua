
--[[-- remove the block comment to enable

-- if normal http/xmlrpc server is running (http_startserver command)

-- http://localhost:64904/helloworld  - The http port is always +4 if available
--- max of 16 connection shared with xml rpc (only one authed rpc per time)
--- can be exhausted easily.. (timeout, half open etc) should not be directly accessed by users but instead through a inbtween service.

function GetHTTPURLAction(url, client, connection)
	if url == "/helloworld" then
		return "<HTML><HEAD><TITLE>Hello World " .. tostring(client) .. " " .. tostring(connection) .. "</TITLE></HEAD></HTML>"
	end
end


-- use RegisterCallbackReturnAware if you need multiple listeners
-- RegisterCallbackReturnAware(_G, "GetHTTPURLAction", ....) -- be sure you added at least one GetHTTPURLAction to global namepsace before
--- see common.lua

--]]--