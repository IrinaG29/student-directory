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

def input_students
  puts "Please enter the names of the students".center(80)
  puts "To finish, just hit return twice".center(80)
  
  name = gets.gsub("\n", "")
  # while the name is not empty, repeat this code
  
  while !name.empty? do
    puts "Please enter the cohort month of the student".center(80)
    input = gets.chomp
    cohort = (input == '' ? :november : input.to_sym)

    puts "Please enter the nationality of the student".center(80)
    nationality = gets.chomp

    # add the student hash to the array
    @students << {name: name, cohort: cohort, nationality: nationality}
    puts "Now we have #{@students.count} #{students_string_for_count(@students.count)}".center(80)
    # get another name from the user
    name = gets.chomp
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

def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
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
  # open the file for writing
  file = File.open("students.csv", "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students
  file = File.open("students.csv", "r")
  file.readlines.each do |line|
  name, cohort = line.chomp.split(',')
    @students << {name: name, cohort: cohort.to_sym}
  end
  file.close
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

interactive_menu
