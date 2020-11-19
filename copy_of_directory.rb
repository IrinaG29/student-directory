def print_header
  puts "The students of Cats Academy"
  puts "-------------"
end

def print_names(students)
  students.each_with_index do |student, index|
    puts "#{index} #{student[:name]} (#{student[:nationality]}) (#{student[:cohort]} cohort)"
  end 
end

def print_names_by_cohort(students)
  students.group_by do |hash|
    hash[:cohort]
  end.each do |cohort, students|
    puts "Students in #{cohort} cohort"
    print_names(students)
  end 
end

def print_names_with_loop(students)
  index = 0
  while index < students.size do
    puts "#{index} #{students[index][:name]} (#{students[index][:nationality]}) (#{students[index][:cohort]} cohort)"
    index += 1
  end
end

def students_starting_with_letter(students, letter)
  students.filter do |student|
    student[:name].start_with?(letter)
  end 
end

def students_with_short_names(students)
  students.filter do |student|
    student[:name].size < 12
  end 
end

def print_footer(students)
  puts "Overall, we have #{students.count} great #{students_string_for_count(students.count)}".center(80)
end

def students_string_for_count(count)
  if count == 1
    'student'
  else
    'students'
  end
end

def input_students(students)
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
    students << {name: name, cohort: cohort, nationality: nationality}
    puts "Now we have #{students.count} #{students_string_for_count(students.count)}".center(80)
    # get another name from the user
    name = gets.chomp
  end

  students
end

def print(students)
  print_names_by_cohort(students)
end

def interactive_menu
  students = [
    {name: "Dr. Hannibal Lecter", cohort: :november},
    {name: "Darth Vader", cohort: :november},
    {name: "Nurse Ratched", cohort: :november},
    {name: "Michael Carleone", cohort: :november},
    {name: "Alex DeLarge", cohort: :november},
    {name: "The Wicked Witch of the West", cohort: :november},
    {name: "Terminator", cohort: :november},
    {name: "Freddy Krueger", cohort: :november},
    {name: "The Joker", cohort: :november},
    {name: "Joffrey Baratheon", cohort: :november},
    {name: "Norman Bates", cohort: :november}
  ]

  loop do
    # 1. print the menu and ask the user what to do
    puts "1. Input the students"
    puts "2. Show the students"
    puts "9. Exit" # 9 because we'll be adding more items
    # 2. read the input and save it into a variable
    selection = gets.chomp
    # 3. do what the user has asked
    case selection
    when "1"
      students = input_students(students)
    when "2"
      print_header
      print(students)
      print_footer(students)
    when "9"
      exit # this will cause the program to terminate
    else
      puts "I don't know what you meant, try again"
    end
  end
end

interactive_menu
