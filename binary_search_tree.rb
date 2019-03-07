class Node
  attr_reader :data
  attr_accessor :left, :right

  def initialize(data)
    @data = data
  end
end

class BinarySearchTree
  attr_reader :root

  def initialize(array)
    @root = Node.new(array.shift)
    add_nodes(root, array)
  end

  def insert_node(root, node)
    if root.data > node.data 
      
      if root.left.nil?
        root.left = node
      else
        insert_node(root.left, node)
      end
      
    else
      
      if root.right.nil?
        root.right = node
      else
        insert_node(root.right, node)
      end
      
    end
  end

  def pre_order
    pre_order_traversal(@root).strip
  end

  private
  def add_nodes(root, array)
    return nil if array.length == 0
    
    node = Node.new(array.shift)
    insert_node(root, node)
    add_nodes(root, array)
  end

  def pre_order_traversal(node)
    if node == nil
      return ''
    end
  
    result = "#{node.data} "
    result += pre_order_traversal(node.left)
    result += pre_order_traversal(node.right)
  end
end