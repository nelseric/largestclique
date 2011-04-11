require 'rubygems'
require 'rgl/adjacency'
require 'rgl/dot'
require 'rgl/traversal'

def main
  graphs = parse()
  i = 0
  graphs.each {|g| g.write_to_graphic_file('png', "graphs/g#{++i}")}
  graphs.each {|g| puts maximum_clique(g)}

end

def maximum_clique( graph )
  max = 1
  graph.each_connected_component do
    |c|
    if c.size > max
      max = c.size
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