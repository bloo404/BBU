#include <exception>
#include "BagIterator.h"
#include "Bag.h"

using namespace std;


BagIterator::BagIterator(const Bag& c): bag(c)
{
    this->currentPosition = 0;
    while (this->currentPosition < this->bag.capacity && (this->bag.T[this->currentPosition] == this->bag.null_telem))
    this->currentPosition++;
    this->firstElement = this->currentPosition;
}
/// Theta(capacity)

void BagIterator::first() {
    this->currentPosition = 0;
    while (this->currentPosition < this->bag.capacity && (this->bag.T[this->currentPosition] == this->bag.null_telem))
        this->currentPosition++;
    this->firstElement = this->currentPosition;
}
/// Theta(capacity)


void BagIterator::next() {
    if (this->currentPosition >= this->bag.capacity)
        throw exception();
    this->currentPosition++;
    while (this->currentPosition < this->bag.capacity && (this->bag.T[this->currentPosition] == this->bag.null_telem))
    this->currentPosition++;
}
/// Theta(capacity)

bool BagIterator::valid() const {
	if(this->bag.length == 0)
        return false;
    if(this->currentPosition < this->bag.capacity)
        return true;
	return false;
}
/// Theta(1)


TElem BagIterator::getCurrent() const
{
    if (this->currentPosition >= this->bag.capacity)
        throw exception();
    return this->bag.T[this->currentPosition];
}
