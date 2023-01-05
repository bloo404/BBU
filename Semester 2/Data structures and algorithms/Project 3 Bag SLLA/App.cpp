#include "Bag.h"
#include "ShortTest.h"
#include "ExtendedTest.h"
#include <iostream>

using namespace std;

int main() {

    cout<<"<- TESTING STARTED ->"<<endl;
	testAll();
	cout << "<- SHORT TESTS SUCCESSFUL ->" << endl;
	testAllExtended();

	cout << "<- SUCCESSFUL TESTING ->" << endl;
}