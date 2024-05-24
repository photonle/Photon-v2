CreateClientConVar( "ph2_debug_light_overlay", "0", true )
CreateClientConVar( "ph2_draw_light2d", "1", false )
CreateClientConVar( "ph2_display_input", "0", true )
CreateClientConVar( "ph2_debug_perf_overlay", "0", true, false, "Enables Photon 2 performance info on HUD.")

CreateClientConVar( "ph2_hud_enabled", "1", true, false, "If the Photon 2 HUD should be enabled." )
CreateClientConVar( "ph2_hud_anchor", "bottom_right", true, false, "Which corner the HUD should be positioned from." )
CreateClientConVar( "ph2_hud_offset_x", "1", true, false, "Inward horizontal offset of where the HUD should draw." )
CreateClientConVar( "ph2_hud_offset_y", "1", true, false, "Inward vertical offset of where the HUD should draw." )
CreateClientConVar( "ph2_hud_draggable", "0", true, false, "If the HUD panel can be dragged around with the cursor." )

CreateClientConVar( "ph2_enable_projectedtextures_mp", "0", true, true, "If projected texture lights should be rendered in multiplayer. Disabling will increase performance." )
CreateClientConVar( "ph2_enable_subtractive_sprites", "1", true, false, "If subtractive sprite effects should be enabled (2D lighting)." )
CreateClientConVar( "ph2_enable_additive_sprites", "1", true, false, "If additive sprite effects should be enabled (2D lighting)." )

CreateClientConVar( "ph2_bloom_add_src_passes", "2", true, false, "Number of mesh source additive passes in bloom shader." )
CreateClientConVar( "ph2_bloom_add_outer_passes", "2", true, false, "Number of outer glow additive passes in bloom shader." )
CreateClientConVar( "ph2_bloom_add_inner_passes", "4", true, false, "Number of inner glow additive passes in bloom shader." )

CreateClientConVar( "ph2_bloom_outer_blur_passes", "1", true, false, "Number of outer blur passes in bloom shader." )
CreateClientConVar( "ph2_bloom_outer_blur_x", "5", true, false, "Outer blur X value in bloom shader." )
CreateClientConVar( "ph2_bloom_outer_blur_y", "5", true, false, "Outer blur Y value in bloom shader." )

CreateClientConVar( "ph2_bloom_inner_blur_passes", "1", true, false, "Number of inner blur passes in bloom shader." )
CreateClientConVar( "ph2_bloom_inner_blur_x", "1", true, false, "Inner blur X value in bloom shader." )
CreateClientConVar( "ph2_bloom_inner_blur_y", "1", true, false, "Inner blur Y value in bloom shader." )