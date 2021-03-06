#version 460 core

precision highp float;

out vec2 coordinates;

uniform vec2 offset;
uniform float zoom;

const vec2 vertices[4] = {
    {-1., -1.},
    {-1., +1.},
    {+1., -1.},
    {+1., +1.},
};

void main() {
    gl_Position = vec4(vertices[gl_VertexID], 0., 1.);
    coordinates = (vertices[gl_VertexID] + offset * zoom) / zoom;
}