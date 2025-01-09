
## Java
```java
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
  
        System.out.println("Vertex Colors: ");  
        for (int i = 0; i < vertices; i++) {  
            System.out.println("Vertex " + i + ": Color " + colors[i]);  
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
  
public class GraphColoringExample {  
    public static void main(String[] args) {  
        int numVertices = 5;  
        GraphColoring graph = new GraphColoring(numVertices);  
  
        graph.addEdge(0, 1);  
        graph.addEdge(0, 2);  
        graph.addEdge(1, 2);  
        graph.addEdge(2, 3);  
        graph.addEdge(3, 4);  
  
        int numColors = 3; 
  
        graph.colorGraph(numColors);  
    }  
}
```

## Rust
```rust
use std::sync::Arc;  
use mpi::environment::Universe;  
use mpi::Rank;  
use mpi::traits::*;  
  
struct GraphColoring {  
    vertices: usize,  
    adjacency_list: Vec<Vec<usize>>,  
    colors: Vec<usize>,  
}  
  
impl GraphColoring {  
    fn new(vertices: usize) -> Self {  
        let mut adjacency_list = Vec::with_capacity(vertices);  
        for _ in 0..vertices {  
            adjacency_list.push(Vec::new());  
        }  
  
        let colors = vec![0; vertices];  
  
        GraphColoring {  
            vertices,  
            adjacency_list,  
            colors,  
        }  
    }  
  
    fn colors_full(&self) -> bool {  
        self.colors.iter().all(|&color| color != 0)  
    }  
  
    fn add_edge(&mut self, from: usize, to: usize) {  
        self.adjacency_list[from].push(to);  
        self.adjacency_list[to].push(from);  
    }  
  
    fn color_graph(&mut self, num_colors: usize, universe_clone: Arc<Universe>) {  
        let universe = universe_clone;  
        let world = universe.world();  
        let rank = world.rank();  
  
        if rank == 0 {  
            self.assign_color(0, num_colors);  
  
            for &neighbour in &self.adjacency_list[0] {  
                world.process_at_rank(neighbour as Rank).send(&self.colors);  
                world.process_at_rank(neighbour as Rank).receive_into(&mut self.colors);  
            }  
  
            while !self.colors_full() {  
                for i in 1..world.size() {  
                    for &neighbour in &self.adjacency_list[i as usize] {  
                        if self.colors[neighbour] == 0 {  
                            world.process_at_rank(neighbour as Rank).send(&self.colors);  
                            world.process_at_rank(neighbour as Rank).receive_into(&mut self.colors);  
                        }  
                    }  
                }  
            }  
        } else {  
            world.process_at_rank(0).receive_into(&mut self.colors);  
            self.assign_color(rank as usize, num_colors);  
            world.process_at_rank(0).send(&mut self.colors);  
        }  
  
        world.barrier();  
        println!("Vertex {}: Color: {}", rank, self.colors[rank as usize]);  
    }  
  
    fn assign_color(&mut self, vertex: usize, num_colors: usize) {  
        let mut used_colors = vec![false; num_colors];  
  
        for &neighbor in &self.adjacency_list[vertex] {  
            if self.colors[neighbor] != 0 {  
                used_colors[self.colors[neighbor] - 1] = true;  
            }  
        }  
  
        for i in 0..num_colors {  
            if !used_colors[i] {  
                self.colors[vertex] = i + 1;  
                break;  
            }  
        }  
  
        if self.colors[vertex] == 0 {  
            self.colors[vertex] = 1;  
        }  
    }  
}  
  
fn main() {  
    let universe = Arc::new(mpi::initialize().unwrap());  
  
    let num_vertices = 5;  
    let mut graph = GraphColoring::new(num_vertices);  
  
    graph.add_edge(0, 1);  
    graph.add_edge(0, 2);  
    graph.add_edge(1, 2);  
    graph.add_edge(2, 3);  
    graph.add_edge(3, 4);  
  
    let num_colors = 3;  
  
    graph.color_graph(num_colors, Arc::clone(&universe));  
}
```
