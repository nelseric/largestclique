require 'rubygems'
require 'rgl/adjacency'
require 'rgl/dot'
require 'rgl/traversal'
require 'rgl/connected_components'

def main
  graphs = parse()
  i = 0
#  graphs.each {|g| g.write_to_graphic_file('png', "graphs/g#{g.size}")}
  graphs.each {|g| puts maximum_clique(g)}

end

def maximum_clique( graph )
  max = 1
  graph.each_vertex do
    |c|
    map = []
    va = graph.adjacent_vertices(c)
    graph.each_adjacent(c) do
      |av|
      vb = graph.adjacent_vertices(av) - [c]
      map = map | va & vb
    end
    map = map | [c]
    max = map.size if(map.size > max)
    puts "m: #{map}"
  end
  max
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