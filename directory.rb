# lets put all students into an array
# students =[
#   {name: "Dr. Hannibal Lecter", cohort: :november},
#   {name: "Darth Vader", cohort: :november},
#   {name: "Nurse Ratched", cohort: :november},
#   {name: "Michael Corleone",cohort: :november},
#   {name: "Alex DeLarge", cohort: :november},
#   {name: "The Wicked Witch of the West", cohort: :november},
#   {name: "Terminator", cohort: :november},
#   {name: "Freddy Krueger", cohort: :november},
#   {name: "The Joker", cohort: :november},
#   {name: "Joffrey Baratheon", cohort: :november},
#   {name: "Norman Bates", cohort: :november}
# ]


def print_header
  puts "The students of my cohort at Makers Academy"
  puts "--------------"
end

def print(students)
  lineWidth = 15
  students.each_with_index do |student, i|
      puts "#{i+1}. #{student[:name]}".ljust(lineWidth) + "(#{student[:cohort]} cohort) ".center(lineWidth) + "Hobby: #{student[:hobby]}".center(lineWidth*2)
      end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

def checkmonth check
months = %w(january febuary march april may june july august september october november december)
  while months.include?(check.downcase) == false
    puts "Enter student cohort"
    check = gets.chomp
    return '2017' if check == ''
  end
  return check.to_sym
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
    name =' '
    while !name.empty? do
    #get name from the user
    name = gets.chomp
    break if name == ''
    puts "Add a student hobby"
    hobby = gets.chomp
    #Get student cohort from user
    cohort = ' '
    cohort = checkmonth(cohort)
    # add the student hash to the array
    students << {name: name, cohort: cohort, hobby: hobby}
    puts "Now we have #{students.count} students"
  end
  #return the array of students
  students
end
#nothing happens until we call the methods
students = input_students
print_header
print(students)
print_footer(students)
