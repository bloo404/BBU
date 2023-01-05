from graphs import *

def start():
    # declaring the list for the clique
    # a clique is a subset of vertices of an undirected graph such that every two distinct vertices in the clique are adjacent/neighbours
    a_list_for_clique = list()

    # declaring the maximum element list
    max_elem = []

    # reading graph from file
    graph = read_from_file("graph.txt")

    # applying the Bron Kerbosch algorithm on the graph
    bronKerbosch(graph, [], set(graph.get_vertices()), set(), a_list_for_clique)

    # we memorize in max_elem list the list with maximum number of elements
    for elem in a_list_for_clique:
        if len(elem) > len(max_elem):
            max_elem = elem
    print(max_elem)

start()
