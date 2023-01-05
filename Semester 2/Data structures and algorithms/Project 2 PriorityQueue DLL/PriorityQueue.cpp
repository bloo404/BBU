#include "PriorityQueue.h"
#include <exception>
#include <cstdlib>

using namespace std;

PriorityQueue::PriorityQueue(Relation r) {
    this->rel = r;
    this->size = 0;
    this->head = new DLLnode();
    this->current = this->head;
}
/// Theta(1)

void PriorityQueue::push(TElem e, TPriority p) {
	DLLnode* newNode = new DLLnode();
    newNode->pair.first = e;
    newNode->pair.second = p;

    current = head;

    if (size==0)
    {
        head = newNode;
        current = newNode;
        this->size ++ ;
    }
    else {
        while (current->next != NULL)
            current = current->next;

        newNode->next = NULL;
        current->next = newNode;
        newNode->prev = current;

        while (this->rel(p, current->pair.second) && current->prev != NULL) {
            current->next->pair.second = current->pair.second;
            current->next->pair.first = current->pair.first;
            current->pair.first = e;
            current->pair.second = p;
            current = current->prev;
        }

        if (this->rel(p, head->pair.second)) {
            head->next->pair.second = head->pair.second;
            head->next->pair.first = head->pair.first;
            head->pair.first = e;
            head->pair.second = p;
        }
        this->size = this->size + 1;
    }
}
/// O(n)

//throws exception if the queue is empty (kind of last element)
Element PriorityQueue::top() const {
    if(this->size == 0) {
        throw exception();
    }
    else{
        return this->head->pair;
    }
}
/// Theta(1)

// kind of remove
Element PriorityQueue::pop() {
	if(this->size==0)
    {
        throw exception();
    }
    else
    {   Element removed = head->pair;
        if(head->next!=NULL) {
            DLLnode *newNode = head;
            head = head->next;
            head->prev = NULL;
            delete[] newNode;
            this->size--;
            return removed;
        }
        else{
            Element removed = head->pair;
            delete[] head;
            this->size--;
            return removed;
        }
    }
}
/// Theta(1)

bool PriorityQueue::isEmpty() const {
    if(this->size == 0)
        return true;
    return false;
}
/// Theta(1)

TPriority PriorityQueue::priorityOf(TElem elem){
    current = head;
    if(this->size==0)
        return -1;
    else
    {
        int tl = 0;
        while(current->next!=NULL){
            if(current->pair.first == elem) {
                tl = 1;
                return current->pair.second;
            }
            current = current->next;
        }
        return -1;
    }
}
/// O(n)

PriorityQueue::~PriorityQueue() {


};

