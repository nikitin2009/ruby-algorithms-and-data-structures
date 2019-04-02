class Vertex
  attr_accessor :value, :children, :parent

  def initialize(value)
    @value = value
    @children = Set[]
  end
end

class MapGraph
  attr_accessor :zones

  # Takes two dimentional array as an argument
  def initialize(map)
    @size = map.length
    @vertices = build_verices(map)
    @graph = build_graph_from_map(map, @vertices)
    build_child_parent_relations(@graph)
    # Peaks are vertices which don't have parent
    @peaks = @graph.keys.reject(&:parent)
    @zones = count_zones(@peaks)
  end

  def build_verices(map)
    vertices = []
    for i in (0...@size) do
      for j in (0...@size) do
        vertices << Vertex.new(map[i][j])
      end
    end
    vertices
  end

  def build_graph_from_map(map, vertices)
    graph = {}
    index = 0

    for i in (0...@size) do
      for j in (0...@size) do
        vertex = vertices[index]
        # Add adjacent vertices
        graph[vertex] = []
        # horizontal
        unless j == 0
          left = vertices[index-1]
          graph[vertex] << left
        end
        unless j == @size-1
          right = vertices[index+1]
          graph[vertex] << right
        end
        # vertical
        unless i == 0
          top = vertices[index-@size]
          graph[vertex] << top
        end
        unless i == @size-1
          bottom = vertices[index+@size]
          graph[vertex] << bottom
        end
        index += 1
      end
    end

    graph
  end

  def build_child_parent_relations(graph)
    graph.each do |vertex, adjacents|
      # Find adjacent with the greatest value
      greatest_adj = adjacents.max_by(&:value)
      # If the vertex is greater than the greates adjacent, than it is a peak,
      # and the adjacent belongs to it;
      # Otherwise the vertex belongs to the gratest adjacent
      if vertex.value > greatest_adj.value
        next if greatest_adj.parent
        vertex.children << greatest_adj
        greatest_adj.parent = vertex
      else
        greatest_adj.children << vertex
        vertex.parent = greatest_adj
      end
    end
  end

  def count_zones(peaks)
    zones = []

    peaks.each do |peak|
      visited = []
      queue = [peak]

      while queue.length > 0 do
        vertex = queue.shift
        visited << vertex
        vertex.children.each do |child|
          unless visited.include?(child)
            queue << child
          end
        end
      end

      zones << visited.length

    end

    zones

  end

end

def greatest_peaks(map)
  
  map_graph = MapGraph.new(map)
  
  [map_graph.zones.min, map_graph.zones.max]
end



p greatest_peaks(
  [
    [9, 8, 5], 
    [5, 6, 3], 
    [8, 4, 1]
  ]
)
# => [3, 6]

p greatest_peaks(
  [
    [8, 12], 
    [9, 3]
  ]
)
# => [1, 3]