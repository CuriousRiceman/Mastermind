module Colors
    COLORS = ["R", "B", "O", "Y", "G", "P"]
    FEEDBACK_COLORS = ["W", "B"]
end

class Mastermind
    include Colors

    attr_accessor :who_is_the_mastermind, :code

    def initialize(player_or_computer)
        @who_is_the_mastermind = player_or_computer
        @code = Array.new(4)
        if player_or_computer == "Player"
            puts "You are the mastermind. Computer is the code breaker. "
            @code.each_with_index do |_, slot|
                loop do
                    puts "Given these options: "
                    puts "(R) Red, (B) Blue, (O) Orange, (Y) Yellow, (G) Green, (P) Purple "
                    puts "Choose a color for slot #{slot + 1}: "
                    color = gets.chomp.upcase
                    if COLORS.include?(color)
                        @code[slot] = color
                        break
                    else
                        puts "Invalid color! Please choose a valid color."
                    end
                end
            end
            puts "\nSelected colors: #{@code.join(', ')}"
        else
            puts " "
            puts "Computer is the mastermind. You are the code breaker. "
            @code = COLORS.sample(4)
            # p code used for debugging
        end
    end

end

class CodeBreaker
    include Colors

    attr_accessor :who_is_the_codebreaker, :code_guessed

    def initialize(player_or_computer)
        @who_is_the_codebreaker = player_or_computer
        @code_guessed = Array.new(4)
        @rounds = 12
    end

    def solve()

    end

    def guess(code)
        if @who_is_the_codebreaker == "Player"
            user_input_valid = false
            puts "Given these options: "
            puts "(R) Red, (B) Blue, (O) Orange, (Y) Yellow, (G) Green, (P) Purple\n "
            for i in 1..@rounds
                @code_guessed.each_with_index do |_, slot|
                    loop do
                        puts "Choose a color for slot #{slot + 1} (NO REPEATING COLORS): "
                        color = gets.chomp.upcase
                        if COLORS.include?(color)
                            @code_guessed[slot] = color
                            break
                        else
                            puts "Invalid color! Please choose a valid color."
                        end
                    end
                end
                if @code_guessed == code
                    puts "You win!"
                    Play.play_again?
                    break
                else
                    array_hint = Array.new(4, " ")
                    @code_guessed.each_with_index do |value, slot|
                        if @code_guessed[slot] == code[slot]
                            array_hint[slot] = "B"
                        elsif code.include?(@code_guessed[slot])
                            array_hint[slot] = "W"
                        end
                    end
                    puts "Round#{i}: (#{@code_guessed[0]}) (#{@code_guessed[1]}) (#{@code_guessed[2]}) (#{@code_guessed[3]})"
                    array_hint_sorted = array_hint.sort_by { |element| ["B", "W", " "].index(element) || 3 }
                    puts "Hints: (#{array_hint_sorted[0]}) (#{array_hint_sorted[1]}) (#{array_hint_sorted[2]}) (#{array_hint_sorted[3]})"
                    puts " "
                    if i == 12
                        puts "Computer wins! You lose!"
                        Play.play_again?
                    end
                end
            end
        else #Computer solving algorithm
            colors = COLORS
            for i in 1..@rounds
                @code_guessed = colors.sample(4)
                if @code_guessed == code
                    puts "Computer wins!"
                    Play.play_again?
                    break
                else
                    array_hint = Array.new(4, " ")
                    @code_guessed.each_with_index do |value, slot|
                        if @code_guessed[slot] == code[slot]
                            array_hint[slot] = "B"
                        elsif code.include?(@code_guessed[slot])
                            array_hint[slot] = "W"
                        else 
                            colors.delete(@code_guessed[slot]) #deletes the color so chances of guessing correctly increases
                        end 
                    end
                    puts "Round#{i}: (#{@code_guessed[0]}) (#{@code_guessed[1]}) (#{@code_guessed[2]}) (#{@code_guessed[3]})"
                    array_hint_sorted = array_hint.sort_by { |element| ["B", "W", " "].index(element) || 3 }
                    puts "Hints: (#{array_hint_sorted[0]}) (#{array_hint_sorted[1]}) (#{array_hint_sorted[2]}) (#{array_hint_sorted[3]})"
                    puts " "
                    if i == @rounds
                        puts "Player wins! Computer loses!"
                        Play.play_again?
                    end
                end
            end
            
        end
            
    end
end


class Play
    attr_accessor :player, :computer

    def self.setup_game()
        loop do
            puts "Do you want to be the (1) mastermind or (2) code breaker? "
            role_num = gets.chomp.to_i
            if (1..2).include?(role_num)
                if role_num == 1
                    @player = Mastermind.new("Player")
                    @computer = CodeBreaker.new("Computer")
                    @computer.guess(@player.code)
                else
                    @computer = Mastermind.new("Computer")
                    @player = CodeBreaker.new("Player")
                    @player.guess(@computer.code)
                end
                break
            else
                puts "Invalid input, try again"
            end
        end
    end

    def self.play_again?
        loop do
          puts "Do you want to play again? (Y/N)"
          answer = gets.chomp.upcase
          if answer == "N"
            puts "Thanks for playing! Goodbye."
            break
          elsif answer == "Y"
            setup_game
            break
          else
            puts "Invalid input, please enter 'Y' or 'N'."
          end
        end
    end
end

Play.setup_game