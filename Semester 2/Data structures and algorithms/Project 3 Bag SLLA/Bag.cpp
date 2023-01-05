#include "Bag.h"
#include "BagIterator.h"
#include <exception>
#include <iostream>
using namespace std;


Bag::Bag() {
	this->head = -1;
    this->prevEmpty = -1;
    this->firstEmpty = 0;
    this->sizeElems = 0;
    this->elements = new TElem[MAXCAP];
    this->frequency = new TElem[MAXCAP];
    this->next = new TElem[MAXCAP];
}
/// Complexity: Theta(1)

void Bag::add(TElem elem) {
    if (this->isEmpty())
    {
        this->head = firstEmpty;
        if (sizeElems == 0)
        {
            elements[sizeElems]=elem;
            frequency[sizeElems] = 1;
            next[sizeElems++] = -1;
            prevEmpty = firstEmpty;
            firstEmpty++;
        }
        else
        {
            elements[firstEmpty] = elem;
            frequency[firstEmpty] = 1;
            int nextEmpty = next[firstEmpty];
            next[firstEmpty] = -1;
            prevEmpty = firstEmpty;
            firstEmpty = nextEmpty;
        }
    }
    else
    {
        int current = this->head;
        while (current != -1)
        {
            if (elements[current] == elem)
            {
                frequency[current]++;
                return;
            }
            current = next[current];
        }
        if (firstEmpty == sizeElems)
        {
            next[prevEmpty] = firstEmpty;
            elements[sizeElems] = elem;
            frequency[sizeElems] = 1;
            next[sizeElems++] = -1;
            prevEmpty = firstEmpty;
            firstEmpty++;
        }
        else
        {
            elements[firstEmpty] = elem;
            frequency[firstEmpty] = 1;
            next[prevEmpty] = firstEmpty;
            int nextEmpty = next[firstEmpty];
            next[firstEmpty] = -1;
            prevEmpty = firstEmpty;
            firstEmpty = nextEmpty;
        }
    }
}
/// Complexity: O(n)

bool Bag::remove(TElem elem) {
	int current = this->head,prevcurrent=-1;
	while (current != -1)
	{
		if (elements[current] == elem)
		{
			frequency[current]--;
			if (frequency[current] == 0)
			{
				if (current == this->head)
				{
					this->head = next[current];
				}
				else next[prevcurrent] = next[current];
				next[current] = firstEmpty;
				firstEmpty = current;
			}
			return true;
		}
		prevcurrent = current;
		current = next[current];
	}
	return false;
}
/// Complexity: O(n)

bool Bag::search(TElem elem) const {
	int current = this->head;
	while (current != -1)
	{
		if (elements[current] == elem) return true;
		current = next[current];
	}
	return false;
}

int Bag::nrOccurrences(TElem elem) const {
	int current = this->head;
	while (current != -1)
	{
		if (elements[current] == elem)return frequency[current];
		current = next[current];
	}
	return 0;
}
/// Complexity: O(n)

int Bag::size() const {
	int sum = 0, current = this->head;
	while (current != -1)
	{
		sum+=frequency[current];
		current = next[current];
	}
	return sum;
}
/// Complexity: Theta(1)

bool Bag::isEmpty() const {
    if (this->head == -1)
        return true;
	return false;
}
/// Complexity: Theta(1)

BagIterator Bag::iterator() const {
	return BagIterator(*this);
}
/// Complexity: Theta(1)

Bag::~Bag() {
    delete[] elements;
    delete[] frequency;
    delete[] next;
}
/// Complexity: Theta(1)

int Bag::elementsWithMinimumFrequency() const {
    if (isEmpty())
        return 0;
    else
    {
        int sum = 0, current = this->head, minimum=frequency[current];
        while (current != -1)
        {
            if (minimum > frequency[current])
                minimum = frequency[current];
            current = next[current];
        }
        current = this->head;
        while (current != -1)
        {
            if (minimum == frequency[current])
                sum+=1;
            current = next[current];
        }
        return sum;
    }
}

