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
  puts "Please enter the index of the term you'd like to see"
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
      if Term.by_index(@current_term_index).definitions.empty?
        puts "Sorry, no definitions for that word"
        puts "\n"
      elsif Term.by_index(@current_term_index).definitions.length == 1
        puts "The definition of #{Term.by_index(@current_term_index).word} is"
        puts "#{Term.by_index(@current_term_index).definitions[0]}"
      else
        puts "The definitions of #{Term.by_index(@current_term_index).word} are"
        Term.by_index(@current_term_index).definitions.each_with_index do |definition, index|
          puts "#{index+1}. #{definition}"
        end
      end
      puts "\n"
    end
  end
end

def add_term
  puts "What word would you like to add to the dictionary?"
  puts "Enter 'm' to return to the main menu or 'x' to exit the program"
  new_word = gets.chomp
  if new_word == ""
    puts "Sorry, you must input a word"
    add_term
  elsif new_word == "m"
    main_menu
  elsif new_word == "x"
    puts "Thanks for using the application"
    puts "\n"
    exit
  else
    new_word = new_word.slice(0,1).upcase + new_word.slice(1,new_word.length-1).downcase
    puts "What is the definition of your word?"
    puts "Enter 'm' to return to the main menu or 'x' to exit the program"
    new_definition = ""
    new_definition = gets.chomp
    if new_definition == ""
      puts "Sorry, you must input a definition"
      add_term
    elsif new_definition == "m"
      main_menu
    elsif new_definition == "x"
      puts "Thanks for using the application"
      puts "\n"
      exit
    else
      new_definition = new_definition.slice(0,1).upcase +
        new_definition.slice(1,new_definition.length-1)
      Term.new(new_word, new_definition).term_add
      puts "#{new_word} and #{new_definition} have been added to the dictionary."
      Term.term_sort
    end
  end
end

def sort_terms
  Term.term_sort
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
  end
end

def change_term
  list_all_terms
  puts "\n"
  puts "Please enter the index of the term you'd like to change"
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
     change_term
    else
      @current_term_index = option-1
      puts "How would you like to change #{Term.by_index(@current_term_index).word}?"
      puts "Enter 'a' to add a definition, 'd' to delete a definition or 'e' to edit a definition"
      puts "Enter 'm' to return to the main menu or 'x' to exit the program"
      puts "\n"
      change_option = gets.chomp
      if change_option == "a"
        add_definition
      elsif change_option == "d"
        edit_definition(change_option)
      elsif change_option == "e"
        edit_definition(change_option)
      elsif option == "m"
        main_menu
      elsif option == "x"
        puts "Thanks for using the application"
        puts "\n"
        exit
      else
        puts "Invalid option entered, try again"
        puts "\n"
        change_term
      end
    end
  end
end

def add_definition
  if Term.by_index(@current_term_index).definitions.length == 1
    puts "The definition of #{Term.by_index(@current_term_index).word} is"
    puts "#{Term.by_index(@current_term_index).definitions[0]}"
  else
    puts "The definitions of #{Term.by_index(@current_term_index).word} are"
    Term.by_index(@current_term_index).definitions.each_with_index do |definition, index|
      puts "#{index+1}. #{definition}"
    end
  end
  puts "\n"
  puts "Please enter the definition you wish to add"
  new_definition = ""
  new_definition = gets.chomp
  if new_definition == ""
    puts "Sorry, you must input a definition"
    add_definition
  elsif new_definition == "m"
    main_menu
  elsif new_definition == "x"
    puts "Thanks for using the application"
    puts "\n"
    exit
  else
    new_definition = new_definition.slice(0,1).upcase +
      new_definition.slice(1,new_definition.length-1)
    Term.by_index(@current_term_index).definition_add(new_definition)
    puts "#{new_definition} added to #{Term.by_index(@current_term_index).word}"
    puts "\n"
  end
end

def edit_definition (edit_option)
  if Term.by_index(@current_term_index).definitions.length == 1
    puts "The definition of #{Term.by_index(@current_term_index).word} is"
    puts "#{Term.by_index(@current_term_index).definitions[0]}"
  else
    puts "The definitions of #{Term.by_index(@current_term_index).word} are"
    Term.by_index(@current_term_index).definitions.each_with_index do |definition, index|
      puts "#{index+1}. #{definition}"
    end
  end
  puts "\n"
  puts "Please enter the index of the definition you'd like to edit or delete"
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
    if option > Term.by_index(@current_term_index).definitions.length || option <= 0
      puts "Sorry, you've entered an invalid index"
      puts "\n"
      edit_definition
    elsif edit_option == "e"
      current_definition_index = option-1
      puts "Please enter the new definition you wish to use"
      new_definition = ""
      new_definition = gets.chomp
      if new_definition == ""
        puts "Sorry, you must input a definition"
        edit_definition
      elsif new_definition == "m"
        main_menu
      elsif new_definition == "x"
        puts "Thanks for using the application"
        puts "\n"
        exit
      else
        new_definition = new_definition.slice(0,1).upcase +
        new_definition.slice(1,new_definition.length-1)
        Term.by_index(@current_term_index).definition_edit(current_definition_index, new_definition)
        puts "Definition changed for #{Term.by_index(@current_term_index).word}"
        puts "\n"
      end
    elsif edit_option == "d"
      current_definition_index = option-1
      deleted_definition = Term.by_index(@current_term_index).definition_delete(current_definition_index)
      puts "#{deleted_definition} deleted from #{Term.by_index(@current_term_index).word}"
    end
  end
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
