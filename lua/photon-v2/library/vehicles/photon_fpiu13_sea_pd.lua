if (Photon2.ReloadVehicleFile()) then return end
local VEHICLE = Photon2.LibraryVehicle()

VEHICLE.Title 		= "Seattle Police Department - Ford Police Utility (2013) "
VEHICLE.Vehicle		= "13fpiu_sgm"
VEHICLE.Category 	= "Photon 2"
VEHICLE.Author		= "Schmal"

VEHICLE.WorkshopRequirements = {
	[2798400972] = "2013 Ford Police Interceptor Utility"
}

VEHICLE.Siren = { [1] = "motorola_spectra" }

VEHICLE.Equipment = {
	{
		Category = "Pushbar",
		Options = {
			{
				Option = "Setina - IMPAXX",
				Components = {
					{
						Component = "photon_setina_fpiu13",
						Position = Vector( 0, 121.3, 29.5 ),
						Angles = Angle( 0, 180, 0 ),
						Scale = 0.98,
						BodyGroups = {
							["Wrap"] = "wrap"
						}
					}
				},
				BodyGroups = {
					{ BodyGroup = "pushbar", Value = 0 }
				}
			},
			{
				Option = "No Lights",
				BodyGroups = {
					{ BodyGroup = "pushbar", Value = 1 }
				}
			},
		}
	},
	{
		Category = "Turn Signal",
		Options = {
			{
				Option = "Amber",
				BodyGroups = {
					{ BodyGroup = "turnsig", Value = 1 }
				}
			},
		}
	},
	{
		Category = "Lightbar",
		Options = {
			{
				Option = "Federal Signal Legend",
				Components = {
					{
						Component = "photon_fedsig_legend",
						Position = Vector( 0, -14, 85.1 ),
						Angles = Angle( 1, 90, 0 ),
						Scale = 1,
						Bones = {
							["foot_right"] = { Vector(1, 0, 0), Angle(0, 0, 0), 1 },
							["foot_left"] = { Vector(-1, 0, 0), Angle(0, 0, 0), 1 },
						},
					}
				}
			}
		}
	},
	{
		Category = "Mirror Lights",
		Options = {
			{
				Option = "Whelen Ion Surface",
				Components = {
					{
						Name = "@mirror_ion",
						Component = "photon_whe_ion_surface",
						Position = Vector( -50, 35.5, 57.4 ),
						Angles = Angle( 3, 27.9, 6.5 ),
						Scale = 0.8
					},
					{
						Inherit = "@mirror_ion",
						Position = Vector( 50, 35.5, 57.4 ),
						Angles = Angle( -3, -27.9, 6.5 ),
					}
				}
			},
		}
	},
	{
		Category = "Siren Speaker",
		Options = {
			{
				Option = "Federal Signal Dynamax",
				Components = {
					{
						Component = "siren_prototype",
						Position = Vector( 0, 121.3, 40 ),
						Angles = Angle( 0, 0, 0 ),
						Siren = 1
					}
				}
			},
		}
	},
	{
		Category = "Spotlights",
		Options = {
			{
				Option = "PAR46 LED",
				Components = {
					{
						Component = "photon_whe_par46_left",
						Position = Vector( -39, 38, 61 ),
						Angles = Angle( 0, 0, 0 ),
						Scale = 1.1,
					},
					{
						Component = "photon_whe_par46_right",
						Position = Vector( 39, 38, 61 ),
						Angles = Angle( 0, 0, 0 ),
						Scale = 1.1,
					}
				},
			},
		}
	},
}