class TreeNode 
  attr_accessor :left
  attr_accessor :right
  attr_reader :value
  
  def initialize(value)
      @value = value
      @left = nil
      @right = nil
  end
end

def build_tree(ar, i)
  if(i >= ar.length || ar[i]==0)
      return nil
  end

  node = TreeNode.new(ar[i])
  node.left = build_tree(ar, 2*i+1)
  node.right = build_tree(ar, 2*i+2)
  return node
end