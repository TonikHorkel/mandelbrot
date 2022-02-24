#version 460 core

precision highp float;

in vec2 coordinates;
out vec4 color;

#define MODE 2

#if MODE == 0 || MODE == 1
    #define ITERATION_TYPE float
    #define ITERATION_START 0.
    #define ITERATION_STEP 1.
    #define ITERATIONS 256.
#elif MODE == 2
    #define ITERATION_TYPE int
    #define ITERATION_START 0
    #define ITERATION_STEP 1
    #define ITERATIONS 256
#endif

#if MODE == 1 || MODE == 2
    // Stolen from https://github.com/donqustix/MandelbrotGL/blob/master/res/mandelbrot_shader.fs.
    const vec3 color_map[17] = {
        {0.26, 0.18, 0.06},
        {0.10, 0.03, 00.1},
        {0.04, 0.00, 0.18},
        {0.02, 0.02, 0.29},
        {0.00, 0.03, 0.39},
        {0.05, 0.17, 0.54},
        {0.09, 0.32, 0.69},
        {0.22, 0.49, 0.82},
        {0.52, 0.71, 0.90},
        {0.82, 0.92, 0.97},
        {0.94, 0.91, 0.75},
        {0.97, 0.79, 0.37},
        {0.00, 0.67, 0.00},
        {0.80, 0.50, 0.00},
        {0.60, 0.34, 0.00},
        {0.41, 0.20, 0.01},
        {0.00, 0.00, 0.00},
    };
#endif

void main() {
    vec2 z = vec2(0.);
    ITERATION_TYPE iteration = ITERATION_START;
    for(; iteration < ITERATIONS; iteration += ITERATION_STEP) {
        z = vec2(z.x * z.x - z.y * z.y, z.x * z.y * 2.) + coordinates;
        if(z.x * z.x + z.y * z.y > 4.) break;
    }
    #if MODE == 0
        color = vec4(vec3(sqrt(iteration / ITERATIONS)), 1.);
    #elif MODE == 1
        color = vec4(color_map[int(sqrt(iteration / ITERATIONS) * 16.)], 1.);
    #elif MODE == 2
        color = vec4(color_map[iteration % 17], 1.);
    #endif
}