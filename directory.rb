
@students = [] #an empty array accessible to all methods

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "9. Exit"
end

def show_students
  print_header()
  print_students_list()
  print_cohort(@students, :may)
  print_footer()
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    save_students
  when "9"
    exit # this will cause the program to terminate
  else
    puts "I don't know what you meant, try again"
  end
end

def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end

def print_header()
  # exit if students.count == 0
  puts "The students of my cohort at Makers Academy"
  puts "--------------"
end

def print_students_list()
  lineWidth = 15
  @students.each_with_index do |student, i|
      puts  "#{i+1}. #{student[:name]}".ljust(lineWidth) +
            "(#{student[:cohort]} cohort) ".center(lineWidth) +
            "Hobby: #{student[:hobby]}".center(lineWidth*2)
      end
end

def print_cohort(students, cohort)
  puts
  puts "The students of #{cohort.to_s} cohort at Makers Academy"
  puts "--------------"
  lineWidth =15
  k =1
  students.each_with_index do |student, i|
    next if student[:cohort] != cohort
    puts  "#{k}. #{student[:name]}".ljust(lineWidth) +
          "(#{student[:cohort]} cohort) ".center(lineWidth) +
          "Hobby: #{student[:hobby]}".center(lineWidth*2)
          k+=1
  end
end

def print_footer()
  # exit if names.count == 0
  puts "Overall, we have #{@students.count} great students"
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
  # students = []
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
    @students << {name: name, cohort: cohort, hobby: hobby}
    puts "Now we have #{@students.count} students" if @students.count > 1
    puts "Now we have 1 student" if @students.count == 1
  end
  #return the array of students

end

def save_students
  file = File.open("students.csv", "w")
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(" , ")
    file.puts csv_line
  end
  file.close
end

#nothing happens until we call the methods
interactive_menu
exit if @students.count == 0
print_header()
print_students_list()
print_cohort(students, :may)
print_footer()
