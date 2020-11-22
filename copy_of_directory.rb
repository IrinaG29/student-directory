@students = []

def print_header
  puts "The students of Cats Academy"
  puts "-------------"
end

def print_names(students)
  students.each_with_index do |student, index|
    puts "#{index} #{student[:name]} (#{student[:nationality]}) (#{student[:cohort]} cohort)"
  end 
end

def print_names_by_cohort
 @students.group_by do |hash|
    hash[:cohort]
  end.each do |cohort, students|
    puts "Students in #{cohort} cohort"
    print_names(students)
  end 
end

def print_footer
  puts "Overall, we have #{@students.count} great #{students_string_for_count(@students.count)}".center(80)
end

def students_string_for_count(count)
  if count == 1
    'student'
  else
    'students'
  end
end

def add_students(name:, cohort:, nationality:)
  @students << {name: name, cohort: cohort.to_sym, nationality: nationality}
  puts "Now we have #{@students.count} #{students_string_for_count(@students.count)}".center(80)
end

def input_students
  puts "Please enter the names of the students".center(80)
  puts "To finish, just hit return twice".center(80)
  
  name = STDIN.gets.gsub("\n", "")
  # while the name is not empty, repeat this code
  
  while !name.empty? do
    puts "Please enter the cohort month of the student".center(80)
    input = STDIN.gets.chomp
    cohort = (input == '' ? :november : input.to_sym)

    puts "Please enter the nationality of the student".center(80)
    nationality = STDIN.gets.chomp

    # add the student hash to the array
    add_students(name: name, cohort: cohort, nationality: nationality)
    name = STDIN.gets.chomp
  end
end

def print_students_list
  print_names_by_cohort
end

def show_students
  print_header
  print_students_list
  print_footer
end

def try_load_students
  filename = ARGV.first || 'students.csv' # first argument from the command line
  return if filename.nil? # get out of the method if it isn't given
  if File.exists?(filename) # if it exists
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit # quit the program
  end
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit" # 9 because we'll be adding more items  
end

def save_students
  puts "What file would you like to save students to?"
  filename = STDIN.gets.chomp

  File.open(filename, "w") do |file|
    @students.each do |student|
      student_data = [student[:name], student[:cohort]]
      csv_line = student_data.join(",")
      file.puts csv_line
    end
  end

  puts "Students have been saved to #{filename}"
end

def load_students(filename = nil)
  if filename.nil?
    puts "What file would you like to load students from?"
    filename = STDIN.gets.chomp
  end

  File.open(filename, "r") do |file|
    file.readlines.each do |line|
      name, cohort = line.chomp.split(',')
      add_students(name: name, cohort: cohort, nationality: nil)
    end
  end

  puts "Students have been loaded from #{filename}"
end

def process(selection)
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
    exit
  else
    puts "I don't know what you mean, try again"
  end
end

try_load_students
interactive_menu
