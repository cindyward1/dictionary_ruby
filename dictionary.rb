require "./lib/term"
require "./lib/word"
require "./lib/definition"

  @current_term_index = 0

def main_menu

  puts "Welcome to the Dictionary application"
  option = ""

  while option != "x" do
    puts "\n"
    puts "Main menu"
    puts "Main operations:"
    puts "  m = go to main menu (this menu)"
    puts "  x = exit the application"
    puts "Term operations"
    puts "  t = list a specific term by index"
    puts " +t = add a term"
    puts " -t = delete a term"
    puts " ~t = change a term"
    puts "  l = list all terms"
    puts "  f = find and list a specific term by name"
    puts "\n"

    option = gets.chomp.downcase
    if option == "m"
      main_menu
    elsif option == "x"
      puts "Thanks for using the application"
      puts "\n"
      exit
    elsif option == "t"
      list_single_term
    elsif option == "+t"
      add_term
    elsif option == "-t"
      delete_term
    elsif option == "~t"
      change_term
    elsif option == "l"
      list_all_terms
    elsif option == "f"
      find_an_item
    else
      puts "Invalid option entered, try again"
      puts "\n"
      main_menu
    end
  end
end


def list_single_term
    list_all_terms
    puts "\n"
    puts "Please enter the index of the term you'd like to explore"
    puts "Enter 'm' to return to the main menu or 'x' to exit the program"
    option = gets.chomp
    if option == "m"
      main_menu
    elsif option == "x"
      puts "Thanks for using the application"
      puts "\n"
      exit
    else
     option = option.to_i
      if option > Term.all.length || option <= 0
       puts "Sorry, you've entered an invalid index"
       list_single_item
      else
        @current_term_index = option-1
        puts "option = " + option.to_s + "; current_term_index = " + @current_term_index.to_s
        if Term.by_index(@current_term_index).definitions.empty?
          puts "Sorry, no definitions for that word"
          puts "\n"
        elsif Term.by_index(@current_term_index).definitions.length == 1
          puts "The definition of #{Term.by_index(@current_term_index).word} is"
          puts "#{Term.by_index(@current_term_index).definitions[0]}"
        else
          puts "The definition of #{Term.by_index(@current_term_index).word} are"
          Term.by_index(@current_term_index).definition do |definition, index|
            puts "#{index+1}. #{definition}"
        end
      end
      puts "\n"
      main_menu
    end
  end
end

def add_term
  puts "What word would you like to add to the dictionary?"
  new_word = gets.chomp
  new_word = new_word.slice(0,1).upcase + new_word.slice(1,new_word.length-1).downcase
  puts "What is the definition of your word?"
  new_definition = gets.chomp
  Term.new(new_word, new_definition).term_add
  puts "Thanks! #{new_word} and #{new_definition} have been added to the dictionary."
  Term.term_sort
  main_menu
end


def delete_term
  list_all_terms
  puts "\n"
  puts "Please enter the index of the term you'd like to delete"
  puts "Enter 'm' to return to the main menu or 'x' to exit the program"
  option = gets.chomp
  if option == "m"
    main_menu
  elsif option == "x"
    puts "Thanks for using the application"
    puts "\n"
    exit
  else
   option = option.to_i
    if option > Term.all.length || option <= 0
     puts "Sorry, you've entered an invalid index"
     puts "\n"
     delete_term
    else
      @current_term_index = option-1
      deleted_term = Term.term_delete(@current_term_index)
      puts "The term you deleted was #{deleted_term.word}"
      puts"\n"
    end
    main_menu
  end
end

def change_term
end

def list_all_terms
  if Term.all.empty?
    puts "Sorry! There's not anything in the dictionary yet!"
  else
    Term.all.each_with_index do |term, index|
      puts "#{index+1}. #{term.word}"
    end
  end
end



main_menu
