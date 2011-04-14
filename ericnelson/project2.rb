require 'rubygems'
require 'rgl/adjacency'

def main
  graphs = parse
  graphs.each {|g| puts maximum_clique(g)}
end

def maximum_clique( graph )
  if graph.edges.size > 0
    max = 2
  else
    if(graph.size == 0)
      max = 0
    else
      max = 1
    end
  end
  cliques(graph,[],graph.vertices,[]) do
    |clique|
    if(clique.size > max)
      max = clique.size
    end
  end
  return max
end

def cliques(graph, r, p, x, &block)
  if p.empty? && x.empty?
    yield r
    return
  end
  p.each do
    |v|
    cliques(graph, r | [v],p & graph.adjacent_vertices(v),x & p & graph.adjacent_vertices(v), &block)
    p = p - [v]
    x = x | [v]
  end
end

def parse
  numCases = gets.chomp.to_i
  cases = []
  (1..numCases).each do
    |i|
    edges = []
    numVertices = gets.chomp.to_i
    while true
      pair = Array.new
      gets.chomp.split(' ').each {|a| pair.push(a.to_i)}
      break if pair == [0,0]
      edges.push pair
    end
    caseGraph = RGL::AdjacencyGraph.new
    edges.each {|e| caseGraph.add_edge(e[0],e[1]) unless e[0] == e[1]}
    cases.push(caseGraph)
  end
  cases
end

main