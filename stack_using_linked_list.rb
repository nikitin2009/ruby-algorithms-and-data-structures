require "./linked_list"

class Stack
	def initialize
		@list = LinkedList.new
	end
	
	def push(a)
		@list.add(0, a)
	end
	
  def pop
    return false if @list.size == 0
		@list.remove(0)
	end
end
