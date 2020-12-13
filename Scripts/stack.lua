--[[
Copyright © 2020 Alwin Garside

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

 1. Redistributions of source code must retain the above copyright notice, this
    list of conditions and the following disclaimer.
 2. Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions and the following disclaimer in the documentation
    and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
]]--

------------------------------------------------------------------------------------------------------------------------
-- @module    Yogarine.Stack
-- @author    Alwin "Yogarine" Garside <alwin@garsi.de>
-- @copyright 2020 Alwin Garside
-- @license   https://opensource.org/licenses/BSD-2-Clause 2-Clause BSD License
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- Stack with a fixed size.
--
-- You can use this by attaching this script to an entity and retrieving it from other scripts through
-- self:GetEntity().stack
--
-- @type Stack
------------------------------------------------------------------------------------------------------------------------

---
-- @field properties Properties: Holds the values that have been set on an instance of a script.
---
Stack = {}

---
-- Creates a new Stack.
---
function Stack:New(size, startingIndex)
	o = {
		size  = size or nil,
		index = startingIndex or 1,
	}
	setmetatable(o, self)
	self.__index = self
	return o
end

---
-- Called on the server when this entity is created.
---
function Stack:Init()
	---
	-- !Util: Yogarine's Util class.
	---
	self.Util = self:GetEntity().util
end

---
-- Called on the client when this entity is created.
---
function Stack:ClientInit()
	---
	-- !Util: Yogarine's Util class.
	---
	self.Util = self:GetEntity().util
end


---
-- Push a value to the Stack.
--
-- @param  value
-- @treturn Stack
---
function Stack:Push(value)
	self[self.index] = value

	if self.size and self.index >= self.size then
		self.index = 1
	else
		self.index = self.index + 1
	end

	return self
end

---
-- Clears the Stack.
---
function Stack:Clear()
	for _,_ in ipairs(self) do
		table.remove(self)
	end
end

function Stack:Average()
	return self.Util.Average(self)
end

Yo.Util.InjectGlobal(Stack, "Yogarine", "Stack")
Yo.Util.InjectGlobal(Stack, "Yo", "Stack")

return Stack
