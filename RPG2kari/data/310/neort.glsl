// Ç±ÇøÇÁÇ™ÉIÉäÉWÉiÉãÇ≈Ç∑ÅB
// ÅyçÏé“ÅzFMS_CatÇ≥ÇÒ
// ÅyçÏïiñºÅzSakura
// https://neort.io/art/bim2lss3p9f9psc9oar0

/**
 * Sakura - FMS_Cat
 * Original: https://www.shadertoy.com/view/Xt23Dz
 * MIT License
 *
 * Refactored the codebase a bit for NEORT.
 * TODO: PBR, optimization, comments
 */

precision highp float;

#define PI 3.14159265
#define TAU 6.28318531

#define saturate(i) clamp(i,0.,1.)

#define MARCH_ITER 64
#define MARCH_FAR 1E2
#define MARCH_EPSILON 1E-4
#define MARCH_MULT 0.5

#define MAT_NULL -1.
#define MAT_ANTHER 0.
#define MAT_FILAMENT 1.
#define MAT_PISTIL 2.
#define MAT_PETAL 3.
#define MAT_CALYX 4.
#define MAT_TREE 5.

uniform vec2 resolution;
uniform float time;
uniform vec2 mouse;

float hash( vec2 v )
{
	return fract( sin( dot( v, vec2( 89.44, 19.36 ) ) ) * 22189.22 );
}

float iHash( vec2 v, vec2 r )
{
	float h00 = hash( vec2( floor( v * r + vec2( 0.0, 0.0 ) ) / r ) );
	float h10 = hash( vec2( floor( v * r + vec2( 1.0, 0.0 ) ) / r ) );
	float h01 = hash( vec2( floor( v * r + vec2( 0.0, 1.0 ) ) / r ) );
	float h11 = hash( vec2( floor( v * r + vec2( 1.0, 1.0 ) ) / r ) );
	vec2 ip = vec2( smoothstep( vec2( 0.0 ), vec2( 1.0 ), mod( v * r, 1.0 ) ) );
	return mix(
		mix( h00, h10, ip.x ),
		mix( h01, h11, ip.x ),
		ip.y
	);
}

float noise( vec2 v )
{
	float sum = 0.0;
	float p = 1.0;
	for ( int i = 1; i < 6; i ++ )
	{
		p *= 2.0;
		sum += iHash( v + vec2( i ), vec2( 2.0 * p ) ) / p;
	}
	return sum;
}

mat2 rotate( float t )
{
	return mat2( cos( t ), -sin( t ), sin( t ), cos( t ) );
}

float pole( vec3 p, float r, float l )
{
	vec2 d = abs( vec2( length( p.xz ), p.y ) ) - vec2( r, l );
	return min( max( d.x, d.y ), 0. ) + length( max( d, 0. ) );
}

float pole( vec3 p, float r )
{
	return length( p.xz ) - r;
}

float smin( float a, float b, float k )
{
	float h = saturate( 0.5 + 0.5 * ( b - a ) / k );
	return mix( b, a, h ) - k * h * ( 1.0 - h );
}

vec2 stamen( vec3 p )
{
	vec2 dist = vec2( MARCH_FAR );
	vec2 distC = dist;
	float phase = floor( atan( p.z, p.x ) / TAU * 13.0 - 1.0 );
	vec3 offset = vec3( 0.04, 0.0, 0.04 ) * ( 1.0 + 0.1 * sin( time ) );
	offset.xz *= 0.6 + 0.6 * hash( vec2( phase * 1.9873, 821.122 ) );
	vec3 pt = p - vec3( 0.0, 0.01, 0.0 );
	pt.xz = rotate( floor( phase ) * TAU / 13.0 ) * pt.xz;
	vec3 sin200pt = sin( 200.0 * pt );
	vec3 pa = pt + 0.003 * ( sin200pt.x * sin200pt.y * sin200pt.z ) - offset - vec3( 0.0, 0.1, 0.0 );
	distC = vec2( length( pa ) - .005, MAT_ANTHER );
	if ( distC.x < dist.x ) { dist = distC; }
	pa = pt + cos( 20.0 * pt.y ) * vec3( 0.003, 0.0, 0.003 ) - offset * ( 0.5 + 0.5 * sin( pt.y / 0.2 * PI ) );
	distC = vec2( pole( pa - vec3( 0.0, 0.025, 0.0 ), 0.001 * sin( pa.y / 0.1 * PI ), 0.075 ), MAT_FILAMENT );
	if ( distC.x < dist.x ) { dist = distC; }
	return dist;
}

vec2 pistil( vec3 p )
{
	vec3 pt = p;
	float pistil = pole( pt - vec3( 0.0, 0.01, 0.0 ) + 0.001 * sin( 50.0 * pt.y ) * vec3( 1.0, 0.0, 1.0 ), 0.004, 0.06 );
	pistil = smin( pistil, length( vec2( length( pt.xz ) - 0.007, pt.y - 0.07 ) ) - 0.001, 0.01 );
	return vec2( pistil, MAT_PISTIL );
}

vec2 petals( vec3 p )
{
	float dist = MARCH_FAR;
	vec3 pt = p;
	pt.y -= 0.2 * pow( length( pt.xz ), 0.5 ) - 0.055;
	pt.xz = rotate( floor( atan( pt.z, pt.x ) / TAU * 5.0 - 2.0 ) * TAU / 5.0 ) * pt.xz;
	pt.xy = rotate( -0.3 + 0.1 * sin( time ) ) * pt.xy;
	pt.x += 0.14;
	pt.x *= 1.4 * ( 1.0 - 0.3 * pow( abs( sin( atan( pt.z, pt.x ) ) ), 0.1 ) );
	vec3 sin20p = sin( 20.0 * p );
	pt += 0.018 * ( sin20p.x * sin20p.y * sin20p.z );
	dist = min( dist, pole( pt, 0.1, 0.001 ) );
	return vec2( dist, MAT_PETAL + saturate( length( p.xz ) ) );
}

vec2 calyx( vec3 p )
{
	float dist = MARCH_FAR;

	vec3 pt = p;
	pt.y -= pow( length( pt.xz ), 0.2 ) * 0.2 - 0.13;
	pt.xz = rotate( floor( atan( pt.z, pt.x ) / TAU * 5.0 - 2.0 ) * TAU / 5.0 ) * pt.xz;
	pt.xy = rotate( -0.3 ) * pt.xy;

	vec3 ptemp = pt;
	vec3 sin20p = sin( 20.0 * p );
	float sin20pProd = sin20p.x * sin20p.y * sin20p.z;
	pt.x += 0.04;
	pt.x *= max( pow( abs( sin( atan( pt.z, pt.x ) ) ), 0.1 ), 6.6 );
	pt += 0.018 * ( sin20pProd );
	dist = smin( dist, pole( pt, 0.03, 0.001 ), 0.02 );

	pt = ptemp + vec3( 0.0, 0.15, 0.0 );
	pt.x -= 0.02;
	pt.x *= max( pow( abs( sin( atan( pt.z, pt.x ) ) ), 0.1 ), 6.6 );
	pt += 0.018 * ( sin20pProd );
	dist = smin( dist, pole( pt, 0.01, 0.001 ), 0.02 );

	dist = smin( dist, pole( p + 0.004 * sin20p.y * vec3( 1.0, 0.0, 1.0 ) + vec3( 0.0, 0.15, 0.0 ), 0.01, 0.09 ), 0.02 );

	return vec2( dist, MAT_CALYX + saturate( -p.y - 0.05 ) );
}

vec2 blossom( vec3 p )
{
	vec2 dist = vec2( MARCH_FAR );
	if ( length( p ) < 0.28 )
	{
		dist = stamen( p );
		vec2 distC = pistil( p );
		if ( distC.x < dist.x ) { dist = distC; }
		distC = petals( p );
		if ( distC.x < dist.x ) { dist = distC; }
		distC = calyx( p );
		if ( distC.x < dist.x ) { dist = distC; }
	}
	else
	{
		dist = vec2( length( p ) - 0.27, MAT_NULL );
	}
	return dist;
}

vec2 branch( vec3 p )
{
	vec2 dist = vec2( MARCH_FAR );
	vec3 pt = p;
	pt.xy = rotate( -1.0 ) * pt.xy;
	vec3 sin10pt = sin( 10.0 * pt );
	vec3 ptt = pt + 0.03 * sin10pt.x * sin10pt.y * sin10pt.z;
	dist = vec2( pole( ptt, 0.1 ), MAT_TREE );
	pt.zx = rotate( floor( 2.0 * pt.y + 0.5 ) * 0.7 - 0.5 ) * pt.zx;
	float theta = atan( pt.z, pt.x );
	if ( theta < 0.0 ) { pt.zx = rotate( PI ) * pt.zx; }
	pt.yz = rotate( PI / 2.0 ) * pt.yz;
	pt.y -= 0.3;
	pt.z = mod( pt.z + 0.25, 0.5 ) - 0.25;
	vec2 distC = blossom( pt );
	if ( distC.x < dist.x ) { dist = distC; }
	return dist;
}

vec2 scene( vec3 p )
{
	vec2 dist = branch( p );
	return dist;
}

vec3 sceneNormal( vec3 p )
{
	vec2 d = vec2( 0.0, MARCH_EPSILON );
	return normalize( vec3(
		scene( p + d.yxx ).x - scene( p - d.yxx ).x,
		scene( p + d.xyx ).x - scene( p - d.xyx ).x,
		scene( p + d.xxy ).x - scene( p - d.xxy ).x
	) );
}

vec4 draw( in vec2 coord )
{
	vec2 p = ( coord * 2.0 - resolution ) / resolution.x;
	
	vec3 camPos = vec3( .8, 0., 1. );
	vec3 camTar = 0.01 * sin( time * vec3( 0.72, 0.83, 0.37 ) ) - vec3( 0.2 * sin( 0.21 * time ), -0.2, 0.0 );
	vec3 camDir = normalize( camTar - camPos );
	vec3 camAir = vec3( 0.0, 1.0, 0.0 );
	vec3 camSid = normalize( cross( camDir, camAir ) );
	vec3 camTop = normalize( cross( camSid, camDir ) );
	
	vec3 rayDir = normalize( camSid * p.x + camTop * p.y + camDir );
	vec3 rayPos = camPos;
	float rayLen = 0.0;
	vec2 dist = vec2( 0.0, 0.0 );
	for( int i = 0; i < MARCH_ITER; i ++ )
	{
		dist = scene( rayPos ) * vec2( MARCH_MULT, 1.0 );
		rayLen += dist.x;
		rayPos = camPos + rayDir * rayLen;
		if ( dist.x < 2E-3 || 1E2 < rayLen ) { break; }
	}
	
	vec3 col = vec3( 0.0 );
	if( dist.x < 4E-3 )
	{ 
		vec3 ligPos = vec3( 0.0, 1.0, 11.0 );
		vec3 nor = normalize( sceneNormal( rayPos ) );
		float dif = saturate( dot( normalize( rayPos-ligPos ), -nor ) ) * 0.3;
		float amb = 0.7;
		float speDot = saturate( dot( normalize( normalize( rayPos - ligPos ) + normalize( rayPos - camPos ) ), -nor ) );
		float spe = 0.1 * saturate( pow( speDot, 10.0 ) );
		vec3 matCol = vec3( 0.0 );
		if ( floor( dist.y ) == MAT_NULL ) { amb = 1.0; matCol = vec3( 1.0 ); }
		else if ( floor( dist.y ) == MAT_ANTHER ) { matCol = vec3( 0.9, 0.9, 0.5 ); }
		else if ( floor( dist.y ) == MAT_FILAMENT ) { matCol = vec3( 0.9, 0.9, 0.8 ); }
		else if ( floor( dist.y ) == MAT_PISTIL ) { matCol = vec3( 0.8, 0.9, 0.6 ); }
		else if ( floor( dist.y ) == MAT_PETAL ) { matCol = vec3( 0.9, 0.4, 0.8 ) + vec3( 0.1, 0.6, 0.2 ) * ( 1.0 - exp( -fract( dist.y ) * 16.0 ) ); }
		else if ( floor( dist.y ) == MAT_CALYX ) { matCol = vec3( 0.7, 0.1, 0.3 ) + vec3( -0.4, 0.4, -0.4 ) * saturate( fract( dist.y ) * 8.0 ); }
		else if ( floor( dist.y ) == MAT_TREE ) {
			nor = normalize( nor + 2.0 * vec3(
				noise(vec2((rayPos.x+rayPos.z)*8.,rayPos.y*8.+27.1982))-.5,
				noise(vec2((rayPos.x+rayPos.z)*8.,rayPos.y*8.+28.1982))-.5,
				noise(vec2((rayPos.x+rayPos.z)*8.,rayPos.y*8.+29.1982))-.5
			) );
			dif = 0.6 * saturate( dot( normalize( rayPos-ligPos ), -nor ) );
			float speDot = saturate( dot( normalize( normalize( rayPos - ligPos ) + normalize( rayPos - camPos ) ), -nor ) );
			float spe = 0.1 * saturate( pow( speDot, 10.0 ) );
			matCol = vec3( 0.4, 0.3, 0.1 );
		}
	   	col = ( dif + amb ) * matCol + spe;
	}
	else
	{
		col = vec3( 0.5, 0.7, 0.9 );
		for( int i = 12; i < 39; i ++ )
		{
            float fi = float( i );
			vec2 pos = ( vec2( hash( vec2( fi, 198.33 ) ), hash( vec2( fi, 298.33 ) ) ) - 0.5 ) * resolution / resolution.x * 2.0;
			pos += vec2( sin( time * 0.2 * hash( vec2( fi, 19.233 ) ) ), sin( time * 0.2 * hash( vec2( fi, 29.233 ) ) ) ) * 0.01;
			col += 0.02 * vec3( 1.0, 0.7, 0.9 ) * saturate( 12.0 - length( p - pos ) * 50.0 );
		}
	}

	col -= 0.4 * length( p );

	return vec4( col, 1.0 );
}

void main()
{
    gl_FragColor = draw( gl_FragCoord.xy );
}
