package org.example;

public class GraphColoringExample {
    public static void main(String[] args) {  
        int numVertices = 100;
        long startTime = System.nanoTime();

        GraphColoring graph = new GraphColoring(numVertices);

        for (int i = 0; i < 100; i++) {
            graph.addEdge(i, (i + 1)%100);
            graph.addEdge(i, (i + 2) % 100);

            int randomVertex = (int) (Math.random() * 100);
            graph.addEdge(i, randomVertex);

            int offsetVertex = (i + 10) % 100;
            graph.addEdge(i, offsetVertex);
        }

        int numColors = 2000;
  
        graph.colorGraph(numColors);

        long endTime = System.nanoTime();
        long executionTime = (endTime - startTime)/1000000;

        System.out.println("Time: " + executionTime + "ms");

    }  
}