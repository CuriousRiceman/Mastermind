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
            user_input_valid = false
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
            user_input_valid == true
        else
            puts "Computer is the mastermind. You are the code breaker. "
            @code = COLORS.sample(4)
            p code
        end
    end

end

class CodeBreaker
    include COLORS

    attr_accessor :who_is_the_codebreaker, :code_guessed

    def initialize(player_or_computer)
        @who_is_the_codebreaker = player_or_computer
        @code_guessed = Array.new(4)
        @rounds = 10
    end

    def solve()

    end

    def guess(code)
        for i in 1..@rounds
            if player_or_computer == "Player"
                user_input_valid = false
                puts "You are the mastermind. Computer is the code breaker.\n "
                puts "Given these options: "
                puts "(R) Red, (B) Blue, (O) Orange, (Y) Yellow, (G) Green, (P) Purple\n "
                @code_guessed.each_with_index do |_, slot|
                    loop do
                        puts "Choose a color for slot #{slot + 1}: "
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
                    guessed = true
                else
                    array_hint = Array.new(4, " ")
                    @code_guessed.each_with_index do |value, slot|
                        if @code_guessed[slot] == code[slot]
                            array_hint[slot] >> "B"
                        elsif code.include?(@code_guessed[slot])
                            array_hint[slot] >> "W"
                        end
                    end
                    puts "Round#{i}: (#{@code_guessed[0]}) (#{@code_guessed[1]}) (#{@code_guessed[2]}) (#{@code_guessed[3]})"
                    if black.length != 0

                end
                
            else
                #computer solving algorithm
            end
            i++
        end

    end




end

class Play
    attr_accessor :player, :computer

    ROUNDS = 10

    def initialize()
        loop do
            puts "Do you want to be the (1) mastermind or (2) code breaker? "
            role_num = gets.chomp.to_i
            if (1..2).include?(role_num)
                if role_num == 1
                    @player = Mastermind.new("Player")
                    @computer = CodeBreaker.new("Computer")
                else
                    @computer = Mastermind.new("Computer")
                    @player = CodeBreaker.new("Player")
                    player.guess
                end
                break
            else
                puts "Invalid input, try again"
            end
        end
    end
                
end

play = Play.new
