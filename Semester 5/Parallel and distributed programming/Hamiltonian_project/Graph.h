#include <iostream>
#include <vector>
#include <queue>
#include <thread>
#include <mutex>
#include <atomic>
#include "Vertex.h"

class Graph {
private:
    std::vector<Vertex*> vertices;
    int starting_vertex;
    std::vector<std::vector<bool>> memoization_table;
    std::mutex mtx;
    std::atomic<bool> found_cycle{false};

public:
    ~Graph() {
        for (auto vertex : vertices) {
            delete vertex;
        }
    }

    void addVertex(int vertex) {
        if (!hasVertex(vertex)) {
            vertices.push_back(new Vertex(vertex));
        }
    }

    void addEdge(int from, int to) {
        Vertex* fromVertex = findVertex(from);
        Vertex* toVertex = findVertex(to);

        if (fromVertex && toVertex) {
            fromVertex->addNeighbor(to);
        }
    }

    void printGraph() {
        for (auto* vertex : vertices) {
            std::cout << "Vertex " << vertex->data << " goes to: ";
            vertex->printNeighbors();
            std::cout << std::endl;
        }
    }

    bool hasVertex(int vertex) {
        for (auto* v : vertices) {
            if (v->data == vertex) {
                return true;
            }
        }
        return false;
    }

    Vertex* findVertex(int vertex) {
        for (auto* v : vertices) {
            if (v->data == vertex) {
                return v;
            }
        }
        return nullptr;
    }

    void set_starting_vertex(int nr) {
        this->starting_vertex = nr;
    }

    int getStartingVertex() const {
        return this->starting_vertex;
    }

    bool isNeighbor(int node) const {
        for (const auto* vertex : this->vertices) {
            for (int neighbor : vertex->neighbors) {
                if (neighbor == node) {
                    return true;
                }
            }
        }
        return false;
    }

    bool hasHamiltonianCycleParallel() {
        if (isNeighbor(this->starting_vertex)) {
            memoization_table.resize(1 << vertices.size(), std::vector<bool>(vertices.size(), false));

            std::queue<std::pair<int, int>> q;
            q.push({starting_vertex - 1, 1 << (starting_vertex - 1)});

            std::vector<std::thread> threads;

            auto threadFunc = [this, &q]() {
                while (!q.empty() && !found_cycle) {
                    std::unique_lock<std::mutex> lock(mtx);
                    auto [current_vertex, visited_mask] = q.front();
                    q.pop();
                    lock.unlock();

                    if (visited_mask == (1 << vertices.size()) - 1) {
                        found_cycle = true;
                        return;
                    }

                    for (int neighbor : vertices[current_vertex]->neighbors) {
                        int neighbor_index = neighbor - 1;

                        if (neighbor_index < 0 || neighbor_index >= vertices.size()) {
                            std::cerr << "Invalid neighbor index: " << neighbor_index << std::endl;
                            found_cycle = true;
                            return;
                        }

                        if ((visited_mask & (1 << neighbor_index)) == 0) {
                            lock.lock();
                            q.push({neighbor_index, visited_mask | (1 << neighbor_index)});
                            lock.unlock();
                        }
                    }

                    try {
                        lock.lock();
                        memoization_table.at(visited_mask).at(current_vertex) = true;
                        lock.unlock();
                    } catch (std::out_of_range& e) {
                        found_cycle = true;
                        return;
                    }
                }
            };

            for (int i = 0; i < std::thread::hardware_concurrency(); ++i) {
                threads.emplace_back(threadFunc);
            }

            for (auto& thread : threads) {
                thread.join();
            }
        }
        return found_cycle;
    }


};
