print("\n\n--------------- RUNNING PHOTON 2 TEST FILE: B ---------------\n\n")
if SERVER then return end


function meshMaterialTesting()
	local modelTarget = "models/tdmcars/emergency/for_crownvic.mdl"
	
	local csent = ClientsideModel( modelTarget )
	csent:SetPos( Vector(0,0,0) )
	csent:Spawn()

	PrintTable(csent:GetMaterials())

	local result = {}
	for i=0, 127 do
		result[i] = csent:GetSubMaterial( i )
	end
	csent:Remove()

	PrintTable( result )
end

-- meshMaterialTesting()

function triangleTest()
	local modelTarget = "models/sentry/96cvpi.mdl"
	local meshMat = "sentry/96cvpi/lights2"
	local meshResult = Photon2.MeshCache.GetMesh( modelTarget, meshMat )

	local triangles = Photon2.MeshCache.Cache[modelTarget][meshMat][1].Triangles
	print( "TRIANGLE LENGTH: " .. tostring( #triangles ) )
	local avg = Vector()
	PrintTable( triangles[1] )
	for i=1, #triangles do
		avg = avg + triangles[i].pos
	end
	avg.x = avg.x / #triangles
	avg.y = avg.y / #triangles
	avg.z = avg.z / #triangles
	print( "Average: " .. tostring( avg ) )
end

-- Function to calculate the center point of a set of vectors based on their bounding box
function findCenter(vectors)
	if #vectors == 0 then
	  return nil, "No vectors provided"
	end
  
	-- Initialize min and max coordinates
	local minX, maxX = vectors[1].pos.x, vectors[1].pos.x
	local minY, maxY = vectors[1].pos.y, vectors[1].pos.y
	local minZ, maxZ = vectors[1].pos.z, vectors[1].pos.z
  
	-- Loop through each vector to find min and max for each coordinate
	for i, triangle in ipairs(vectors) do
		local vector = triangle.pos
	  if vector.x < minX then minX = vector.x end
	  if vector.x > maxX then maxX = vector.x end
  
	  if vector.y < minY then minY = vector.y end
	  if vector.y > maxY then maxY = vector.y end
  
	  if vector.z < minZ then minZ = vector.z end
	  if vector.z > maxZ then maxZ = vector.z end
	end
  
	-- Calculate the center point of the bounding box
	local centerX = (minX + maxX) / 2
	local centerY = (minY + maxY) / 2
	local centerZ = (minZ + maxZ) / 2
  
	return {x = centerX, y = centerY, z = centerZ}
  end
  

--   local center = findCenter(triangles)
  
--   if center then
-- 	print("Center:", "x:", math.Round(center.x, 3), "y:", math.Round(center.y, 3), "z:", math.Round(center.z, 3) )
--   else
-- 	print("No center point could be calculated.")
--   end

-- Global Reinhard tone mapping
function reinhardToneMapping(color)
    local r, g, b = color[1], color[2], color[3]

    r = r / (r + 1)
    g = g / (g + 1)
    b = b / (b + 1)

    return {r, g, b}
end

-- Green boost based on brightness
function greenBoost(color, brightness)
    local r, g, b = color[1], color[2], color[3]

    g = g + brightness * 0.1  -- Adjust the multiplier as needed

    -- Ensure all channels remain within the [0, 1] range
    r = math.clamp(r, 0, 1)
    g = math.clamp(g, 0, 1)
    b = math.clamp(b, 0, 1)

    return {r, g, b}
end

-- Combined function
function toneMapAndBoost(color, brightness)
    local toneMappedColor = reinhardToneMapping(color)
    return greenBoost(toneMappedColor, brightness)
end

-- Helper function to clamp values within a given range
function math.clamp(value, low, high)
    return math.min(math.max(value, low), high)
end

-- Example usage:
local hdrColor = {1, 0, 0}  -- Red color with brightness > 1 to simulate an HDR value
local resultColor = toneMapAndBoost(hdrColor, 10)  -- This will tone map and then boost the green based on the brightness

-- PrintTable( resultColor )

-- for _,ply in pairs(player.GetAll()) do
-- 	ply:SetViewOffsetDucked(Vector(0,0,28))
-- 	ply:SetHullDuck( Vector(-100, -100, -100), Vector(100,100,100) )
-- 	print('working')
-- end

-- hook.Add("HandlePlayerDucking", "DisableDuckingShit", function( ply, vel )
-- 	print("ducking?")
-- 	ply:SetViewOffsetDucked(Vector(0,0,100))
-- 	return true
-- end)

if SERVER then
	-- hook.Add("PlayerButtonDown", "Photon2:TestButtonDown", function( ply, button ) 
	-- 	print(tostring(ply) .. ": " .. tostring(button))
	-- end)
end

concommand.Add("setsize", function(ply, cmd, args)
	local targ = ply:GetEyeTrace().Entity
	targ:SetModelScale(0.9)
	targ:Activate()
end)

concommand.Add("setbodygroup", function(ply, cmd, args)
	local targ = ply:GetEyeTrace().Entity
	print( tostring( targ ) )
	targ:SetBodygroup(args[1], args[2])
end)

if not CLIENT then return end


concommand.Add("p2_getmodel", function(ply, cmd, args)
	local targ = ply:GetEyeTrace().Entity
	if ( IsValid( targ ) ) then
		print( tostring( targ:GetModel() ) )
		SetClipboardText( targ:GetModel() )
	end
end)

-- MESH TESTING
-- local model = "models/schmal/sos_undercover.mdl"

local mat_Copy		= Material( "pp/copy" )
local mat_Add		= Material( "pp/add" )
local mat_Sub		= Material( "pp/sub" )
local rt_Store		= render.GetScreenEffectTexture( 0 )
local rt_Blur		= render.GetScreenEffectTexture( 1 )

local function meshTest()
	local model = "models/sentry/21durango.mdl"
	local targetMaterial = "sentry/21durango/tail_ct"
	local targetMaterialSubMesh = 1
	-- util.PrecacheModel( model )
	-- local meshes = util.GetModelMeshes( model )

	local drawMaterial = Material("photon/common/glow")

	local position = Vector( 0, 0, 0 )
	local angles = Angle( 0, 0, 0 )
	local scale = Vector( 1, 1, 1 )
	-- local index = exutil.GetModelMesh( model, "sentry/21durango/tail_cb" )
	-- print("index: " .. tostring( index ))
	-- 
	-- local meshLookup = {}
	-- for k, v in pairs( meshes ) do
	-- 	meshLookup[v.material] = meshLookup[v.material] or {}
	-- 	meshLookup[v.material][#meshLookup[v.material]+1] = v
	-- 	print( tostring(k) .. ": " .. tostring(v) )
	-- 	for _k, _v in pairs( v ) do
	-- 		print( "\t" .. tostring(_k) .. ": " .. tostring(_v) )
	-- 	end
	-- end

	-- for k, v in pairs( meshLookup ) do
	-- 	print("Material: " .. tostring( k ) .. " Count: " .. tostring(#v))
	-- end

	-- print( "Was mesh found for material: " .. tostring(meshLookup[targetMaterial] ~= nil ) )
	-- print( "Was sub-mesh found for mesh: " .. tostring(meshLookup[targetMaterial][targetMaterialSubMesh] ~= nil ) )
	-- print( "Does sub-mesh have .triangles: " .. (tostring(meshLookup[targetMaterial][targetMaterialSubMesh].triangles ~= nil)))
	
	-- local meshTriangles = meshLookup[targetMaterial][targetMaterialSubMesh].triangles
	-- print( "Is meshTriangles still valid: " .. (tostring( meshTriangles ~= nil )))


	-- local vertexMesh = Mesh( drawMaterial )
	-- vertexMesh:BuildFromTriangles( meshTriangles )
	-- local vertexMesh = Photon2.MeshCache.GetMesh( model, targetMaterial, targetMaterialSubMesh )
	-- local matrix = Matrix()
	-- print( "Does vertexMesh exist: " .. tostring(vertexMesh ~= nil))

	local function drawMesh()
		matrix:SetTranslation( position )
		matrix:SetAngles( angles )
		matrix:SetScale( scale )

		cam.Start3D()
			cam.PushModelMatrix( matrix, false )
			render.OverrideColorWriteEnable( true, true)
			render.SetColorModulation(1, 1, 1)
			drawMaterial:SetVector( "$color", Vector(0, 255, 255))
			render.SetMaterial( drawMaterial )
			vertexMesh:Draw()
			render.OverrideColorWriteEnable( false, true)
			cam.PopModelMatrix()
		cam.End3D()

	end

	-- hook.Remove("PostDrawTranslucentRenderables", "Photon2:MeshDrawTest")

	hook.Add( "PreDrawHalos", "Photon2:MeshDrawTest", function( a, b, c )
		-- if (a or b or c) then return end
		-- drawMesh()
	end)

	local additive = true

	local drawPasses = 1

	local function drawBloom()
		local rt_Scene = render.GetRenderTarget()
		render.CopyRenderTargetToTexture( rt_Store )
		if ( additive ) then
			render.Clear( 0, 0, 0, 255, false, true )
		else
			render.Clear( 255, 255, 255, 255, false, true )
		end

		cam.Start3D()
			render.SetStencilEnable( true )
				render.SuppressEngineLighting( true )
				render.SetStencilWriteMask( 1 )
				render.SetStencilTestMask( 1 )
				render.SetStencilReferenceValue( 1 )

				render.SetStencilCompareFunction( STENCIL_ALWAYS )
				render.SetStencilPassOperation( STENCIL_REPLACE )
				render.SetStencilFailOperation( STENCIL_KEEP )
				render.SetStencilZFailOperation( STENCIL_KEEP )

				drawMesh()

				render.SetStencilCompareFunction( STENCIL_EQUAL )
				render.SetStencilPassOperation( STENCIL_KEEP )

				cam.Start2D()
					surface.SetDrawColor( 255, 255, 255, 255 )
					surface.DrawRect( 0, 0, ScrW(), ScrH() )
				cam.End2D()
				
				render.SuppressEngineLighting( false )
			render.SetStencilEnable( false)
		cam.End3D()

		render.CopyRenderTargetToTexture( rt_Blur )
		render.BlurRenderTarget( rt_Blur, 1, 1, 1 )


		render.SetRenderTarget( rt_Scene )
		mat_Copy:SetTexture( "$basetexture", rt_Store )
		mat_Copy:SetString( "$color", "1 1 1")
		render.SetMaterial( mat_Copy )
		render.DrawScreenQuad()


		render.SetStencilEnable( true )
			render.SetStencilCompareFunction( STENCIL_NOTEQUAL )
			
			if ( additive ) then
				mat_Add:SetTexture( "$basetexture", rt_Blur )
				render.SetMaterial( mat_Add )
			end

			for i=0, drawPasses do
				render.DrawScreenQuad()
			end
		render.SetStencilEnable( false )

		render.SetStencilTestMask( 0 )
		render.SetStencilWriteMask( 0 )
		render.SetStencilReferenceValue( 0 )

	end

	hook.Add( "PostDrawEffects", "Photon2:BloomTest", function()
		drawBloom()
	end)

end
-- meshTest()

local gradient = {
	{ 0, 0, 255 },
	{ 0, 255, 0 }
}

local function getColor( x )
	local start = gradient[1]
	local stop = gradient[2]

	local r = start[1] + ((stop[1] - start[1]) * x)
	local g = start[2] + ((stop[2] - start[2]) * x)
	local b = start[3] + ((stop[3] - start[3]) * x)

	print( Color(r,g,b) )
end

-- getColor(0.0)

local function getBlendColor( baseColor, shiftColor, x )
	return {
		baseColor[1] + (( shiftColor[1] - baseColor[1]) * x ),
		baseColor[2] + (( shiftColor[2] - baseColor[2]) * x ),
		baseColor[3] + (( shiftColor[3] - baseColor[3]) * x )
	}
end

-- PrintTable( getBlendColor({0,0,32}, {0,32,32}, 0.9))

if true then return end


local attachments = {
	"wheel_fl", "wheel_fr", "wheel_rl", "wheel_rr"
}

local wheelBones = {
	"wheel_fl", "wheel_fr", "wheel_rl", "wheel_rr"
}

local x = 1.72
local y = 0.548
local z = 1


local angleTransforms = {

}

local function durangoWheelTest()
	if true then return end
	-- print('wheel')
	for k, ent in pairs( ents.GetAll() ) do
		ent = ent ---@as Entity
		local parent = ent:GetParent()
		if ( IsValid( ent ) and ( ent:GetModel() == "models/schmal/dodur21_wheels.mdl") ) then
			-- print("found durango extras")
			-- local boneCount = parent:GetBoneCount()
			-- print("Bone count: " .. tostring( boneCount ) )
			
			for i=1, #attachments do
				local parentAttachmentIndex = parent:LookupAttachment( attachments[i] )
				local boneIndex = ent:LookupBone( wheelBones[i] )
				
				-- PrintTable( parent:Get)
				
				
				-- print("parent index: " .. tostring(parentAttachmentIndex))
				-- print(parentAttachmentIndex .. ": (" .. tostring( parent:GetAttachment( parentAttachmentIndex ).Pos ) .. ") [" .. tostring( parent:GetAttachment( parentAttachmentIndex ).Ang ) .. "]")
				
				local attachmentData = parent:GetAttachment( parentAttachmentIndex )
				
				-- local pos, ang = WorldToLocal( attachmentData.Pos, attachmentData.Ang, ent:GetPos(), ent:GetAngles() )
				-- local lpos, lang = LocalToWorld( Vector(-2.7,0,0), Angle(), pos, ang )
				local lpos, lang = LocalToWorld( Vector(-2.7,0,0), Angle(), WorldToLocal( attachmentData.Pos, attachmentData.Ang, ent:GetPos(), ent:GetAngles() ) )
				-- local attachmentLocalPos = ent:WorldToLocal( attachmentData.Pos )
				-- local attachmentLocalAng = ent:WorldToLocalAngles( attachmentData.Ang )--[[@as Angle]]
				-- attachmentLocalAng.r = attachmentLocalAng.r * -1
				
				-- local parentBoneIndex = parent:LookupBone(wheelBones[i])
				-- local parentBonePos, parentBoneAng = parent:GetBonePosition( parentBoneIndex )
				-- print("parent pos: " .. tostring(parentBonePos) .. " parent ang: " .. tostring( parentBoneAng ) )
				-- local boneIndex = ent:LookupBone( extraBones[i] )
				
				ent:ManipulateBonePosition( boneIndex, lpos )
				-- local transformedAngle = Angle( lang.r * -1, lang.y, -lang.p ) 
				-- lang:RotateAroundAxis(lang:Right(), 0)
				ent:ManipulateBoneAngles( boneIndex, lang )

				-- ent:ManipulateBonePosition( boneIndex, Vector( 0, 0, -6 ) )
				-- print( "Bone: " .. extraBones[i] .. " is: " .. boneIndex )
			end
		end
	end
end
hook.Add( "Think", "Photon2.Testing:WheelTest", durangoWheelTest )


local mat = Material("sentry/props/nforce/top_c")
if (mat:IsError()) then error("bad material") end

local vec = mat:GetVector("$carfixenabled")
print(tostring(vec))
mat:SetVector("$carfixenabled", Vector(0.13,0.13,0.13))
-- hint:SetTexture("$basetexture", blurTexture)

function dynamicMaterialTest()
	local hint = Material( "photon/debug/sprite_hint" )
	Photon2.Render.RenderToMaterial("sprite_hint_test", hint, "$basetexture", GetRenderTarget("sprite_test", 256, 256 ), 
	function() 
		surface.SetDrawColor(255, 255, 255)
		surface.DrawRect(0, 0, 256, 256)
		surface.SetDrawColor(0, 0, 512)
		surface.DrawRect( 64, 64, 128, 128 )
	end, {}, function()
		local tex = Material( "photon/debug/sprite_hint" ):GetTexture( "$basetexture" )
		-- local texId = surface.GetTextureID( tex:GetName() )
		local blurTexture = Photon2.Render.GenerateBlurredTexture( tex, 8, 32 )
		hint:SetTexture("$basetexture", blurTexture)
	end)

	local BLENDFUNC_ADD 				= 0
	local BLENDFUNC_SUBTRACT 			= 1
	local BLENDFUNC_REVERSE_SUBTRACT 	= 2
	local BLENDFUNC_MIN 				= 3
	local BLENDFUNC_MAX 				= 4

	local BLEND_ZERO 					= 0
	local BLEND_ONE 					= 1
	local BLEND_DST_COLOR				= 2
	local BLEND_ONE_MINUS_DST_COLOR		= 3
	local BLEND_SRC_ALPHA				= 4
	local BLEND_ONE_MINUS_SRC_ALPHA		= 5
	local BLEND_DST_ALPHA				= 6
	local BLEND_ONE_MINUS_DST_ALPHA		= 7
	local BLEND_SRC_ALPHA_SATURATE		= 8
	local BLEND_SRC_COLOR				= 9
	local BLEND_ONE_MINUS_SRC_COLOR		= 10

	hook.Add( "HUDPaint", "PhotonTextureTest", function()
		surface.SetMaterial(hint)
		render.OverrideAlphaWriteEnable( false, true )
		render.OverrideBlend( true, BLEND_ONE, BLEND_ONE, BLENDFUNC_MIN )
		-- render.OverrideBlend( true, BLEND_SRC_COLOR, BLEND_DST_COLOR, BLENDFUNC_MIN )
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.DrawTexturedRect( 128, 128, 256, 256 )
		render.OverrideBlend( false )
		render.OverrideAlphaWriteEnable( false, false )
	end)

	hook.Remove( "HUDPaint", "PhotonTextureTest")
end

local function meshtest()
	if SERVER then return end
	local targ = ents.FindByClass("prop_vehicle_jeep")[1]
	targ:SetSubMaterial( 17, "photon/common/blank" )
	targ:SetSubMaterial( 19, "photon/common/blank" )
	-- PrintTable( util.GetModelMeshes( targ:GetModel() ) )
	-- local meshes = {}
	-- for i=1, 10 do
	-- 	meshes[i] = Photon2.Util.GetModelMesh( targ:GetModel(), "sentry/20fpiu_new/tail_r", i )
	-- end
	local meshL = Photon2.Util.GetModelMesh( targ:GetModel(), "sentry/20fpiu_new/tail_l", 8 )
	local meshR = Photon2.Util.GetModelMesh( targ:GetModel(), "sentry/20fpiu_new/tail_r", 8 )
	-- local mesh = Photon2.Util.GetModelMesh( targ:GetModel(), "sentry/20fpiu_new/tail_r", 1 )
	local matrix = Matrix()
	-- mesh:BuildFromTriangles( mesh.triangles )
	local mat = Material("photon/common/glow")
	mat:SetInt("$additive", 1)
	mat:SetVector("$color", Vector(255, 0.2, 0))
	-- mat:SetVector("$color", Vector(1, 0.0013, 0))
	-- mat:SetVector("$color2", Vector(255, 255, 255))
	mat:SetFloat("$alpha", 0.6)
	mat:Recompute()
	hook.Add("PostDrawTranslucentRenderables", "Photon2:Test", function(a, b, c)
		if (a or b or c) then return end
		if ( not targ ) then return end
		-- if ( not  ) then return end
		matrix:SetTranslation( targ:GetPos() )
		matrix:SetAngles( targ:GetAngles() )
		matrix:Rotate(Angle(0,90,0))
		-- matrix:SetScale(Vector(4,4,4))
		cam.Start3D()
			cam.PushModelMatrix( matrix, false )
			-- mesh:Draw()
				render.SetMaterial( mat )
				-- for i=1, 10 do
				-- 	meshes[i]:Draw()
				-- end
				meshL:Draw()
				meshR:Draw()
				-- meshes[8]:Draw()
			cam.PopModelMatrix()
		cam.End3D()
	end)
	hook.Remove("PostDrawTranslucentRenderables", "Photon2:Test")
end

-- print(1.1%1 == 0)

-- meshtest()
-- hook.Remove("PostDrawEffects", "Photon2:Test")


local function buildMaterial( name )
	return CreateMaterial( name, "VertexLitGeneric", {
		["$basetexture"] = Material("photon/whi_16px.png"):GetTexture("$basetexture"):GetName(),
	})
end

local function subMaterialTest()
	if CLIENT then
		local matName = "testOverrideMat3"
		local mat = Material("!" .. tostring(matName))
		if ( mat:IsError() ) then 
			print("building material")
			mat = buildMaterial( matName ) 
		end
	
		mat:SetInt( "$additive", 0 )
		mat:SetInt( "$vertexalpha", 0 )
		mat:SetInt( "$vertexcolor", 0 )
		mat:SetInt( "$nocull", 1 )
		mat:SetInt( "$translucent", 1 )
		mat:SetVector( "$color2", Vector(255, 255, 255))
		mat:Recompute()
	
		local targ = ents.FindByClass("prop_vehicle_jeep")[1]
		targ:SetSubMaterial( 17, "!" .. tostring(matName))
		-- LocalPlayer():GetEyeTrace().Entity
		-- print(tostring(targ))
	end
end

-- subMaterialTest()



--[[
	Performance notes:

	- Using integer keys when declaring a table does NOT make it an array
	- Table integer keys are slower to retrieve than strings
	- Actual array lookups are only as fast as table string lookups

	- Function overhead made test ~25% slower (needs more evaluation)

	- Table key string length has no performance impact
	- Local table look-up is just ~2% slower than a local variable

	- Metatable lookups seem to be ~20-30% slower than direct access
		- Consolidating the metatable properties seems effective
]]

if SERVER then return end

local SysTime = SysTime

local function tableVsLocal()
	local start = SysTime()
	
	local x = {
		["abc"] = "abc"
	}
	local abc = "abc"

	local tblStart = SysTime()
	for i=1, 1000000 do 
		local val = "-" .. x.abc
	end
	local tblTime = SysTime() - tblStart

	local locStart = SysTime()
	for i=1, 1000000 do 
		local val = "-" .. abc
	end
	local locTime = SysTime() - locStart

	print("Table: " .. tostring(tblTime))
	print("Local: " .. tostring(locTime))
	print("Local is: " .. tostring((1 - (locTime/tblTime))*100) .. "% faster.")

end

-- tableVsLocal()

local function colorMapParseTesting()
	local block = "[R/W]"
	block = string.sub( block, 2, string.len(block) - 1 )
	print( block )
end


-- colorMapParseTesting()

local function metaTableBenchmark()
	local start = SysTime()
	local mt = {
		x = "from metatable"
	}

	local child = {}
	setmetatable( child, { __index = mt } )

	local grandchild = {}
	setmetatable( grandchild, { __index = child })
	
	-- grandchild.x = grandchild.x

	print("grandchild.x: " .. tostring(grandchild.x))


	
	
	start = SysTime()
	for i=1, 100000 do
		local val =  "x" .. mt.x
		-- local val = grandchild.x
		-- uselessFunction()
		
	end
	local nmTime = SysTime() - start
	
	start = SysTime()
	for i=1, 100000 do
		-- local val = grandchild.x
		-- local y = val
		-- local z = y
		local val = "x" .. grandchild.x
		-- uselessFunction()
	end
	local mtTime = SysTime() - start

	print("Normal Time: " .. tostring(nmTime))
	print("MetaTable Time: " .. tostring(mtTime))
	print("Normal time is: " .. tostring((1 - (nmTime/mtTime))*100) .. "% faster.")
end
-- metaTableBenchmark()


local function keyAccessBenchmark()
	local arr = {
		true, true
		-- "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	}
	arr[1] = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

	local tab = {
		[1] = "ABCDEFGHIJKLMNOPQRSTUVWXYZ",
		["ABCDEFGHIJKLMNOPQRSTUVWXYZ"] = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	}

	local function access( key )
		return tab[key]
	end
	

	local start = SysTime()
	for i=1, 10000 do
		local val = "-" .. access( 1 )
		-- local val = "-" .. arr[1]
		-- local val = string.format("-%s", tab[1])

	end
	local arrTime = SysTime() - start
	print("INT Time: " .. tostring(arrTime))

	start = SysTime()
	for i=1, 10000 do
		-- local val = string.format("-%s", tab["1"])
		-- local val = "-" .. tab.ABCDEFGHIJKLMNOPQRSTUVWXYZ
		-- local val = "-" .. tab["ABCDEFGHIJKLMNOPQRSTUVWXYZ"]
		local val = "-" .. access("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
	end
	local nrmTime = SysTime() - start
	print("STR Time: " .. tostring(nrmTime))

	-- print("Normal time is: " .. tostring(1 - (nrmTime/mtTime)) .. "% faster.")
end



--[[
	Function overhead:
	INT Time: 0.00027810000028694
	STR Time: 0.00024860000121407
	
	Direct access:
	INT Time: 0.00025180000375258
	STR Time: 0.00020709999807877
]]


-- keyAccessBenchmark()

if true then return end
if not exmeta then return end

print("misc_testing.lua")

exmeta.LoadTable("TableA", nil, {
	Vector1 = Vector(1, 1, 1),
	GetVector1 = function(self)
		return self.Vector1
	end,
}, true)

exmeta.LoadTable("TableB", "TableA", {
	Vector2 = Vector(2, 2, 2)
}, true)

exmeta.LoadTable("TableC", "TableB", {
	Vector3 = Vector(3, 3, 3)
}, true)

local tableC = exmeta.SetMetaTable({}, "TableC")

tableC.Vector1 = Vector(1, 0, 0)
-- print(tableC:GetVector1())
-- print(tableC.Vector3)
-- tableC.Vector1 = nil
-- print(tableC.Vector1)

-- tableB.Vector1 = nil

-- local rootPath = "photon-v2/library/components/"
-- local path = "schmal/component.lua"
-- local ext = "." .. string.GetExtensionFromFilename(path)
-- if (string.StartsWith(path, rootPath)) then
-- 	local startAt = string.len(rootPath) + 1
-- 	local endAt = string.len(rootPath) - startAt - (string.len(ext))
-- 	path = string.sub(path, startAt, endAt)
-- end
-- print("path: " .. path)

-- local fileName = string.GetFileFromFilename("folder/component.lua")

-- local name = string.sub(string.GetPathFromFilename(fileName))

-- local files, folders = file.Find("photon-v2/library/components/*.lua", "LUA")
-- PrintTable(files)

local dependencyTest = {
	["level_1"] = false,
	["level_2"] = false,
	["level_3"] = false,
	["level_1a"] = "level_1",
	["level_1aa"] = "level_1a",
	["level_1aaa"] = "level_1aa",
	["level_1aaaa"] = "level_1aaa",
	["level_3a"] = "level_3",

	-- { "level_1a", "level_1" },
	-- { "level_1aa", "level_1a"},
	-- { "level_1aaa", "level_1aa"},
	-- { "level_1aaaa", "level_1aaa"},
	-- { "level_3a", "level_3"},
}

-- psuedo code
-- recurse every entry until its parent is loaded
-- while true do
-- if not index[comp.base] exists
-- 	continue
-- if baseclass, add to existing
local expected = {
	level_1 = {
		level_1a = {
			level_1aa = {
				level_1aaa = {
					level_aaaa = true
				}
			}
		}
	}
}

local function buildDependencies( tbl )
	local inpt = table.Copy( tbl )

	local result = {}
	local pending = {}
	local searching = true

	-- load top-level (merge this later)
	-- TODO: treat top-level and resolved as the same
	for _, meta in pairs( inpt ) do
		if not (meta[1]) then
			table.insert( result, meta[1] )
			table.RemoveByValue( inpt, meta[1] )
		end
	end

	local count = 1

	while (not table.IsEmpty(inpt)) do
		for _, meta in pairs( inpt ) do
			if (table.HasValue(inpt, meta[1])) then
				Photon2.Debug.Print("metatable found?")
				table.insert( result, meta[1] )
				table.RemoveByValue( inpt, meta[1] )
			end
		end
		count = count + 1
		if (count > 500) then 
			print("aborting dependency build")
			break 
		end
	end
	return result
end

--PrintTable(buildDependencies(dependencyTest))