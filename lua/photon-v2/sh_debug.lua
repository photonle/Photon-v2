Photon2.Debug = Photon2.Debug or {
	Output = {},
	PrintType = {
		WARN = true,
		ERROR = true
	},
	ServerLog = "photon_v2/sv_log.txt",
	ClientLog = "photon_v2/cl_log.txt"
}

if ( not Photon2.Debug.Initialized ) then
	file.Write( Photon2.Debug.ServerLog, "Start of SERVER log file [Photon " .. Photon2.Version .. "]\n\n" )
	file.Write( Photon2.Debug.ClientLog, "Start of CLIENT log file [Photon " .. Photon2.Version .. "]\n\n" )
	Photon2.Debug.Initialized = true
end

local red = Color(255, 72, 0)
local blu = Color(97, 160, 255)
local blk = Color(0, 0, 0)
local whi = Color(255, 255, 255)
local sv = Color(137, 222, 255)
local cl = Color(255, 222, 102)

file.CreateDir( "photon_v2" )

local shouldPrintLog, shouldChatErrors

if CLIENT then
	shouldPrintLog = CreateClientConVar( "ph2_enable_print_log", "0", true, false, "When enabled, Photon 2 log messages will be printed in the console." )
	shouldChatErrors = CreateClientConVar( "ph2_enable_chat_errors", "0", true, false, "When enabled, Photon 2 errors will display in chat (experimental)." )
end

function Photon2.Debug.Log( type, section, message )
	local time = os.date( "%H:%M:%S", os.time() )
	if ( Photon2.Debug.PrintType[type] ) then
		Photon2.Debug.Output[#Photon2.Debug.Output+1] = {
			Time = time,
			Type = type,
			Section = section,
			Message = message
		}
	end
	
	if ( CLIENT and shouldPrintLog:GetBool() ) then
		Photon2.Debug.PrintOnly( "[" .. section .. "]  " .. string.Replace( message, "\t", "" ) )
	end

	if ( CLIENT and shouldChatErrors:GetBool() ) then
		if ( Photon2.Debug.PrintType[type] ) then
			chat.AddText( whi, "[", red, "PHO", blu, "TON", whi, string.format("2] %s", string.Replace(message, "\t", "") ) )
		end
	end

	-- Blanks out "[INFO]" tag so non-normal tags stand out in the log file
	local typeLabel = "      "
	if ( type ~= "INFO" ) then typeLabel = "[" .. type .. "]" end
	
	if ( SERVER ) then
		file.Append( Photon2.Debug.ServerLog, string.format("%s %s (%s)  %s\n", time, typeLabel, section, message ) )
	else
		file.Append( Photon2.Debug.ClientLog, string.format("%s %s (%s)  %s\n", time, typeLabel, section, message ) )
	end
end

function Photon2.Debug.PrintOnly( text )
	local col = sv
	if CLIENT then col = cl end
	MsgC( col, "[", red, "PHO", blu, "TON", whi, "2", col, "] ", col, text .. "\n")
end

function Photon2.Debug.Print( text )
	-- Photon2.Debug.PrintOnly( text )
	Photon2.Debug.Log( "INFO", "PRINT", text )
end

function Photon2.Debug.Declare( section )
	return function( text, ... )
		Photon2.Debug.Info( section, text, ... )
	end,
	function( text, ... )
		Photon2.Debug.Warn( section, text, ... )
	end
end

function Photon2.Debug.Info( section, text, ... )
	if ( ... ) then
		text = string.format( text, ... )
	end
	Photon2.Debug.Log( "INFO", section, text )
end

-- Prints the string with the [PHOTON2] identifier while also calling
-- string.format( x ) on the supplied text.
function Photon2.Debug.PrintF( text, ... )
	Photon2.Debug.Print(string.format(text, ...))
end

function Photon2.Debug.PrintD( type, text, ... )
	Photon2.Debug.Print( "[" .. tostring( type ) .. "] " .. string.format( text, ... ) )
end

local warnings = {}

function Photon2.Debug.Warn( section, text, ... )
	if ( ... ) then
		text = string.format( text, ... )
	end
	Photon2.Debug.Log( "WARN", section, text )
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