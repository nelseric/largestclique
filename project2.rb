require 'rubygems'
require 'rgl/adjacency'
require 'set'

def main
  graphs = parse
  graphs.each {|g| puts maximum_clique(g)}
  graphs.last.write_to_graphic_file('png','complex')
end

def maximum_clique( graph )
  if graph.edges.size > 0
    max = 2
  else
    max = 1
  end
#  cliques = []
  bron_kerbosch(graph,[],graph.vertices,[]) do
    |clique|
#    cliques.push clique
    if(clique.size > max)
      max = clique.size
    end
  end
#  cliques.sort_by!(){|c| c.size}
#  cliques.each {|c| puts c.to_a.to_s}
  return max
end

def bron_kerbosch(graph, r, p, x, &block)
  if p.empty? && x.empty?
    yield r
  end

  p.each do
    |v|
    bron_kerbosch(graph, r | [v],p & graph.adjacent_vertices(v),x & p & graph.adjacent_vertices(v), &block)
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