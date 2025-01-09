package org.example;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.*;

class GraphColoring {
    private final int vertices;
    private final List<Integer>[] adjacencyList;
    private final int[] colors;

    public GraphColoring(int vertices) {
        this.vertices = vertices;
        this.adjacencyList = new ArrayList[vertices];
        this.colors = new int[vertices];

        for (int i = 0; i < vertices; i++) {
            adjacencyList[i] = new ArrayList<>();
        }
    }

    public void addEdge(int from, int to) {
        adjacencyList[from].add(to);
        adjacencyList[to].add(from);
    }

    private boolean isGraphProperlyColored() {
        for (int i = 0; i < vertices; i++) {
            for (int neighbor : adjacencyList[i]) {
                if (colors[i] == colors[neighbor]) {
                    return false;
                }
            }
        }
        return true;
    }

    public void colorGraph(int numColors) {
        ExecutorService executorService = Executors.newFixedThreadPool(vertices);

        try {
            List<Callable<Void>> tasks = new ArrayList<>();

            for (int i = 0; i < vertices; i++) {
                final int vertex = i;
                tasks.add(() -> {
                    assignColor(vertex, numColors);
                    return null;                });
            }

            executorService.invokeAll(tasks);
        } catch (InterruptedException e) {
            e.printStackTrace();
        } finally {
            executorService.shutdown();
        }

        if (isGraphProperlyColored()) {
            System.out.println("Graph is properly colored.");
            System.out.println("Vertex Colors: ");
            for (int i = 0; i < vertices; i++) {
                System.out.println("Vertex " + i + ": Color " + colors[i]);
            }
        } else {
            System.out.println("Graph is not properly colored due to too little colors.");
        }
    }

    private void assignColor(int vertex, int numColors) {
        synchronized (this) {
            boolean[] usedColors = new boolean[numColors];

            for (int neighbor : adjacencyList[vertex]) {
                if (colors[neighbor] != 0) {
                    usedColors[colors[neighbor] - 1] = true;
                }
            }

            for (int i = 0; i < numColors; i++) {
                if (!usedColors[i]) {
                    colors[vertex] = i + 1;
                    break;                }
            }

            if (colors[vertex] == 0) {
                colors[vertex] = 1;
            }
        }
    }

}  