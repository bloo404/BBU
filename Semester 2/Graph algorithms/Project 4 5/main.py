from exceptions import *
from random import *
import copy

class DoubleListGraph():
    def __init__(self,n):
        self._dIn={}
        self._dOut={}
        self._dCosts={}
        for i in range(n):
            self._dIn[i]=[]
            self._dOut[i]=[]

    def appendToFile(self):
        '''
        appends modifications to file
        '''
        f=open("results.txt",'a')
        costs = self.parsedCosts()
        edges = self.parseKeysCosts()
        for ed in edges:
            line=str(ed[0]) + ' ' + str(ed[1]) + ' ' + str(costs[ed])
            f.write(line)
            f.write('\n')
        f.write('\n')
        f.close()

    def saveFile(self,filename):
        '''
        appends modifications to file
        '''
        f=open(filename,'w')
        costs = self.parsedCosts()
        edges = self.parseKeysCosts()
        for ed in edges:
            line=str(ed[0]) + ' ' + str(ed[1]) + ' ' + str(costs[ed])
            f.write(line)
            f.write('\n')
        f.write('\n')
        f.close()

    def parseKeys(self):
        return list(self._dOut.keys())

    def parseKeysCosts(self):
        return list(self._dCosts.keys())

    def parsedCosts(self):
        return self._dCosts

    def parsedIn(self):
        return self._dIn

    def parsedOut(self):
        return self._dOut

    def retdIn(self,v):
        return self._dIn[v]

    def retdOut(self,v):
        return self._dOut[v]

    def retdCosts(self,x,y):
        return self._dCosts[(x,y)]

    def isVertex(self,v):
        vertices=self.parseKeys()
        return v in vertices

    def isEdge(self,x,y):
        return y in self._dOut[x]

    def addEdge(self,x,y,c):
        if not self.isEdge(x,y):
            self._dIn[y].append(x)
            self._dOut[x].append(y)
            self._dCosts[(x,y)]=c
        else:
            raise ExistError()

    def modifEdge(self,x,y,c):
        if self.isEdge(x,y):
            self._dCosts[(x,y)]=c
        else:
            raise ExistError()

    def addVertex(self,v):
        if not self.isVertex(v):
            keys=self.parseKeys()
            last = keys[len(keys) - 1]
            while last!=v:
                self._dIn[last+1] = []
                self._dOut[last+1] = []
                last+=1
        else:
            raise ExistError()

    def removeEdge(self,x,y):
        if self.isEdge(x,y):
            del self._dCosts[(x,y)]
            self._dOut[x].remove(y)
            self._dIn[y].remove(x)
        else:
            raise ExistError()

    def removeVertex(self,v):
        if self.isVertex(v):
            for p in self.retdOut(v):
                del self._dCosts[(v,p)]
                self._dIn[p].remove(v)

            for p in self.retdIn(v):
                del self._dCosts[(p,v)]
                self._dOut[p].remove(v)
            del self._dOut[v]
            del self._dIn[v]
        else:
            raise ExistError()

    def restoreGraph(self,dIn,dOut,dCosts):
        self._dIn=copy.deepcopy(dIn)
        self._dOut=copy.deepcopy(dOut)
        self._dCosts=copy.deepcopy(dCosts)

    def numberOfEdges(self):
        return len(self._dCosts)

    def numberOfVertices(self):
        return len(self._dIn)

    def minTreeKruskal(self,mintree):
        mincost=0
        count=0

        tree = [0]*self.numberOfVertices()
        for x in self.parsedIn():
            tree[x] = x
        orderedEdges = sorted(self._dCosts.items(),key=lambda item: item[1])
        x=0
        while x<self.numberOfEdges() and count<self.numberOfVertices():
            edge=orderedEdges[x]
            v=tree[edge[0][0]]
            w=tree[edge[0][1]]
            if v!=w and (edge[0][1],edge[0][0]) not in mintree:
                mincost+=edge[1]
                count+=1
                mintree.append(edge[0])
                for y in self.parsedIn():
                    if tree[y]==w: tree[y]=v
            x+=1
        return mincost


class initGraph():
    def __init__(self,n,m,graph,filename):
        self.graph=graph(n)
        self._filename=filename
        self.__loadFile(filename,m)

    def __loadFile(self,filename,m):
        f = open(filename, 'r')
        line = f.readline()
        for i in range(m):
            line=f.readline()
            line=line.strip().split(" ")
            x=int(line[0])
            y=int(line[1])
            c=int(line[2])
            try:
                self.graph.addEdge(x,y,c)
                self.graph.addEdge(y,x,c)

            except:
                continue
        f.close()

class initRandomGraph():
    def __init__(self,n,m,graph,filename):
        self.graph=graph(n)
        self.__newGraph(n,m,filename)

    def __newGraph(self,n,m,filename):
        if m > n * n:
            f=open(filename,'w')
            f.write("Graph cannot be generated.")
            return
        i=0
        while i<m:
            x=randrange(0,n)
            y=randrange(0,n)
            c=randint(0,1000)
            if not self.graph.isEdge(x,y):
                self.graph.addEdge(x,y,c)
                i+=1
            self.graph.saveFile(filename)