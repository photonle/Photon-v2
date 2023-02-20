local ENT = FindMetaTable("Entity")

local blank = "photon/common/blank"

function ENT:Photon_OverrideMetaTable(name)
	if isstring(name) then name = exmeta.FindMetaTable(name) end
	exmeta.SetMetaTable(self:GetTable(), name)
	-- exmeta.SetMetaTable(self, name)
	-- debug.setmetatable(self:GetTable(), FindMetaTable(name))
end

function ENT:Photon_HideSubMaterial(index)
	self:SetSubMaterial(index, blank)
end

function ENT:Photon_HideSubMaterials(...)
	for _,i in ipairs({...}) do
		if (isstring(i)) then i = self:GetSubMaterialIndex(i) end
		self:SetSubMaterial(i, blank)
	end
end

function ENT:Photon_RestoreSubMaterial(index)
	self:SetSubMaterial(index)
end

function ENT:Photon_RestoreSubMaterials(...)
	for _,i in ipairs({...}) do
		self:SetSubMaterial(i)
	end
end

function ENT:Photon_GetSubMaterialIndex(name)
	for i, v in ipairs(self:GetMaterials()) do
		if v == name then return i - 1 end
	end
	return -1
end