Documentation Author: Niko Procopi 2019

This tutorial was designed for Visual Studio 2017 / 2019
If the solution does not compile, retarget the solution
to a different version of the Windows SDK. If you do not
have any version of the Windows SDK, it can be installed
from the Visual Studio Installer Tool

Welcome to the Basic Lighting Tutorial!
Prerequesites: Textured Cube

This tutorial is mainly focused at the fragment shader.
In large games, lights can be dynamically changed at
any given moment (size, brightness, color, etc). For
this simple example, we will give fixed values in the
fragment shader:

vec4 ambientLight = vec4(.1, .1, .2, 1);
vec4 lightColor = vec4(1, 1, .5, 1);
vec3 lightDir = vec3(-1, -1, -2);

Ambient light is calculated on every pixel, no matter what.
Ambient light is the darkest a pixel can be, if no light
is shining on the pixel. Just like how in GTA V, at night,
if no light shines on a pixel, the pixel is not pitch-black.

Directionl light is applied to surfaces that face the light
lightColor is the color of the light shining on the object
lightDir is the direction that the light is coming from.
This light does not come from any given point, it is simply
a direction. Directional light is usually used for sunlight

We know the direction that a surface faces, because
that is the normal, and we know the direction the light is
coming from, so we compare those two directions. If they are 
the same, then the surface is facing the light, and the pixel
should be bright. Imagine the cosine of the angle between 
the directions. If the directions are the same, no difference,
then the angle between them is zero, cos(0) = 1. If the surface
faces 90 degrees away from the light, the surface will be dark,
cos(90) = 0

In this tutorial, we dont use cosine, we use dot product, which
is basically the same thing. nDotL = dot(normal, lightDir), is
the angle between the light direction and the surface direction.
nDotL will determine the brightness of the pixel

Next, we clamp nDotL, so that we do not have a negative amount of light,
cos(180) = -1, and nDotL can be -1, so we clamp from 0 to 1
ndotl = clamp(ndotl, 0, 1);

Next, we add ambient light, and clamp that too
lightValue = clamp(lightValue + ambientLight, 0, 1);

Finally, the color of the pixel is calculated by multiplying light
value and the texture color. This is because a perfectly red surface (RGB 1,0,0)
can't reflect perfectly green light (RGB 0,1,0).
gl_FragColor = texture(tex, uv) * lightValue;

Congratulations, you're done
