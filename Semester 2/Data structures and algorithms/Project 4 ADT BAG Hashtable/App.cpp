#include "Bag.h"
#include "ShortTest.h"
#include "ExtendedTest.h"
#include <iostream>

using namespace std;

int main() {

	testAll();
	cout << "<< SHORT TESTS SUCCESS >>" << endl;
	testAllExtended();

	cout << "<< ALL TESTS SUCCESS >>" << endl;
}