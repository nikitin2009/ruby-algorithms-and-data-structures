class Vertex
  attr_accessor :value, :coordinates

  def initialize(value, coordinates)
    @value = value
    @coordinates = coordinates
  end
end

class MapGraph
  attr_accessor :vertices, :graph

  # Takes two dimentional array as an argument
  def initialize(map)
    @size = map.length
    @vertices = build_verices(map)
    @graph = build_graph_from_map(map, @vertices)
  end

  def build_verices(map)
    vertices = []
    for i in (0...@size) do
      for j in (0...@size) do
        value = map[i][j]
        coordinates = [j, i]
        vertices << Vertex.new(value, coordinates)
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
        # No edges for "1" vertices, they are walls
        if vertex.value == 1
          index += 1
          next
        end
        # Add adjacent vertices
        graph[vertex] = []
        # horizontal
        unless j == 0
          left = vertices[index-1]
          graph[vertex] << left unless left.value == 1
        end
        unless j == @size-1
          right = vertices[index+1]
          graph[vertex] << right unless right.value == 1
        end
        # vertical
        unless i == 0
          top = vertices[index-@size]
          graph[vertex] << top unless top.value == 1
        end
        unless i == @size-1
          bottom = vertices[index+@size]
          graph[vertex] << bottom unless bottom.value == 1
        end
        index += 1
      end
    end

    graph
  end

  def shortest_path(start, goal)
    # Immediate predessor for each vertex in BFS from start vertex
    predessors = {}

    # Do BFS from start untill the goal is reached;
    # Add predessors for each vertex;
    visited = []
    queue = [start]

    while queue.length > 0 do
      vertex = queue.shift
      break if vertex == goal
      visited << vertex
      @graph[vertex].each do |adjacent|
        unless visited.include?(adjacent)
          predessors[adjacent] = vertex
          queue << adjacent
        end
      end
    end

    build_path(start, goal, predessors)

  end

  def build_path(start, goal, predessors)
    path = []
    current_vertex = goal

    until current_vertex == start do
      path << current_vertex.coordinates
      current_vertex = predessors[current_vertex]
    end

    path << current_vertex.coordinates
    path.reverse
  end

end


def maze_escape(maze)
  map_graph = MapGraph.new(maze)
  start = map_graph.vertices[0]
  goal = map_graph.vertices.select{ |v| v.value == 9 }[0]
  map_graph.shortest_path(start, goal)
end

p maze_escape(
  [
    [0, 0, 0, 0, 0], 
    [0, 1, 0, 1, 0], 
    [0, 1, 0, 1, 1], 
    [0, 1, 0, 0, 0], 
    [0, 0, 0, 1, 9]
  ]
)
# => [ 
#      [0, 0],
#      [1, 0],
#      [2, 0],
#      [2, 1],
#      [2, 2],
#      [2, 3],
#      [3, 3],
#      [4, 3],
#      [4, 4]
#    ]
