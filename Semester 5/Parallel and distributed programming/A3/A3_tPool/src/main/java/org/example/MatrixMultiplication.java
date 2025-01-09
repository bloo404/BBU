package org.example;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.io.*;

public class MatrixMultiplication {
    private static final int matSize = 100;
    private static final int numThreads = 4;

    private static void computeMatrixElement(int[][] result, int[][] a, int[][] b, int row, int col, int taskId) {
        int sum = 0;
        for (int i = 0; i < matSize; ++i) {
            sum += a[row][i] * b[i][col];
        }
        synchronized (result) { //TODO uses mutex automatically because Java
            System.out.println("Thread " + taskId + " on position (" + row + " , " + col + ") => " + sum);
            result[row][col] = sum;
        }
    }

    private static void parallelTask(int[][] result, int[][] a, int[][] b, int taskId, int taskSize) {
        int i = 0;
        int j = taskId;

        while (i < matSize) {
            while (j < matSize) {
                computeMatrixElement(result, a, b, i, j, taskId);
                j += taskSize;
            }
            i += 1;
            j = j % matSize;
        }
    }

    public static void main(String[] args) {

        long startTime = System.nanoTime();

        int[][] a = new int[matSize][matSize];
        int[][] b = new int[matSize][matSize];
        int[][] result = new int[matSize][matSize];

        for (int i = 0; i < matSize; ++i) {
            for (int j = 0; j < matSize; ++j) {
                a[i][j] = (int) (Math.random() * 5);
                b[i][j] = (int) (Math.random() * 5);
            }
        }

        System.out.println("MATRIX A");
        for (int i = 0; i < matSize; ++i) {
            for (int j = 0; j < matSize; ++j) {
                System.out.print(a[i][j] + " ");
            }
            System.out.println();
        }


        System.out.println("MATRIX B");
        for (int i = 0; i < matSize; ++i) {
            for (int j = 0; j < matSize; ++j) {
                System.out.print(b[i][j] + " ");
            }
            System.out.println();
        }

        ExecutorService executor = Executors.newFixedThreadPool(numThreads);

        for (int taskId = 0; taskId < numThreads; taskId++) {
            final int finalTaskId = taskId;
            executor.submit(() -> parallelTask(result, a, b, finalTaskId, numThreads));
        }

        executor.shutdown();

        while (!executor.isTerminated()) { // equivalent of thread.join in C++
        }

        for (int i = 0; i < matSize; ++i) {
            for (int j = 0; j < matSize; ++j) {
                System.out.print(result[i][j] + " ");
            }
            System.out.println();
        }

        long endTime = System.nanoTime();
        long executionTime = (endTime - startTime)/1000000;

        System.out.println("Time: " + executionTime + "ms");

    }
}
