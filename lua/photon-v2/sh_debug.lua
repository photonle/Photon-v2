Photon2.Debug = {}

local red = Color(255, 72, 0)
local blu = Color(97, 160, 255)
local blk = Color(0, 0, 0)
local whi = Color(255, 255, 255)
local sv = Color(137, 222, 255)
local cl = Color(255, 222, 102)

function Photon2.Debug.Print( text )
	local col = sv
	if CLIENT then col = cl end
	MsgC( col, "[", red, "PHO", blu, "TON", whi, "2", col, "] ", col, text .. "\n")
end


-- Prints the string with the [PHOTON2] identifier while also calling
-- string.format( x ) on the supplied text.
function Photon2.Debug.PrintF( text, ... )
	Photon2.Debug.Print(string.format(text, ...))
end

local printf = Photon2.Debug.PrintF

if (CLIENT) then
	concommand.Add("ph2_selection", function( ply, cmd, args)
		local targ = ply:GetEyeTrace().Entity
		if (not IsValid(targ)) then 
			print("Target is an invalid entity.")
			return 
		end
		local controller
		local controllers = ents.FindByClass("photon_controller")
		PrintTable( controllers )
		for i=1, #controllers do
			if ( targ == controllers[i]:GetParent() ) then
				controller = controllers[i]
			else
				printf("Controller [%s] parent did not match target [%s].", tostring(controllers[i]), tostring(targ))
			end
		end
		if ( not IsValid( controller) ) then 
			printf("Controller entity [%s] is not valid.", controller)
			return 
		end
		Photon2.cl_Network.SetControllerSelection( controller, { { tonumber(args[1]), tonumber(args[2]) } } )
	end)

	concommand.Add( "ph2_debug_dump_entity_info", function( ply, cmd, args )
		local targ = ply:GetEyeTrace().Entity --[[@as Entity]]
		if (not IsValid(targ)) then 
			printf("Target is an invalid entity.")
			return 
		end
		printf( "Model: %s", tostring( targ:GetModel() ) )
		printf( "Class: %s", tostring( targ:GetClass() ) )
		if ( IsValid( targ:GetParent() ) ) then
			printf( "Parent: [%s] (%s)", tostring( targ:GetParent():GetClass() ), tostring( targ:GetParent():GetModel() ) )
		end
		local parentString, currentEnt
		local searching = true
		while ( searching ) do
			searching = false
		end
	end)


end