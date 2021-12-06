#include <fmt/format.h>

#include "dummy.h"

using namespace std;

int main() {
  fmt::print("main calling dummy.do_somthing() ... \n");
  dummy dummy;
  dummy.do_somthing();
  return 0;
}
