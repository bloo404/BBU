#include "SortedBagIterator.h"
#include "SortedBag.h"
#include <exception>

using namespace std;

SortedBagIterator::SortedBagIterator(const SortedBag& b) : bag(b) {
	this->current = 0;
}
//Theta(1)

TComp SortedBagIterator::getCurrent() {
	if(this->current == this->bag.nrPairs){
        throw exception();
    }else{
        return this->bag.elems[this->current];
    }
}
//Theta(1)

bool SortedBagIterator::valid() {
	if( this->current < this->bag.nrPairs){
        return true;
    }
	return false;
}
//Theta(1)

void SortedBagIterator::next() {
	if(this->current >= this->bag.nrPairs){
        throw exception();
    }else{
        this->current++;
    }
}
//Theta(1)

void SortedBagIterator::first() {
    this->current = 0;
}
//Theta(1)

