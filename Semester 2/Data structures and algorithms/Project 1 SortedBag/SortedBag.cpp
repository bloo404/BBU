#include "SortedBag.h"
#include "SortedBagIterator.h"
#include <exception>
#include <cstdlib>

using namespace std;

SortedBag::SortedBag(Relation r) {

        this->nrPairs = 0;
        this->capacity = 1;
        this->elems[0] = 0;
        this->freq[0] = 0;
        this->len = 0;
        this->rel = r;
}
//Theta(1)

void SortedBag::add(TComp e) {
    if(this->nrPairs == this->capacity){
        this->capacity *= 2;
        TElem* aux_elem = (TElem *)malloc(this->capacity * sizeof (int));
        TElem* aux_freq = (TElem *)malloc(this->capacity * sizeof (int));

        for(int index = 0; index<this->capacity/2;index++) {
            aux_elem[index] = this->elems[index];
            aux_freq[index] = this->freq[index];
        }
        for(int index = 0; index<this->capacity;index++) {
            this->elems[index]= aux_elem[index];
            this->freq[index]=aux_freq[index] ;
        }
    }

    int index = 0;
    int added = 0;

    while( index < this->nrPairs ){
        if(this->elems[index] == e){
            this->freq[index]++;
            added = 1;
            this->len++;
        }
        index++;
    }

    while( index < this->capacity ){
        this->elems[index] = 0;
        this->freq[index] = 0;
        index++;
    }

    if(added == 0){
        this->elems[nrPairs] = e;
        this->freq[nrPairs] = 1;
        this->nrPairs++;
        this->len++;

        index = nrPairs;

        while(index > 0 && !this->rel(e, this->elems[index - 1])){
            this->freq[index] = this->freq[index - 1];
            this->freq[index - 1] = 1;
            this->elems[index] = this->elems[index - 1];
            this->elems[index - 1] = e;

            index--;
        }
    }

    for( int i = 0; i < this->nrPairs - 1 ; i++){
        for(int j = i + 1; j < this->nrPairs; j++){
            if( !this->rel(this->elems[i], this->elems[j]) ){

                int aux = this->elems[i];
                this->elems[i] = this->elems[j];
                this->elems[j] = aux;

                aux = this->freq[i];
                this->freq[i] = this->freq[j];
                this->freq[j] = aux;
            }
        }
    }

}
//Theta(n^2)

bool SortedBag::remove(TComp e) {
	int index = 0;

    while(index < this->nrPairs){
        if(this->elems[index] == e){

            if(this->freq[index] > 1){
                this->freq[index]--;
                this->len--;
                return true;
            }

            while(index < this->nrPairs - 1){
                this->elems[index] = this->elems[index + 1];
                this->freq[index] = this->freq[index + 1];

                index++;
            }
            this->nrPairs--;
            this->len--;
            return true;
        }
        index++;
    }
	return false;
}
//O(n^2)


bool SortedBag::search(TComp elem) const {
	int index = 0;

    while(index < this->nrPairs){
        if(this->elems[index] == elem)
            return true;
        index++;
    }
	return false;
}
//O(n)


int SortedBag::nrOccurrences(TComp elem) const {
    int index = 0;

    while (index < nrPairs){
        if(this->elems[index] == elem)
            return this->freq[index];
        index++;
    }
    return 0;
}
//O(n)


int SortedBag::size() const {
    return this->len;
}
//Theta(1)


bool SortedBag::isEmpty() const {
	if(this->nrPairs == 0)
        return true;
	return false;
}
//Theta(1)


SortedBagIterator SortedBag::iterator() const {
	return SortedBagIterator(*this);
}
//Theta(1)


SortedBag::~SortedBag() {
	delete[] this->elems;
    delete[] this->freq;
}

void SortedBag::addOccurences(int nr, TComp elem) {
    if (nr < 0) {
        throw exception(); // "The added number of occurences is negative"
    }
    else if(!search(elem))
    {
        add(elem);
    }
    else
    {
        int index = 0;
        while (index < nrPairs){
            if(this->elems[index] == elem)
                this->freq[index] = freq[index] + nr;
            index++;
        }
    }
}

