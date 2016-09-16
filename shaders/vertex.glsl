/*
Title: Drawing a Cube
File Name: vertex.glsl
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

// Vertex attribute for position
layout(location = 0) in vec3 in_position;
layout(location = 1) in vec3 in_normal;
layout(location = 2) in vec2 in_uv;

// uniform will contain the world matrix.

uniform mat4 worldMatrix;
uniform mat4 cameraView;

out vec3 normal;
out vec2 uv;

void main(void)
{
	//transform the vector
	vec4 worldPosition = worldMatrix * vec4(in_position, 1);
	
	vec4 viewPosition = cameraView * worldPosition;

	// output the transformed vector
	gl_Position = viewPosition;

	// We have our normal in model space, but we need to get it in world space.
	// This can almost be accomplished by multiplying our normal by the world matrix, but not quite.
	// The important part of our vector is the direction, so we don't want to translate it.
	// As it turns out, the first 3x3 of a world matrix only contains rotation and scaling.
	// We just make a mat3 out of our mat4, and multiply to get the rotated normal.
	normal = mat3(worldMatrix) * in_normal;
	uv = in_uv;
}