#include "Bag.h"
#include "BagIterator.h"
#include <exception>
#include <iostream>
using namespace std;


Bag::Bag() {
	this->capacity = 10;
    this->length = 0;
    this->T = new TElem[this->capacity];
    this->next = new int[this->capacity];
    for(int i=0;i<=this->capacity-1;i++)
    {
        this->T[i] = this->null_telem;
        this->next[i] = -1;
    }
    this->firstFree = 0;
}
/// Theta(capacity)


void Bag::add(TElem elem) {
    TElem element;
    element = elem;
    int hashValue = this->hashFunction(elem);
    if (this->T[hashValue] == this->null_telem) {
        if(hashValue == this->firstFree)
            this->changeFirstFree();
        this->T[hashValue] = element;
        this->next[hashValue] = -1;
        this->length++;
    } else {
        if(this->firstFree == this->capacity)
            this->resizeRehash();
        int currentPosition = hashValue;
        while (this->next[currentPosition] != -1) {
            currentPosition = this->next[currentPosition];
        }
        if (this->next[currentPosition] == -1) {
            this->T[this->firstFree] = element;
            this->next[this->firstFree] = -1;
            this->next[currentPosition] = this->firstFree;
            this->changeFirstFree();
            this->length++;
        }
    }
}
/// Theta(capacity)


bool Bag::remove(TElem elem) {
    bool returnValue = false;
    int current = this->hashFunction(elem);
    int prev = -1;
    while (current != -1 && this->T[current] != elem) {
        prev = current;
        current = this->next[current];
    }

    if (current == -1) {
        returnValue = false;
    } else{
        returnValue = true;
        bool over = false;
        do {
            int position = this->next[current];
            int prevPosition = current;
            while (position != -1 && this->hashFunction(this->T[position]) != current) {
                prevPosition = position;
                position = this->next[position];
            }
            if (position == -1)
                over = true;
            else {
                this->T[current] = this->T[position];
                prev = prevPosition;
                current = position;
            }
        } while (!over);
        if (prev == -1) {
            int idx = 0;
            while (idx < this->capacity && prev == -1)
                if (this->next[idx] == current) {
                    prev = idx;
                }else {
                    idx = idx + 1;
                }
        }
        if (prev != -1)
            this->next[prev] = this->next[current];
        this->length--;
        this->T[current] = this->null_telem;
        this->next[current] = -1;
        if (this->firstFree > current)
            this->firstFree = current;
    }
    return returnValue;
}
/// Theta (capacity^2)

bool Bag::search(TElem elem) {
	int hashcode = hashFunction(elem);
    int index = hashcode;
    if (this->T[index] == elem)
        return true;
    while(this->next[index]!=-1) {
        index = this->next[index];
        if (this->T[index] == elem)
            return true;
    }
	return false;
}
/// Theta(capacity) WC, Theta(1) BC

int Bag::nrOccurrences(TElem elem) const {
    BagIterator it = this->iterator();
    it.first();
    int count=0;
    while(it.valid()){
        if(it.getCurrent() == elem)
            count++;
        it.next();
    }
    return count;
}
/// Theta(capacity) WC, Theta(1) BC

int Bag::size() const {
    return this->length;
}


bool Bag::isEmpty() const {
	if(size()==0)
        return true;
    return false;
}

BagIterator Bag::iterator() const {
	return BagIterator(*this);
}


Bag::~Bag() {
    delete[] this->T;
    delete[] this->next;
}

void Bag::resizeRehash() {
    int currentLength = this->length;
    int currentM = this->capacity;
    this->capacity = this->capacity * 2;
    int index;
    auto oldElements = new TElem[currentM];
    for(index = 0; index < currentM; index++) {
        oldElements[index] = this->T[index];
    }

    delete[] this->T;
    this->T = new TElem[this->capacity];
    delete[] this->next;
    this->next = new int[this->capacity];

    for(index = 0; index < this->capacity; index++) {
        this->T[index] = this->null_telem;
        this->next[index] = -1;
    }
    this->firstFree = 0;
    for(index = 0; index < currentM; index++) {
        if (oldElements[index] != this->null_telem)
            add(oldElements[index]);
    }
    this->length = currentLength;

    delete[] oldElements;
}

void Bag::changeFirstFree(){
    this->firstFree = this->firstFree + 1;
    while(this->firstFree < this->capacity && this->T[this->firstFree] != this->null_telem)
    this->firstFree = this->firstFree + 1;
}

TElem *Bag::copyElements() {
    return nullptr;
}

int Bag::hashFunction(TElem e) {
    return abs(e) % this->capacity;
}

int Bag::removeAllOccurences(TElem elem) {
    int occurences = this->nrOccurrences(elem);
    int removed = occurences;
    bool didItRemove = remove(elem);
    while(occurences>0 && didItRemove) {
        didItRemove = remove(elem);
        occurences--;
    }
    if(occurences == 0)
        return removed;
    return 0;
}
/// Theta(nrOccurences)
