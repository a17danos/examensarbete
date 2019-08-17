#include <emscripten.h>
#define WASM_EXPORT __attribute__((visibility("default"))) extern "C"

EMSCRIPTEN_KEEPALIVE WASM_EXPORT int add(int x, int y) {
	return x + y;
}
