#include <iostream>

#include "Dummy.h"

using namespace std;

int main() {
  cout << "Main calling Dummy.Do() ... " << endl;
  Dummy dummy;
  dummy.Do();
  return 0;
}
