#include <iostream>
#include <fstream>
#include "Graph.h"
#include "GraphGenerator.h"


void read_graph(Graph& g) {
    std::ifstream file("../graph.txt");
    if (!file.is_open()) {
        std::cerr << "Error opening file!" << std::endl;
        return;
    }

    int nr_nodes;
    file >> nr_nodes;

    for (int i = 1; i <= nr_nodes; i++) {
        g.addVertex(i);
    }

    int x, y;
    while (file >> x >> y)
        g.addEdge(x, y);

    g.set_starting_vertex(x);

    g.printGraph();
    file.close();
}

int main() {
    Graph g;

//    int numVertices = 500;
//    HamiltonianCycleGenerator generator(numVertices);
//    generator.generateGraph("../graph.txt");

    read_graph(g);
    auto start_time = std::chrono::high_resolution_clock::now();
    bool hasCycle = g.hasHamiltonianCycleParallel();

    auto end_time = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(end_time - start_time);

    std::cout << "This graph ";
    if (hasCycle)
        std::cout << "has";
    else
        std::cout << "doesn't have";
    std::cout << " a Hamiltonian cycle starting from " << g.getStartingVertex() << std::endl;

    std::cout << "Execution time: " << duration.count() << " milliseconds" << std::endl;

    return 0;
}
