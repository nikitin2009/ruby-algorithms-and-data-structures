require "./stack_using_linked_list"

def inorder_traversal(tree)
  current = tree
  stack = Stack.new
  done = false
  
  until done
    unless current.nil?
      stack.push(current)
      current = current.left
    else
      if stack.size > 0
        current = stack.pop
        puts current.value
        current = current.right
      else
        done = true
      end
    end
  end
end