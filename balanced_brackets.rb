require "./stack_using_linked_list"

def balanced_brackets?(string)
  brackets = {
    "[" => "sqare",
    "]" => "sqare",
    "{" => "curly",
    "}" => "curly",
    "(" => "round",
    ")" => "round"
  }
  opening_brackets = ["[", "{", "("]
  closing_brackets = ["]", "}", ")"]
  stack = Stack.new
  
  string.split("").each do |i|
    if closing_brackets.include?(i)
      return false if brackets[i] != stack.pop
    elsif opening_brackets.include?(i)
      stack.push(brackets[i])
    end
  end
  
  is_left_unclosed = stack.pop
  
  is_left_unclosed ? false : true
end
