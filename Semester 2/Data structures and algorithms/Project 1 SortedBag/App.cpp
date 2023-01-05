#include "SortedBag.h"
#include "SortedBagIterator.h"
#include <iostream>
#include "ShortTest.h"
#include "ExtendedTest.h"

using namespace std;

int main() {
	testAll();
	testAllExtended();
	cout << ">>> TESTS HAVE RUNNED. NOTHING WRONG FOUND <<<" << endl;
	system("|| PAUSED ||");
}
