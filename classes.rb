class Player
  attr_accessor :name, :lives, :turn

  def initialize(name)
    @name = name
    @lives = 3
    @turn = false
  end
end

class Question
  attr_accessor :question, :answer

  def initialize()
    num1 = rand(1..20)
    num2 = rand(1..20)
    operations = [:+, :-, :*, :/].sample
    @question = "What does #{num1} #{operations} #{num2} equal?"
    @answer = num1.send(operations, num2)
  end
end

class Game

  def initialize()
    print "Enter name for player 1: "
    player1 = $stdin.gets.chomp
    @player1 = Player.new(player1)

    print "Enter name for player 2: "
    player2 = $stdin.gets.chomp
    @player2 = Player.new(player2)

    puts "Starting Game... remember to round down your answers"
  end

  def generateQuestion
    @newQuestion = Question.new
    puts "----- NEW ROUND -----"
    (@player1.turn) ? (puts "#{@player1.name}: #{@newQuestion.question}") : (puts "#{@player2.name}: #{@newQuestion.question}")
    checkAnswer
  end

  def nextTurn
    generateQuestion
  end

  def checkWinner
    if @player1.lives == 0
      puts "----- GAME OVER -----"
      puts "#{@player2.name} wins with #{@player2.lives}/3 lives remaining"
    elsif @player2.lives == 0
      puts "----- GAME OVER -----"
      puts "#{@player1.name} wins with #{@player1.lives}/3 lives remaining"
    else
      nextTurn
    end
  end

  def checkAnswer
    print "> "
    answer = gets.chomp.to_i
    if answer === @newQuestion.answer
      if @player1.turn
        puts "Correct!"
        @player1.turn = false
        @player2.turn = true
        puts "Lives remaining #{@player1.name}: #{@player1.lives}/3 #{@player2.name}: #{@player2.lives}/3"
        nextTurn
      else
        puts "Correct!"
        @player2.turn = false
        @player1.turn = true
        puts "Lives remaining #{@player2.name}: #{@player2.lives}/3 #{@player1.name}: #{@player1.lives}/3"
        nextTurn
      end
    else
      if @player1.turn
        puts "Wrong Answer!"
        @player1.turn = false
        @player2.turn = true
        @player1.lives -= 1
        puts "Lives remaining #{@player1.name}: #{@player1.lives}/3 #{@player2.name}: #{@player2.lives}/3"
        checkWinner
      else
        puts "Wrong Answer!"
        @player2.turn = false
        @player1.turn = true
        @player2.lives -= 1
        puts "Lives remaining #{@player2.name}: #{@player2.lives}/3 #{@player1.name}: #{@player1.lives}/3"
        checkWinner
      end
    end
  end
end