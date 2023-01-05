import copy


class TripleDictGraph:
    def __init__(self, number_of_vertices, number_of_edges):
        """
        Function to initialise a graph
        :param number_of_vertices: the number of verticies of the graph
        :param number_of_edges: the number of edges of the graph
        """
        self._number_of_vertices = number_of_vertices
        self._number_of_edges = number_of_edges
        self._dictionary_in = {}
        self._dictionary_out = {}
        self._dictionary_cost = {}
        for index in range(number_of_vertices):
            self._dictionary_in[index] = []
            self._dictionary_out[index] = []

    @property
    def dictionary_cost(self):
        return self._dictionary_cost

    @property
    def dictionary_in(self):
        return self._dictionary_in

    @property
    def dictionary_out(self):
        return self._dictionary_out

    @property
    def number_of_vertices(self):
        return self._number_of_vertices

    @property
    def number_of_edges(self):
        return self._number_of_edges

    def parse_vertices(self):
        """
        Function to parse through the vertices of the graph. We take the verticies from the keys of the dictionary of the edges that enter each node
        """
        vertices = list(self._dictionary_in.keys())
        for v in vertices:
            yield v

    def parse_inbound(self, x):
        """
        Function to parse through the edges that enter a specific node
        :param x: the node for which we get all the vertices that enter it
        """
        for y in self._dictionary_in[x]:
            yield y

    def parse_outbound(self, x):
        """
        Function to parse through the edges that exit a specific node
        :param x: the node for whitch we get all the vertices that exit it
        """
        for y in self._dictionary_out[x]:
            yield y

    def parse_cost(self):
        """
        Function to parse through each edge and get the value attributed to it
        :return:
        """
        keys = list(self._dictionary_cost.keys())
        for key in keys:
            yield key

    def add_vertex(self, x):
        """
        Function to add a new vertex to the graph.
        :param x: the vertex
        :return:If the vertex is already in use we return False, otherwise we add it to each list and return True
        """
        if x in self._dictionary_in.keys() and x in self._dictionary_out.keys():
            return False
        self._dictionary_in[x] = []
        self._dictionary_out[x] = []
        self._number_of_vertices += 1
        return True

    def remove_vertex(self, x):
        """
        Function to delete a vertex from the graph.
        :param x: the vertex to be deleted
        :return: If the vertex is not in use we return False, otherwise we delete all of its appearences and return True
        """
        if x not in self._dictionary_in.keys() and x not in self._dictionary_out.keys():
            return False
        self._dictionary_in.pop(x)
        self._dictionary_out.pop(x)

        for key in self._dictionary_in.keys():
            if x in self._dictionary_in[key]:
                self._dictionary_in[key].remove(x)
            elif x in self._dictionary_out[key]:
                self._dictionary_out[key].remove(x)

        keys = list(self._dictionary_cost.keys())
        for key in keys:
            if key[0] == x or key[1] == x:
                self._dictionary_cost.pop(key)
                self._number_of_edges -= 1
        self._number_of_vertices -= 1
        return True

    def in_degree(self, x):
        """
        Function to get the number of edges that enter a specific node
        :param x: the node
        :return: the number of edges that enter it or -1 if the node does not exist
        """
        if x not in self._dictionary_in.keys():
            return -1
        return len(self._dictionary_in[x])

    def out_degree(self, x):
        """
        Function to get the number of edges that exit a specific node
        :param x: the node
        :return: the number of edges that exit it or -1 if the node does not exist
        """
        if x not in self._dictionary_out.keys():
            return -1
        return len(self._dictionary_out[x])

    def add_edge(self, x, y, cost):
        """
        Function to add a new edge
        :param x: the start of the edge
        :param y: the end of the edge
        :param cost: the value attributed to the edge
        :return: False if the edge already exists and True if we could add it
        """
        if x in self._dictionary_in[y]:
            return False
        elif y in self._dictionary_out[x]:
            return False
        elif (x, y) in self._dictionary_cost.keys():
            return False
        self._dictionary_in[y].append(x)
        self._dictionary_out[x].append(y)
        self._dictionary_cost[(x, y)] = cost
        self._number_of_edges += 1
        return True

    def remove_edge(self, x, y):
        """
        Function to delete an edge
        :param x: the starting point of the edge
        :param y: the ending point of the edge
        :return: False if it does not exist and True if we deleted it
        """
        if x not in self._dictionary_in.keys() or y not in self._dictionary_in.keys() or x not in self._dictionary_out.keys() or y not in self._dictionary_out.keys():
            return False
        if x not in self._dictionary_in[y]:
            return False
        elif y not in self._dictionary_out[x]:
            return False
        elif (x, y) not in self._dictionary_cost.keys():
            return False
        self._dictionary_in[y].remove(x)
        self._dictionary_out[x].remove(y)
        self._dictionary_cost.pop((x, y))
        self._number_of_edges -= 1
        return True

    def find_if_edge(self, x, y):
        """
        Function to check if between x and y there is an edge
        :param x: the starting point of the edge
        :param y: the end point of the edge
        :return: the cost of the edge if there is an edge between them or False if there is no edge between them
        """
        if x in self._dictionary_in[y]:
            return self._dictionary_cost[(x, y)]
        elif y in self._dictionary_out[x]:
            return self._dictionary_cost[(x, y)]
        return False

    def change_cost(self, x, y, cost):
        """
        Function to change the value of the cost of the edge
        :param x: the starting point of the edge
        :param y: the ending point of the edge
        :param cost: the new value
        :return: if there is no edge between x and y we return False or True otherwise
        """
        if (x, y) not in self._dictionary_cost.keys():
            return False
        self._dictionary_cost[(x, y)] = cost
        return True

    def make_copy(self):
        """
        Function to make a copy of the graph
        :return:
        """
        return copy.deepcopy(self)

    def findLowestLengthPathBFS(self, start, end):
        '''
        find the lowest length path between start and end, in graph, using a forward BFS from the starting vertex
        if start or end are not valid vertices in the graph, we raise ValueError
        if there is no path between start and end, we raise ValueError
        :param self: the current graph
        :param start: the starting vertex
        :param end: the ending vertex
        :return: returns the path from start to end if it exists, otherwise it raises ValueError
        '''
        # if the start or end are not valid, we raise ValueError
        if start < 0 or end < 0 or start >=self.number_of_vertices or end >= self.number_of_vertices:
            raise ValueError("invalid start / end!")
        if start == end:
            return []  # case when start = end, the path is empty

        # we remember all the visited nodes
        visited = []
        # we remember all the possible paths in a queue
        queue = [[start]]

        while queue:  # while we have paths unchecked
            # we pop the first path from the queue
            path = queue.pop(0)
            # we get the last node in the path
            vertex = path[-1]

            # if the vertex is not visited, for each of its outbound vertex, we create a new path from the
            # previous one by adding the outbound vertex. If the outbound vertex coincides with the end vertex
            # we return the path we just created

            if vertex not in visited:
                outboundVertices = self.dictionary_out[vertex]
                for outbound in outboundVertices:
                    newPath = list(path)
                    newPath.append(outbound)
                    queue.append(newPath)
                    if outbound == end:
                        return newPath
                # we add the vertex to the list of visited vertices
                visited.append(vertex)
        # if we got there means we've visited all vertices that can be visited from start, and we couldn't find
        # a path between start and end, so we raise a ValueError
        raise ValueError("No path between start and end")

    def minimum_cost_path(self, vertex_begin, vertex_end):
        """
        Compute the minimum cost path of a graph from a vertex to another
        :param vertex_begin: first vertex
        :param vertex_end: second vertex
        :return: the cost of the minimum cost path
        """
        dist = {}  # dictionary that associates to each accessible vertex the cost of the minimum cost walk
        # from begin to end
        pred = {}  # dictionary that associates to each accessible vertex its predecessor on the path
        inf = float('inf')
        vertices = list(self._dictionary_in.keys())
        for vertex in vertices:
            dist[vertex] = inf  # initialise all the distances as infinite
            pred[vertex] = -1
        dist[vertex_begin] = 0
        changed = True
        while changed:
            changed = False
            for (x, y) in self._dictionary_cost.keys():  # for every edge, check if the distance is minimum
                # if it is, added to the path and update the distance to the vertex y from the starting vertex
                if dist[y] > dist[x] + self._dictionary_cost[(x, y)] and dist[x] != inf:
                    dist[y] = dist[x] + self._dictionary_cost[(x, y)]
                    pred[y] = x
                    changed = True
        # the algorithm stops when all the edges are checked and all the distances from the starting vertex are min

        # check for negative weight cycles
        # if we get a shorter path, then there is a cycle
        for (x, y) in self._dictionary_cost.keys():
            if dist[y] > dist[x] + self._dictionary_cost[(x, y)] and dist[x] != inf:
                raise Exception("Graph contains a negative weight cycle!")

        # compute the path backwards from the end vertex
        path = []
        vertex = vertex_end
        path.append(vertex)
        while pred[vertex] != -1:
            path.append(pred[vertex])
            vertex = pred[vertex]
        return dist[vertex_end], path


def write_graph_to_file(graph, file):
    """
    Function to writte the graphn to the given file
    :param graph: the created graph
    :param file: the name of the file
    :return:
    """
    file = open(file, "w")
    first_line = str(graph.number_of_vertices) + ' ' + str(graph.number_of_edges) + '\n'
    file.write(first_line)
    if len(graph.dictionary_cost) == 0 and len(graph.dictionary_in) == 0:
        raise ValueError("There is nothing that can be written!")
    for edge in graph.dictionary_cost.keys():
        new_line = "{} {} {}\n".format(edge[0], edge[1], graph.dictionary_cost[edge])
        file.write(new_line)
    for vertex in graph.dictionary_in.keys():
        if len(graph.dictionary_in[vertex]) == 0 and len(graph.dictionary_out[vertex]) == 0:
            new_line = "{}\n".format(vertex)
            file.write(new_line)
    file.close()


def read_graph_from_file(filename):
    """
    Function to read a graph from file
    :param filename: the name of the file from where we read
    :return:
    """
    file = open(filename, "r")
    line = file.readline()
    line = line.strip()
    vertices, edges = line.split(' ')
    graph = TripleDictGraph(int(vertices), int(edges))
    line = file.readline().strip()
    while len(line) > 0:
        line = line.split(' ')
        if len(line) == 1:
            graph.dictionary_in[int(line[0])] = []
            graph.dictionary_out[int(line[0])] = []
        else:
            graph.dictionary_in[int(line[1])].append(int(line[0]))
            graph.dictionary_out[int(line[0])].append(int(line[1]))
            graph.dictionary_cost[(int(line[0]), int(line[1]))] = int(line[2])
        line = file.readline().strip()
    file.close()
    return graph