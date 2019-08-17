#include <emscripten.h>
#include <iostream>
#include <string>
#include <stdlib.h>
#include "picosha2.h"

#define WASM_EXPORT __attribute__((visibility("default"))) extern "C"
using namespace std;

WASM_EXPORT EMSCRIPTEN_KEEPALIVE int add(int x, int y) {
  return x + y;
}

EMSCRIPTEN_KEEPALIVE string RandomString(int len) {
   string str = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
   string newstr;
   int pos;
   while(newstr.size() != len) {
    pos = ((rand() % (str.size() - 1)));
    newstr += str.substr(pos,1);
   }
   return newstr;
}

WASM_EXPORT EMSCRIPTEN_KEEPALIVE int hash(int n) {
	for (int i = 0; i < n; i++) {
		const std::string& src = RandomString(20);
		picosha2::hash256_hex_string(src);
	}

    return 1;
}
