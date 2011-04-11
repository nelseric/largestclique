require 'rubygems'
require 'rgl/adjacency'
require 'rgl/dot'

def main
  numV = 6
  edges = [['a',5],['a',2],[2,3],[3,'a'],[5,6],[6,3],[6,4],['a',4],['a',6],[4,5]]

  graph = RGL::DirectedAdjacencyGraph.new;
  edges.each {|e| graph.add_edge(e[0],e[1])}
  puts graph.edges.to_a.to_s
  graph.write_to_graphic_file('png', 'test')
end

main