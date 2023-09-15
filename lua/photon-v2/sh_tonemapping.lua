Photon2.ToneMapping = {}

function Photon2.ToneMapping.Reinhard( color )
	return {
		r = color.r / ( 1 + color.r ),
		g = color.g / ( 1 + color.g ),
		b = color.b / ( 1 + color.b ),
		a = color.a
	}
end

function Photon2.ToneMapping.Filmic( color )
	local function convert( x )
		return (x*(x+0.15)*(x+0.50))/(x*(x+0.10)+0.20*x*x)
	end
	return {
		r = convert( color.r ),
		g = convert( color.g ),
		b = convert( color.b ),
		a = color.a
	}
end