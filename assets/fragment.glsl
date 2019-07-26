/*
Title: Basic Lighting
File Name: fragment.glsl
Copyright ? 2016
Author: David Erbelding
Written under the supervision of David I. Schwartz, Ph.D., and
supported by a professional development seed grant from the B. Thomas
Golisano College of Computing & Information Sciences
(https://www.rit.edu/gccis) at the Rochester Institute of Technology.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or (at
your option) any later version.

This program is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/


#version 400 core

in vec3 normal;
in vec2 uv;
uniform sampler2D tex;

void main(void)
{
	// LIGHTS: in practice, these values would be passed to the shader from the cpu, but we're hardcoding them for simplicity.

	// Ambient light is just a light that applies to everything.
	// The color can be anything, and will be what you see after all other lighting effects.
	vec4 ambientLight = vec4(.1, .1, .2, 1);

	// A directional light has a color and a direction.
	vec4 lightColor = vec4(1, 1, .5, 1);
	// The direction of the light is used with the normal to calculate how much light is affecting a given surface.
	vec3 lightDir = vec3(-1, -1, -2);






	// The dot product of two normalized vectors gives the cosine of the angle between them.
	// What does that mean?
	// The cosine of an angle is 1 when the angle is 0, and moves to -1 as the angle continues to 180.
	// The result of our dot product here will be 1 when the light direction matches the surface direction,
	// and fall off as the angle gets larger. We actually want the opposite of that: a high
	// value when the two directions are opposite, so we just reverse the result.
	float ndotl = -dot(normalize(lightDir), normalize(normal)); 

	// We also don't want negative numbers (afaik negative light doesn't exist in real life)
	// Just clamp our light value between 0 and 1.
	ndotl = clamp(ndotl, 0, 1);

	// Here we scale our light color by the value of the light on the surface.
	vec4 lightValue = lightColor * ndotl;
	// Add the ambient light to the light value. (This can put us over 1, so clamp it again)
	lightValue = clamp(lightValue + ambientLight, 0, 1);

	// finally, sample from the texuture and multiply the value we get by the color of the light.
	gl_FragColor = texture(tex, uv) * lightValue;
}