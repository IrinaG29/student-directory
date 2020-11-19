#let's put all students into an array
@students = [
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

def print_footer(names)
  puts "Overall, we have #{names.count} great #{students_string_for_count(@students.count)}".center(80)
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

input_students
print_header

# print_names(students)

# puts "Enter first letter of name to filter by"
# print_names(students_starting_with_letter(students, gets.chomp))

# require 'pry'
# binding.pry
print_names_by_cohort(students_with_short_names(@students))

print_footer(@students)
