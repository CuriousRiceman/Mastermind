module Colors
    COLORS = ["R", "B", "O", "Y", "G", "P"]
    FEEDBACK_COLORS = ["W", "B"]
end

class Mastermind
    include Colors

    attr_accessor :who_is_the_mastermind

    def initialize(player_or_computer)
        @who_is_the_mastermind = player_or_computer
        @code = Array.new(4)
        user_input_valid = false

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
    end

end

class CodeBreaker
    attr_accessor :who_is_the_codebreaker

    def initialize(player_or_computer)
        @who_is_the_codebreaker = player_or_computer
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
                end
                break
            else
                puts "Invalid input, try again"
            end
        end
    end
                
end

play = Play.new
