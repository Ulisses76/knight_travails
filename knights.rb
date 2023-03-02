class GraphNode
  attr_accessor :value, :neighborns  
  def initialize(value, neighborn)
    @value = value
    @neighborns = neighborn    
  end
end

class Graph
  attr_accessor :node
  def initialize
    @node = []
  end

  def add_node(node)
    @node << GraphNode.new(node, find_neighborns(node))
  end

  def make_tree(node)
    queue, visited = [], []
    queue << node    
    until queue.empty?
      vertice = queue.shift
      if !visited.any?(vertice)
        self.add_node(vertice)
        visited << vertice
        queue += find_neighborns(vertice)
      end
    end
  end

  def prev_mov
    prev = {}
    self.node.reverse.each do |elem|
      node = elem.value
      neighborns = elem.neighborns
      neighborns.each { |neigh| prev[neigh] = node }
    end
    prev
  end
  
  def path(start, final)
    path = []
    prevs = self.prev_mov
    @node.size.times do
      path.unshift(final)
      prev = prevs[final]
      if prev == start
        path.unshift(start)
        break
      end
      final = prev
    end
    path
  end

  def find_neighborns(node)
    neighborns = []
    (x,y) = node    
    neighborns << [x + 2, y + 1] if y + 1 < 8 && x + 2 < 8
    neighborns << [x + 1, y + 2] if y + 2 < 8 && x + 1 < 8
    neighborns << [x - 1, y + 2] if y + 2 < 8 && x - 1 >= 0
    neighborns << [x - 2, y + 1] if y + 1 < 8 && x - 2 >= 0
    neighborns << [x - 2, y - 1] if y - 1 >= 0 && x - 2 >= 0
    neighborns << [x - 1, y - 2] if y - 2 >= 0 && x - 1 >= 0
    neighborns << [x + 1, y - 2] if y - 2 >= 0 && x + 1 < 8
    neighborns << [x + 2, y - 1] if y - 1 >= 0 && x + 2 < 8
    neighborns
  end
end

class KnightsTravails

  def initialize
    self.instructions
    puts "enter the start point:"
    start = gets.chomp.split ","
    start.map! {|x| x.to_i}
    puts "\nenter the final point"
    final = gets.chomp.split ","
    final.map! {|x| x.to_i}
    self.knights_movs(start, final)
    
    puts "\n\n Do you like to play again?"
    asw = gets.chomp
    KnightsTravails.new if asw == "y"
  end

  def knights_movs(start, final)
    game = Graph.new
    game.make_tree(start)
    result = game.path(start, final)
    
    puts "\n\nKnight moves #{start} , #{final}"
    puts "\nYou made it in #{result.size - 1} moves! Here's your path:\n\n"
    pprint(result)
  end
    
  def pprint(array)
    list = ""
    array.each {|elem| list += "#{elem}" + " --> "}
    puts list[0...-5]
  end

  def instructions
    puts "\n\n\n###################################################"
    puts "##########  Welcome to Knights Travails ###########"
    puts "###################################################"
    puts "\n\n"
  end
end

KnightsTravails.new
