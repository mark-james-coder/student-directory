require 'csv'

@students = [] # an empty array accessible to all methods

def input_students
  puts "You selected option 1 - Input the students"
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # get the first name
  name = STDIN.gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    add_students(name)
    puts "Now we have #{@students.count} students"
    # get another name from the user
    name = STDIN.gets.chomp
  end
end

def interactive_menu
  loop do
    print_menu
    execute_selection(STDIN.gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to file"
  puts "4. Load the list from file"
  puts "9. Exit"
end

def show_students
  puts "You selected option 2 - Show the students"
  print_header
  print_student_list
  print_footer
end


def save_students
  puts "You selected option 3 - Save the list to file"
  puts "Enter the file name you would like to save to:"
  file_name = gets.chomp
  file = CSV.open("#{file_name}", "w")
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students(filename = "students.csv")
  puts "What file would you like to load? Will default to students.csv if no input."
  filename = gets.chomp
  if filename.empty?
    file = CSV.foreach("students.csv") { |line|
      name, cohort = line
      add_students(name, cohort.to_sym) }
    puts "students.csv loaded.  Choose option 2 to see the list."
  else
  file = CSV.foreach("#{filename}") { |line|
    name, cohort = line
    add_students(name, cohort.to_sym) }
  puts "#{filename} loaded.  Choose option 2 to see the list."
  end
end

def add_students(name, cohort = :november)
  @students << {name: name, cohort: cohort.to_sym}
end

def try_load_students(filename = "students.csv")
  filename = ARGV.first # first argument from the command line
  if filename.nil?
    filename = "students.csv"
    load_students
    puts "Loaded #{@students.count} from #{filename}"
  elsif File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

def execute_selection(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    load_students
  when "9"
    puts "You selected option 9 - Exit"
    exit
  else
    puts "I don't know what you meant, try again."
  end
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_student_list
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students"
end

try_load_students
interactive_menu
