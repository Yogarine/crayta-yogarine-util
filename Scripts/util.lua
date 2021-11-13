--------------------------------------------------------------------------------------------------------
--- A collection of useful Utility functions.
---
--- You can use this by attaching this script to an entity and retrieving it from other scripts through
--- self:GetEntity().util
---
--- Please report issues here: https://github.com/Yogarine/crayta-yogarine-util
---
--- @author    Alwin "Yogarine" Garside <alwin@garsi.de>
--- @copyright 2020-2021 Alwin Garside
--- @license   https://opensource.org/licenses/MIT MIT License
---
--- @shape _G
--- @field [string] any
--------------------------------------------------------------------------------------------------------

----
--- @class Util : Script<Entity>
----
Util = {}

----
--- (No) Script properties are defined here.
----
Util.Properties = {}

----
--- Get average of all the values in the given table.
---
--- @generic V
--- @param  collection  V[]
--- @return V Averaged value.
----
function Util.Average(collection)
	local sum

	for _, value in ipairs(collection) do
		if nil == sum then
			sum = value
		else
			sum = sum + value
		end
	end

	-- Hack to calculate average of Rotations.
	if nil ~= sum.pitch and nil ~= sum.yaw and nil ~= sum.roll then
		sum.pitch = sum.pitch / #collection
		sum.yaw = sum.yaw / #collection
		sum.roll = sum.roll / #collection

		return sum
	end

	return sum / #collection
end

----
--- Returns the tick rate based on where this code is running.
---
--- @return number
----
function Util.GetTickRate()
	if IsServer() then
		return 30
	else
		return 60
	end
end

----
--- Inject a value into the global scope.
---
--- @param  value  any
--- @vararg string
----
function Util.InjectGlobal(value, ...)
	local args = { ... }
	local name = table.remove(args)

	local G = _G
	for _, namespace in ipairs(args) do
		if not G[namespace] then
			G[namespace] = {}
		end
		G = G[namespace]
	end

	G[name] = value
end

----
--- Recursively dumps the given variable in the console.
---
--- @param  data  any
----
function Util.DumpVar(data)
	--- @type table<string, string> @Cache of tables already printed, to avoid infinite recursive loops.
	local tablecache = {}
	local buffer = ""
	local padder = "    "

	local function _dumpVar(var, depth)
		local type = type(var)
		local string = tostring(var)

		if (type == "table") then
			if (tablecache[string]) then
				-- Table already dumped before, so we don't dump it again, just mention it.
				buffer = buffer .. "<" .. string .. ">\n"
			else
				tablecache[string] = (tablecache[string] or 0) + 1
				buffer = buffer .. "(" .. string .. ") {\n"

				for key, value in pairs(var) do
					buffer = buffer .. string.rep(padder, depth + 1) .. "[" .. key .. "] => "
					_dumpVar(value, depth + 1)
				end

				buffer = buffer .. string.rep(padder, depth) .. "}\n"
			end
		elseif (type == "number") then
			buffer = buffer .. "(" .. type .. ") " .. string .. "\n"
		else
			buffer = buffer .. "(" .. type .. ") \"" .. string .. "\"\n"
		end
	end

	_dumpVar(data, 0)

	Print(buffer)
end

----
--- Generate a UUID.
---
--- @overload fun(): string
--- @return string, number
----
function Util:GenerateUuid()
	math.randomseed(GetWorld():GetServerTime())

	local template = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'

	return string.gsub(
		template,
		'[xy]',
		--- @param c string
		function(c)
			local v = (c == 'x')
				and math.random(0, 0xf)
				or math.random(8, 0xb)
			return string.format('%x', v)
		end
	)
end

----
--- @param  event                    Event
--- @param  listenerScriptComponent  Script<Entity>
--- @param  functionName             string
--- @return void
----
function Util:ListenToLocalEvent(event, listenerScriptComponent, functionName)
	if not IsClient() or not self:GetEntity():IsLocal() then
		self:SendToLocal("ListenToLocalEvent", event, listenerScriptComponent, functionName)
	end

	event:Listen(listenerScriptComponent, functionName)
end

----
--- @param  count         number
--- @param  limit         number
--- @param  errorMessage  string
--- @return number
----
function Util.Timeout(count, limit, errorMessage)
	limit = limit or 300
	errorMessage = errorMessage or "Timed out after " .. count .. " tries"

	count = count + 1
	if count > limit then
		error(errorMessage)
	end

	return count
end

Util.InjectGlobal(Util, "Yogarine", "Util")
Util.InjectGlobal(Util, "Yo", "Util")

return Util
