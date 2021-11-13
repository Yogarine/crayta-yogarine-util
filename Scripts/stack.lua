--------------------------------------------------------------------------------------------------------
--- Stack with a fixed size.
---
--- You can use this by attaching this script to an entity and retrieving it from other scripts through
--- self:GetEntity().stack.
---
--- Please report issues here: https://github.com/Yogarine/crayta-yogarine-util
---
--- @author    Alwin "Yogarine" Garside <alwin@garsi.de>
--- @copyright 2020-2021 Alwin Garside
--- @license   https://opensource.org/licenses/MIT MIT License
--------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------
--- @template T
--- @class Stack<T : Entity> : Script<T>
--- @field size     number
--- @field index    number
--- @field [number] any
--------------------------------------------------------------------------------------------------------
Stack = {}

----
--- Creates a new Stack.
---
--- @param  size           number
--- @param  startingIndex  number
--- @return table
----
function Stack:New(size, startingIndex)
	local o = {
		size  = size or nil,
		index = startingIndex or 1,
	}
	setmetatable(o, self)
	self.__index = self
	return o
end

----
--- Called on the server when this entity is created.
---
--- @return void
----
function Stack:Init()
	----
    --- @type Util
    ----
	self.Util = self:GetEntity().util
end

----
--- Called on the client when this entity is created.
---
--- @return void
----
function Stack:ClientInit()
	----
    --- @type Util
    ----
	self.Util = self:GetEntity().util
end

----
--- Push a value to the Stack.
---
--- @param  value  any
--- @return self
----
function Stack:Push(value)
	self[self.index] = value

	if self.size and self.index >= self.size then
		self.index = 1
	else
		self.index = self.index + 1
	end

	return self
end

----
--- Clears the Stack.
---
--- @template T
--- @return void
----
function Stack:Clear()
	for _, _ in ipairs(--[[---@type T[] ]] self) do
		table.remove(--[[---@type T[] ]] self)
	end
end

----
--- @return T
----
function Stack:Average()
	return self.Util.Average(--[[---@type T[] ]] self)
end

Yo.Util.InjectGlobal(Stack, "Yogarine", "Stack")
Yo.Util.InjectGlobal(Stack, "Yo", "Stack")

return Stack
