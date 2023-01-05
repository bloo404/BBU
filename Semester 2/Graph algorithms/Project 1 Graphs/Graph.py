import copy
class GraphException(Exception):
    pass

class Graph:
    def __init__(self, nr=0):
        """
        Constructor for the graph class
        :param nr: the number of vertices
        """
        self._out_vertices = dict()         #The dictionary of out vertices
        self._in_vertices = dict()          #The dictionary of in vertices
        self._cost = dict()                 #The dictionary of edge costs
        for i in range(0, nr): # we initialize them as lists
            self._out_vertices[i] = list()
            self._in_vertices[i] = list()

    def __copy__(self):
        # makes a deepcopy when it copies the graph
        return copy.deepcopy(self)

    def get_number_of_vertices(self):
        """
        Getter for the number of vertices
        :return: int(number of vertices)
        """
        return len(self._out_vertices)

    def get_number_of_edges(self):
        """
        Getter for the number of edges
        :return: int(number of edges)
        """
        return len(self._cost)

    def iterate_vertices(self):
        """
        Iterates through the vertices
        """
        for v in self._out_vertices:
            yield v

    def check_vertex(self, x):
        """
        Checks if there is a vertex in the graph
        :param x:
        """
        return x in self._out_vertices

    def check_edge(self, x, y):
        """
        Verifies if there is an edge between x and y
        :param x: the start point of the edge
        :param y: the end point of the edge
        :return: true, if the edge exists, false otherwise
        """
        return y in self._out_vertices[x]

    def in_degree(self, x):
        """
        getter for the IN DEGREE
        :param x: a vertex (we want to see the degree of)
        :return: The in degree of vertex x
        """
        if x not in self._out_vertices:
            raise GraphException("<< NO VERTEX FOUND >>")
        return len(self._in_vertices[x])

    def out_degree(self, x):
        """
        getter for the OUT DEGREE
        :param x: a vertex (we want to see the degree of)
        :return: The out degree of vertex x
        """
        if x not in self._out_vertices:
            raise GraphException("<< NO VERTEX FOUND >>")
        return len(self._out_vertices[x])

    def add_vertex(self, x):
        """
        Adds a vertex to the graph
        :param x: the vertex we want to be added
        """
        if x in self._out_vertices:
            raise GraphException("<< VERTEX ALREADY EXISTS >>")
        self._out_vertices[x] = list()
        self._in_vertices[x] = list()

    def iterate_out(self, x):
        """
        Iterates through the vertices x had an edge to
        :param x: the vertex
        """
        if x not in self._out_vertices:
            raise GraphException("<< NO VERTEX FOUND >>")
        for i in self._out_vertices[x]:
            yield i

    def iterate_in(self, x):
        """
        Iterates through the vertices that have an edge to x
        :param x: the vertex
        """
        if x not in self._out_vertices:
            raise GraphException("<< NO VERTEX FOUND >>")
        for i in self._in_vertices[x]:
            yield i

    def iterate_edge(self):
        """
        Iterates through the edges of the graph
        """
        for i in self._cost:
            yield i[0], i[1], self._cost[i]

    def add_edge(self, x, y, cost=0):
        """
        Adds an edge to the graph
        :param x: the out edge
        :param y: the in edge
        :param cost: the cost of the edge

        """
        if self.check_edge(x, y):
            raise GraphException("<< THE EDGE ALREADY EXISTS >>")
        self._out_vertices[x].append(y)
        self._in_vertices[y].append(x)
        self._cost[(x, y)] = cost

    def remove_edge(self, x, y):
        """
        Removes an edge from the graph
        :param x: in vertex
        :param y: out vertex
        """
        if not self.check_edge(x, y):
            raise GraphException("<< THE EDGE WAS NOT FOUND >>")
        self._out_vertices[x].remove(y)
        self._in_vertices[y].remove(x)
        self._cost.pop((x, y))

    def get_edge_cost(self, x, y):
        """
        Edge cost getter
        :param x: out vertex
        :param y: int vertex
        :return: the cost of the edge from vertex to vertex y
        """
        if not self.check_edge(x, y):
            raise GraphException("<< THE EDGE WAS NOT FOUND >>")
        return self._cost[(x, y)]

    def set_edge_cost(self, x, y, cost):
        """
        Edge cost setter, sets the cost of the edge from vertex to vertex y
        :param x: out vertex
        :param y: in vertex
        :param cost: new cost
        """
        if not self.check_edge(x, y):
            raise GraphException("<< EDGE WAS NOT FOUND >>")
        self._cost[(x, y)] = cost

    def remove_vertex(self, x):
        """
        Removes a vertex from the graph
        :param x: the vertex we want to remove from the graph
        """
        if x not in self._out_vertices:
            raise GraphException("<< NO VERTEX FOUND >")
        for i in self.iterate_vertices():
            if self.check_edge(x, i):
                self._in_vertices[i].remove(x)
                self._cost.pop((x, i))
            if self.check_edge(i, x):
                self._out_vertices[i].remove(x)
                self._cost.pop((i, x))
        self._out_vertices.pop(x)
        self._in_vertices.pop(x)
