Photon2.Util = Photon2.Util or {}


---@param target table
---@param meta table
function Photon2.Util.ReferentialCopy( target, meta )
	for k, v in pairs(meta) do
		if istable(v) then
			if (target[k] == nil) then
				target[k] = meta[k]
			end
			Photon2.Util.ReferentialCopy(target[k], meta[k])
		end
	end
	debug.setmetatable(target, { __index = meta })
end

