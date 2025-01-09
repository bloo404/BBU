#include <iostream>
#include <fstream>
#include <vector>

class HamiltonianCycleGenerator {
public:
    HamiltonianCycleGenerator(int numVertices) : numVertices(numVertices) {}

    void generateGraph(const std::string& filename) {
        generateCycle();
        writeToFile(filename);
    }

private:
    int numVertices;
    std::vector<std::pair<int, int>> edges;

    void generateCycle() {
        for (int i = 1; i <= numVertices; ++i) {
            edges.push_back({i, (i % numVertices) + 1});
        }
    }

    void writeToFile(const std::string& filename) {
        std::ofstream outputFile(filename);
        if (!outputFile.is_open()) {
            std::cerr << "Error opening file: " << filename << std::endl;
            return;
        }

        outputFile << numVertices << std::endl;

        for (const auto& edge : edges) {
            outputFile << edge.first << " " << edge.second << std::endl;
        }

        outputFile.close();
    }
};