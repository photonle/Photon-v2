CreateClientConVar( "ph2_debug_light_overlay", "0", true )
CreateClientConVar( "ph2_draw_light2d", "1", false )
CreateClientConVar( "ph2_display_input", "0", true )

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