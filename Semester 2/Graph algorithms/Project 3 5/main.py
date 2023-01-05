from random import randint

from graph import TripleDictGraph, write_graph_to_file, read_graph_from_file


class UI:
    def __init__(self):
        self._graphs = []
        self._current = None

    def add_empty_graph(self):
        """
        Function to create and append an empty graph
        """
        if self._current is None:
            self._current = 0
        graph = TripleDictGraph(0, 0)
        self._graphs.append(graph)
        self._current = len(self._graphs) - 1

    def create_random_graph_ui(self):
        """
        Function to get the input from the user in order to create a new graph
        """
        vertices = int(input("Enter the number of vertices: "))
        edges = int(input("Enter the number of edges: "))
        graph = self.generate_random(vertices, edges)
        if self._current is None:
            self._current = 0
        self._graphs.append(graph)
        self._current = len(self._graphs) - 1

    def generate_random(self, vertices, edges):
        """
        Function to generate a random graph with specified vertices and edges
        :param vertices: the number of vertices of the new graph
        :param edges: the number of edges of the new graph
        :return: the created graph
        """
        if edges > vertices * vertices:
            raise ValueError("Too many edges!")
        graph = TripleDictGraph(vertices, 0)
        i = 0
        while i < edges:
            x = randint(0, vertices - 1)
            y = randint(0, vertices - 1)
            cost = randint(0, 500)
            if graph.add_edge(x, y, cost):
                i += 1
        return graph

    def read_graph_from_file_ui(self):
        """
        Function to read a graph from a text file
        :return:
        """
        filename = input("Enter the name of the file: ")
        if self._current is None:
            self._current = 0
        graph = read_graph_from_file(filename)
        self._graphs.append(graph)
        self._current = len(self._graphs) - 1

    def write_graph_to_file_ui(self):
        """
        Function to writte the current graph to a text file
        """
        current_graph = self._graphs[self._current]
        output_file = "output" + str(self._current) + ".txt"
        write_graph_to_file(current_graph, output_file)

    def switch_graph_ui(self):
        """
        Function to go to another saved graph from the list of graphs
        """
        print("You are on the graph number: {}".format(self._current))
        print("Available graphs: 0 - {}".format(str(len(self._graphs) - 1)))
        number = int(input("Enter the graph number you want to switch to: "))
        if not 0 <= number < len(self._graphs):
            raise ValueError("Trying to switch to a non existing graph!")
        self._current = number

    def get_number_of_vertices_ui(self):
        """
        Function to print the number of vertices of the current graph
        """
        print("The number of vertices is: {}.".format(self._graphs[self._current].number_of_vertices))

    def get_number_of_edges_ui(self):
        """
        Function to print the number of edges of the current graph
        """
        print("The number of edges is: {}.".format(self._graphs[self._current].number_of_edges))

    def list_outbound(self):
        vertex = int(input("Enter the vertex: "))
        line = str(vertex) + " :"
        for y in self._graphs[self._current].parse_outbound(vertex):
            line = line + " " + "({}, {})".format(str(vertex), str(y))
        print(line)


    def list_inbound(self):
        """
        Function to show all edges that enter a specific node
        :return:
        """
        vertex = int(input("Enter the vertex: "))
        line = str(vertex) + " :"
        for y in self._graphs[self._current].parse_inbound(vertex):
            line = line + " " + "({}, {})".format(str(y), str(vertex))
        print(line)

    def list_all_costs(self):
        """
        Function to show all cost values of the edges
        """
        for key in self._graphs[self._current].parse_cost():
            line = "({}, {})".format(key[0], key[1]) + " :" + str(self._graphs[self._current].dictionary_cost[key])
            print(line)

    def parse_all_vertices(self):
        """
        Function to show all vertices
        """
        for vertex in self._graphs[self._current].parse_vertices():
            print("{}".format(vertex))

    def add_vertex(self):
        """
        Function to add a new vertex to the current graph
        """
        vertex = int(input("Enter the new vertex: "))
        added = self._graphs[self._current].add_vertex(vertex)
        if added:
            print("Vertex added successfully!")
        else:
            print("Cannot add this vertex, it already exists!")

    def delete_an_user_specified_vertex(self):
        """
        Function to delete a certain vertex
        """
        vertex = int(input("Enter the vertex to be deleted: "))
        deleted = self._graphs[self._current].remove_vertex(vertex)
        if deleted:
            print("Vertex deleted successfully!")
        else:
            print("Cannot delete this vertex, it does not exist!")

    def add_edge(self):
        """
        Function to add a new edge by the user
        """
        print("Add an edge (an edge is (x, y))")
        vertex_x = int(input("Enter x = "))
        vertex_y = int(input("Enter y = "))
        cost = int(input("Enter the cost of the edge: "))
        added = self._graphs[self._current].add_edge(vertex_x, vertex_y, cost)
        if added:
            print("Edge added successfully!")
        else:
            print("Cannot add this edge, it already exists!")

    def remove_an_user_specified_edge(self):
        """
        Function to delete an edge specified by the user
        """
        print("Remove an edge (an edge is (x, y))")
        vertex_x = int(input("Enter x = "))
        vertex_y = int(input("Enter y = "))
        deleted = self._graphs[self._current].remove_edge(vertex_x, vertex_y)
        if deleted:
            print("Edge deleted successfully!")
        else:
            print("Cannot remove this edge, it does not exist!")

    def modify_cost_of_a_user_specified_edge(self):
        """
        Function to modify the value of the cost of a user specified egde
        """
        print("Modify the cost of an edge (an edge is (x, y))")
        vertex_x = int(input("Enter x = "))
        vertex_y = int(input("Enter y = "))
        cost = int(input("Enter the cost of the edge: "))
        mod = self._graphs[self._current].change_cost(vertex_x, vertex_y, cost)
        if mod:
            print("Cost modified successfully!")
        else:
            print("Cannot modify the cost, the edge does not exist!")

    def get_in_degree_of_user_specified_vertex(self):
        """
        Function to get the number of edges that enter a specific node
        """
        vertex = int(input("Enter the vertex:"))
        degree = self._graphs[self._current].in_degree(vertex)
        if degree == -1:
            print("The vertex does not exist!")
        else:
            print("The in degree of the vertex {} is {}.".format(vertex, degree))

    def get_out_degree_of_user_specified_vertex(self):
        """
        Function to get the number of edges that exit a specific node
        """
        vertex = int(input("Enter the vertex:"))
        degree = self._graphs[self._current].out_degree(vertex)
        if degree == -1:
            print("The vertex does not exist!")
        else:
            print("The out degree of the vertex {} is {}.".format(vertex, degree))

    def check_if_edge(self):
        """
        Function to check if between two given vertices there is an edge
        """
        vertex_x = int(input("Enter x = "))
        vertex_y = int(input("Enter y = "))
        edge = self._graphs[self._current].find_if_edge(vertex_x, vertex_y)
        if edge is not False:
            print("({}, {}) is an edge and its cost is {}!".format(vertex_x, vertex_y, edge))
        else:
            print("({}, {}) is not an edge!".format(vertex_x, vertex_y))

    def copy_current_graph(self):
        """
        Function to create a copy of the current graph and to add it to the list of graphs
        """
        copy = self._graphs[self._current].make_copy()
        self._graphs.append(copy)

    def find_shortest_path_ui(self):
        start = int(input('start vertex: '))
        end = int(input('end vertex: '))
        try:
            path = self._graphs[self._current].findLowestLengthPathBFS( start, end)
        except ValueError as ve:
            print(ve)
            return
        if len(path) == 0:
            print('start node is end node!')
        else:
            for vertrex in path[:-1]:
                print(str(vertrex) + '->', end='')
            print(path[-1])
            print('length: ', len(path))

    def minimum_cost_path_ui(self):
        vertex_begin = int(input("Enter source vertex = "))
        vertex_end = int(input("Enter end vertex = "))
        if vertex_begin not in self._graphs[self._current]._dictionary_in.keys() or vertex_end not in self._graphs[self._current]._dictionary_in.keys():
            raise Exception("One vertex/ both vertices entered might not exist.")
        else:
            distance, path = self._graphs[self._current].minimum_cost_path(vertex_begin, vertex_end)
            if distance == float("inf"):
                raise Exception("There is no walk from {} to {}".format(vertex_begin, vertex_end))
            print("The cost of the minimum cost path is: {}".format(str(distance)))
        # print the path
        print("The path is: ", end=' ')
        for index in range(len(path) - 1, -1, -1):
            print(path[index], end=' ')
        print("\n")

    def print_menu(self):
        print("MENU:\n"
              "0. EXIT.\n" 
              "1. Create a random graph with specified number of vertices and edges.\n"
              "2. Read the graph from a text file.\n"
              "3. Write the graph in a text file.\n"
              "4. Switch the graph.\n" 
              "5. Get the number of vertices.\n"
              "6. Get the number of edges.\n"
              "7. List the outbound edges of a given vertex.\n"
              "8. List the inbound edges of a given vertex.\n"
              "9. List the edges and their costs.\n"
              "10. Add a vertex.\n"
              "11. Remove a vertex.\n"
              "12. Add an edge.\n"
              "13. Remove an edge.\n"
              "14. Modify the cost of an edge.\n"
              "15. Get the in degree of a vertex.\n"
              "16. Get the out degree of a vertex.\n"
              "17. Check if there is an edge between two given vertices.\n"
              "18. Make a copy of the graph.\n"
              "19. Add an empty graph.\n"
              "20. Parse all the vertices.\n"
              "21. Find the lowest length path between two vertices.\n"
              "22. Find the lowest cost walk between two vertices using Ford's algorithm")

    def start(self):
        print("Welcome!")
        print("The current graph is an empty graph!")
        done = False
        self.add_empty_graph()
        while not done:
            try:
                self.print_menu()
                option = input("Choose an option from the menu: \n")
                if option == "0":
                    done = True
                    print("Good bye!")
                elif option == "1":
                    self.create_random_graph_ui()
                elif option =="2":
                    self.read_graph_from_file_ui()
                elif option =="3":
                    self.write_graph_to_file_ui()
                elif option =="4":
                    self.switch_graph_ui()
                elif option =="5":
                    self.get_number_of_vertices_ui()
                elif option == "6":
                    self.get_number_of_edges_ui()
                elif option =="7":
                    self.list_outbound()
                elif option =="8":
                    self.list_inbound()
                elif option =="9":
                    self.list_all_costs()
                elif option == "10":
                    self.add_vertex()
                elif option =="11":
                    self.delete_an_user_specified_vertex()
                elif option  =="12":
                    self.add_edge()
                elif option =="13":
                    self.remove_an_user_specified_edge()
                elif option =="14":
                    self.modify_cost_of_a_user_specified_edge()
                elif option =="15":
                    self.get_in_degree_of_user_specified_vertex()
                elif option =="16":
                    self.get_out_degree_of_user_specified_vertex()
                elif option =="17":
                    self.check_if_edge()
                elif option =="18":
                    self.copy_current_graph()
                elif option == "19":
                    self.add_empty_graph()
                elif option =="20":
                    self.parse_all_vertices()
                elif option=="21":
                    self.find_shortest_path_ui()
                elif option=="22":
                    self.minimum_cost_path_ui()
                else:
                    print("ERROR: Bad input!\n")
            except ValueError as ve:
                print(str(ve))
            except FileNotFoundError:
                print("ERROR: File not found!")


UI().start()