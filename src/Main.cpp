#include <fmt/format.h>

#include "Dummy.h"

using namespace std;

int main() {
  fmt::print("Main calling Dummy.Do() ... \n");
  Dummy dummy;
  dummy.Do();
  return 0;
}
