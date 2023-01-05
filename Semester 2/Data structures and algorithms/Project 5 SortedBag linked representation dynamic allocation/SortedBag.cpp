#include "SortedBag.h"
#include "SortedBagIterator.h"
#include <iostream>

SortedBag::SortedBag(Relation r) {
    this->r = r;
    this->capacity = 10;
    this->info = new TComp[capacity];
    this->leftChild = new int[capacity];
    this->rightChild = new int[capacity];
    this->parents = new int[capacity];
    this->sizeOfBag = 0;
    this->firstEmpty = 0;
    this->root = -1;
    for (int i = 0; i < this->capacity - 1; i++) {
        this->parents[i] = -1;
        this->leftChild[i] = i + 1;
        this->rightChild[i] = -1;

    }
    this->parents[this->capacity - 1] = -1;
    this->leftChild[this->capacity - 1] = -1;
    this->rightChild[this->capacity - 1] = -1;
}
/// O(n)

void SortedBag::resize() {
    // resizing a new array where we copy the old elements
    auto *newInfo = new TComp[this->capacity * 2];
    //copying the old elements
    for (int i = 0; i < this->capacity; i++) {
        newInfo[i] = this->info[i];
    }
    //resizing the links
    int *newLeftChild = new int[this->capacity * 2];
    int *newRightChild = new int[this->capacity * 2];
    int *newParents = new int[this->capacity * 2];
    //copying the old values
    for (int i = 0; i < this->capacity; i++) {
        newLeftChild[i] = this->leftChild[i];
        newRightChild[i] = this->rightChild[i];
        newParents[i] = this->parents[i];
    }
    //initializing all the newly created links
    for (int i = this->capacity; i < this->capacity * 2-1; i++) {
        newLeftChild[i] = i + 1;
        newRightChild[i] = -1;
    }
    //closing the links
    newLeftChild[this->capacity*2 - 1] = -1;
    newRightChild[this->capacity*2 - 1] = -1;
    //increasing the capacity
    this->firstEmpty = this->capacity;
    this->capacity *= 2;
    //deleting old links to the arrays
    delete[]this->info;
    delete[]this->leftChild;
    delete[]this->rightChild;
    delete[]this->parents;

    this->info = newInfo;
    this->leftChild = newLeftChild;
    this->rightChild = newRightChild;
    this->parents = newParents;
}
/// O(n)

void SortedBag::add(TComp e) {

    //no elements free, need for resize
    if (this->firstEmpty == -1) {
        this->resize();
    }
    //taking the next first empty element
    int newFirstEmpty = this->leftChild[firstEmpty];
    //putting the information on the first empty node
    this->info[firstEmpty] = e;
    this->leftChild[firstEmpty] = -1;
    this->rightChild[firstEmpty] = -1;
    // searching for the insert position
    int current = root;
    int parent = -1;
    while (current != -1) {
        parent = current;
        if(r(e, info[current]))
            current = leftChild[current];
        else
            current = rightChild[current];
    }
    if(this->root ==-1)
        this->root = firstEmpty;
    else if(this->r(e, info[parent]))
    {
        leftChild[parent] = firstEmpty;
    }
    else
        rightChild[parent] = firstEmpty;
    this->parents[this->firstEmpty] = parent;
    firstEmpty = newFirstEmpty;
    sizeOfBag++;
}
/// O(n)

bool SortedBag::remove(TComp e) {
    int current = this->root;
    bool found = false;
    while(current!=-1)
    {
        if(e==info[current])
        {
            if(leftChild[current]==-1 && rightChild[current]==-1)
                this->removeZeroDescendants(current);
            else if(leftChild[current]==-1)
                this->removeRightSide(current);
            else if(rightChild[current]==-1)
                this->removeLeftDescendants(current);
            else
                this->removeTwoDescendants(current);
            this->sizeOfBag--;
            return true;
        }
        else
        {
            if(this->r(e, this->info[current]))
                current = leftChild[current];
            else
                current = rightChild[current];
        }

    }
    return false;
}
/// O(n)

bool SortedBag::search(TComp elem) const {
    int current = root;
    while(current != -1)
    {
        if(info[current] == elem)
            return true;
        else if(this->r(elem,this->info[current]))
            current = this->leftChild[current];
        else
            current = this->rightChild[current];

    }
    return false;
}
/// O(n)


int SortedBag::nrOccurrences(TComp elem) const {
    int current = root;
    int cnt = 0;
    while(current!=-1)
    {
        if(info[current] == elem)
            cnt++;
        if(this->r(elem,this->info[current]))
            current = leftChild[current];
        else
            current = rightChild[current];
    }
    return cnt;
}
/// O(n)


int SortedBag::size() const {
    return this->sizeOfBag;
}
/// Theta(1)


bool SortedBag::isEmpty() const {
    return this->sizeOfBag == 0;
}
/// Theta(1)



SortedBagIterator SortedBag::iterator() const {
    return SortedBagIterator(*this);
}
/// Theta(1)


SortedBag::~SortedBag() {
    delete[] info;
    delete[] leftChild;
    delete[] rightChild;
    delete[] parents;
}
/// Theta(1)

void SortedBag::deleteNode(int position) {
    this->leftChild[position] = firstEmpty;
    this->firstEmpty = position;
    this->rightChild[position] = -1;
    this->parents[position]=-1;
}
/// Theta(1)

void SortedBag::removeZeroDescendants(int position) {
    if(position == this->root)
    {
        this->root = -1;
    }
    else
    {
        if(this->r(this->info[position], this->info[this->parents[position]]))
            this->leftChild[parents[position]]=-1;
        else
            this->rightChild[parents[position]] = -1;
    }
    this->deleteNode(position);
}
/// Theta(1)

void SortedBag::removeLeftDescendants(int position) {
    if(position == this->root)
    {
        this->root = leftChild[position];
    }
    else
    {
        parents[leftChild[position]] = parents[position];
        if(this->r(this->info[position], this->info[parents[position]]))
            this->leftChild[parents[position]] = leftChild[position];
        else
            this->rightChild[parents[position]] = leftChild[position];
    }
    this->deleteNode(position);
}
/// Theta(1)


void SortedBag::removeRightSide(int position) {
    if(position ==  this->root)
    {
        this->root = rightChild[position];
    }
    else
    {
        parents[rightChild[position]]=parents[position];
        if(this->r(this->info[position], this->info[parents[position]]))
            leftChild[parents[position]]=rightChild[position];
        else
            this->rightChild[parents[position]] = rightChild[position];
    }
    this->deleteNode(position);
}
/// Theta(1)

void SortedBag::removeTwoDescendants(int position) {
    int maxNode = this->leftChild[position];
    int prevMaxNode = position;
    while(this->rightChild[maxNode]!=-1)
    {
        prevMaxNode = maxNode;
        maxNode = this->rightChild[maxNode];
    }
    this->info[position] = this->info[maxNode];
    if(this->leftChild[maxNode]==-1)
        this->removeZeroDescendants(maxNode);
    else
        this->removeLeftDescendants(maxNode);

}
/// O(n)

void SortedBag::addOccurences(int nr, TComp elem) {
    if(nr < 0)
        throw std::exception();
    else
    {
            while(nr!=0)
            {
                add(elem);
                nr--;
            }
    }
}
/// O(nr)






