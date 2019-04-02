class Graph
  attr_reader :v, :graph

  def initialize(vertices, graph)
    # No. of vertices
    @v = vertices
    # Hash representing all edges
    @graph = graph
  end

  # def add_edge(a, b)
  #   return false unless @graph.key?(a) && @graph.key?(b)
  #   @graph[a] << b
  #   @graph[b] << a
  # end

  def is_cyclic_util(v, visited, parent)
    visited << v

    # Recur for all adjacent vertices
    @graph[v].each do |adjacent|
      if visited.include?(adjacent) == false
        return true if self.is_cyclic_util(adjacent, visited, v)
      elsif parent != adjacent
        return true
      end
    end

    return false
  end

  def is_cyclic?
    # Recursive DFS used
    visited = []

    self.graph.keys.each do |v|
      if visited.include?(v) == false
        return true if self.is_cyclic_util(v, visited, -1)
      end
    end

    return false
  end

end

graph1 = Graph.new(6, {
  0=>[2], 
  1=>[4], 
  2=>[0, 5, 3], 
  3=>[5, 2], 
  4=>[5, 1], 
  5=>[4, 2, 3]
})

graph2 = Graph.new(5, {
  0=>[2], 
  1=>[2], 
  2=>[0, 1, 3, 4, 5], 
  3=>[2], 
  4=>[2]
})

puts graph1.is_cyclic? # => true
puts graph2.is_cyclic?# => false