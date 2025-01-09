#include <vector>
#include <iostream>

class Vertex {
public:
    int data;
    std::vector<int> neighbors;

    Vertex(int value) : data(value) {}

    void addNeighbor(int neighbor) {
        neighbors.push_back(neighbor);
    }

    void printNeighbors() const {
        for (int neighbor : neighbors) {
            std::cout << neighbor << " ";
        }
    }
};
