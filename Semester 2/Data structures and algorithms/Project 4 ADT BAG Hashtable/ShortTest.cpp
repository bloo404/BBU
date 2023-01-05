#include "ShortTest.h"
#include <assert.h>
#include "Bag.h"
#include "BagIterator.h"
#include <iostream>
using namespace std;

void testAll() {
    cout<<"<< SHORT TESTS STARTED >>\n";
	Bag b;
	assert(b.isEmpty() == true);
	assert(b.size() == 0);
    cout<<"<< adding elements\n";
	b.add(5);
	b.add(1);
	b.add(10);
	b.add(7);
	b.add(1);
	b.add(11);
	b.add(-3);
	assert(b.size() == 7);
    cout<<"<< asserting search\n";
	assert(b.search(10) == true);
	assert(b.search(16) == false);
    cout<<"<< asserting nrOccurences\n";
	assert(b.nrOccurrences(1) == 2);
	assert(b.nrOccurrences(7) == 1);
    cout<<"<< asserting remove\n";
	assert(b.remove(1) == true);
	assert(b.remove(6) == false);
	assert(b.size() == 6);
	assert(b.nrOccurrences(1) == 1);
	BagIterator it = b.iterator();
	it.first();
    cout<<"<< asserting validation\n";
	while (it.valid()) {
        cout<<"<< still in while...\n";
		TElem e = it.getCurrent();
		it.next();
	}
    cout<<"<< asserting removing all occurences\n";
    b.add(1);
    b.add(1);
    b.add(1);
    b.add(1);
    assert(b.nrOccurrences(1)==5);
    assert(b.removeAllOccurences(1) == 5);
    assert(b.nrOccurrences(1)==0);
}
