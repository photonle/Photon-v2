if ( exmeta.ReloadFile() ) then return end

NAME = "PhotonMaterial"

local print = Photon2.Debug.Print
local printf = Photon2.Debug.PrintF

local textureParams = {
	["$basetexture"] = true,
	["$bumpmap"] = true,
	["$envmap"] = true,
	["$detail"] = true,
	["$phongexponenttexture"] = true,
}

---@class PhotonMaterialProperties
---@field Name string
---@field Parameters table Material parameters.
---@field Shader? "VertexLitGeneric" | "UnlitGeneric" Default `UnlitGeneric`.
---@field Smooth? boolean If smoothing should be used on PNG materials.
---@field Mipmaps? boolean If mipmaps should be generated for PNG materials.
---@field Prefix? string

---@class PhotonMaterial : PhotonMaterialProperties
---@field MaterialName string
---@field IsGenerated boolean
---@field IsDynamic boolean If material texture is a render target (and drawn via code).
---@field Version number This is not supported server-side.
---@field Textures table<string, IMaterial> Original PNG materials used as textures.
---@field Render fun(self: PhotonMaterial) Called when the material's texture is drawn.
local material = exmeta.New()

material.Shader = "UnlitGeneric"
material.Prefix = "photon_material/"
material.Version = 1
material.Mipmaps = false
material.Smooth = true

---@param data PhotonMaterialProperties
---@param asNew? boolean If a new IMaterial should always be generated.
---@return PhotonMaterial
function material.New( data, asNew )
	if SERVER then return {} end

	if not ( data.Name ) then 
		error( "No name defined on material." )
	end

	if ( material.Get( data.Name ) ) then
		return material.Get( data.Name ):Update( data )
	end

	local result = {
		Name = data.Name,
		Prefix = data.Prefix,
		Shader = data.Shader,
		Parameters = data.Parameters,
		Mipmaps = data.Mipmaps,
		Smooth = data.Smooth,
		Textures = {},
		IsGenerated = false,
		OnGenerated = data.OnGenerated
	}

	setmetatable( result, { __index = material } )

	result:GenerateCreationName()

	if CLIENT then
		if ( Photon2.Materials.Ready ) then
			result:Generate()
		else
			Photon2.Materials.Queue[result.Name] = result
		end
	end

	return result
end

---@param name string
---@return PhotonMaterial
function material.Get( name )
	if SERVER then return nil end
	if ( Photon2.Materials.Ready ) then
		return Photon2.Materials.Index[name]
	else
		return Photon2.Materials.Queue[name]
	end
end

---@param mat string
function material.GenerateLightQuad( mat )
	return material.New({
		Name = string.StripExtension( mat ),
		Shader = "UnlitGeneric",
		Parameters = {
			["$basetexture"] = mat,
			["$nocull"] = 1,
			["$additive"] = 1,
			["$vertexalpha"] = 1,
			["$vertexcolor"] = 1
		}
	})
end

function material.GenerateWithTemplate( name, template, inject )
	local parameters = table.Copy( template )
	local shader = parameters.Shader
	parameters.Shader = nil
	return material.New({
		Name = name,
		Shader = shader,
		Parameters = table.Merge( parameters, inject )
	})
end

function material:GeneratePngParameters( params )
	local result = ""
	if ( not isstring( params ) ) then params = "" end
	if ( self.Shader == "VertexLitGeneric" ) then
		result = result .. "vertexlitgeneric "
	end
	if ( self.Mipmaps ) then result = result .. "mips " end
	if ( self.Smooth ) then result = result .. "smooth " end
	result = result .. params
	return result
end

function material.GetPngTexture( png, params )
	return Material( png, params ):GetTexture( "$basetexture" )
end

-- Returns material parameters table compatible with the `CreateMaterial(...)` function.
function material:GenerateCreationParameters( parameters )
	local result = {}

	for key, value in pairs( parameters ) do
		if ( isvector( value ) ) then
			result[key] = "[" .. tostring(value) .. "]"
		elseif ( isnumber( value ) ) then
			result[key] = value
		elseif ( textureParams[key] ) then
			-- Texture parameters
			if ( isstring( value ) ) then
				if ( string.EndsWith( value, ".png" ) ) then
					self.Textures[key] = Material( value, self:GeneratePngParameters() )
					result[key] = self.Textures[key]:GetTexture( "$basetexture" ):GetName()
				else
					result[key] = value
				end
			elseif ( istable( value ) and isstring ( value[1] ) and string.EndsWith( value[1], ".png" ) ) then
				self.Textures[key] = Material( value[1], self:GeneratePngParameters( value[2] ) )
				result[key] = self.Textures[key]:GetTexture( "$basetexture" ):GetName()
			end
		elseif ( istable( value ) ) then
			result[key] = self:GenerateCreationParameters( value )
		else
			result[key] = tostring( value )
		end
	end

	return result
end

-- Creates the IMaterial object in game. Must be delayed until the game loads to work properly.
function material:Generate( increment )
	if SERVER then return end
	CreateMaterial( self:GenerateCreationName( increment ), self.Shader, self:GenerateCreationParameters( self.Parameters ) )
	self.IsGenerated = true
	Photon2.Materials.Queue[self.Name] = nil
	Photon2.Materials.Index[self.Name] = self
	self:OnGenerated()
end

-- Generates the name to be used with `CreateMaterial(...)` and updates the resulting .MaterialName.
---@param increment? boolean Increments the material version and uses it in the name.
function material:GenerateCreationName( increment )
	if ( increment ) then self.Version = self.Version + 1 end
	local result = self.Prefix .. self.Name
	if ( increment ) then result = result .. tostring( self.Version ) end
	self.MaterialName = "!" .. result
	return result
end

-- For updating materials that have already been generated.
function material:UpdateParameters( recompute )
	local mat = self:GetMaterial()
	for key, value in pairs( self.Parameters ) do
		if ( textureParams[key] ) then
			if ( isstring( value ) ) then
				if ( string.EndsWith( value, ".png" ) ) then
					self.Textures[key] = Material( value, self:GeneratePngParameters() )
					mat:SetTexture( key, self.Textures[key]:GetTexture( "$basetexture" ) )
				end
			elseif ( istable( value ) and isstring ( value[1] ) and string.EndsWith( value[1], ".png" ) ) then
				self.Textures[key] = Material( value[1], self:GeneratePngParameters( value[2]) )
				mat:SetTexture( key, self.Textures[key]:GetTexture( "$basetexture" ) )
			end
		elseif ( isnumber( value ) and (value % 1) == 0 ) then mat:SetFloat( key, value )
		elseif ( isnumber( value ) ) then mat:SetFloat( key, value )
		elseif ( isvector( value ) ) then mat:SetVector( key, value )
		elseif ( IsColor( value ) ) then mat:SetVector( key, value )
		elseif ( isstring( value ) and ( not textureParams[key] )) then mat:SetString( key, value )
		elseif ( ismatrix( value ) ) then mat:SetMatrix( key, value )
		elseif ( type(value) == "IMaterial" ) then mat:SetTexture( key, value:GetTexture( key ) )
		elseif ( type(value) == "ITexture" ) then mat:SetTexture( key, value )
		else
			print("[WARNING] Unhandled material parameter type [" .. tostring(type( value ) .. "] in parameter [" .. tostring( key ) .. "]"))
		end
	end
	if ( recompute ) then
		mat:Recompute()
	end
end

function material:GetMaterial()
	return Material( self.MaterialName )
end

-- Called when a new material is created with an existing name.
function material:Update( data, asNew )
	
	self.Shader = data.Shader
	self.Parameters = data.Parameters
	self.Mipmaps = data.Mipmaps
	self.Smooth = data.Smooth
	
	if SERVER then return self end

	if ( Photon2.Materials.Ready ) then
		if ( asNew or not self.IsGenerated ) then
			self:Generate( asNew )
		else
			self:UpdateParameters( true )
		end
	end
	
	return self
end

function material:GetOrGenerateRenderTarget()
	if ( not self.RenderTarget ) then
		if ( self.Textures["$basetexture"] ) then
			local tex = self.Textures["$basetexture"]:GetTexture( "$basetexture" )
			self.RenderTarget = GetRenderTargetEx( self.Name, tex:Width(), tex:Height(), RT_SIZE_OFFSCREEN, MATERIAL_RT_DEPTH_SHARED, 16, 0, IMAGE_FORMAT_RGBA8888 )
		end
	end
	return self.RenderTarget
end

function material:MakeDynamic()
	self.IsDynamic = true
	self:GetMaterial():SetTexture( "$basetexture", self:GetOrGenerateRenderTarget() )
	self:DoRender()
end

function material:DoRender()
	cam.Start2D()
	-- (Doing the hook like this may be necessary if there are material loading problems)
	-- hook.Add("PostDrawHUD", "Photon2.Render:" .. self.Name, function()
		-- hook.Remove( "PostDrawHUD", "Photon2.Render:" .. self.Name )
		render.PushRenderTarget( self:GetOrGenerateRenderTarget() )
			render.ClearDepth()
			render.SetMaterial( self.Textures["$basetexture"] )
			render.DrawScreenQuad()
			self:Render()
		render.PopRenderTarget()
	cam.End2D()
	-- end)
end

-- For override.
function material:Render() end

function material:OnGenerated()

end