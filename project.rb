#require 'rubygems'
require 'rgl/adjacency'
require 'rgl/implicit'
require 'rgl/dot'
require 'set'

def main
  graphs = parse()
  i = 0
#  graphs.each {|g| g.write_to_graphic_file('png', "g#{g.size}")}
  graphs.each {|g| puts "M:#{maximum_clique(g)}"}

end

def maximum_clique( graph )
  if graph.vertices.size > 0
    max = 2
  else
    max = 1
  end
  prune_n_degree_vertices(graph,1) # these vertices can only be a part of a 2-clique
  

  return max
end

def prune_n_degree_vertices(graph, n)
  changed = true
  while changed
    changed = false
    graph.each_vertex do
      |v|
      if graph.adjacent_vertices(v).size <= n
        puts v
        changed = true
        graph.remove_vertex(v)
      end
    end
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
    edges.each {|e| caseGraph.add_edge(e[0],e[1])}
    cases.push(caseGraph)
  end
  cases
end

main