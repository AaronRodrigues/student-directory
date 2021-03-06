require 'csv'

@students = [] #an empty array accessible to all methods

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
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
  when "4"
    load_students
  when "9"
    exit # this will cause the program to terminate
  else
    puts "I don't know what you meant, try again"
  end
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
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
  puts
end

def checkmonth check
months = %w(january febuary march april may june july august september october november december)
  while months.include?(check.downcase) == false
    puts "Enter student cohort"
    check = STDIN.gets.chomp
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
    name = STDIN.gets.chomp
    break if name == ''
    puts "Add a student hobby"
    hobby = STDIN.gets.chomp
    #Get student cohort from user
    cohort = ' '
    cohort = checkmonth(cohort)
    # add the student hash to the array
    student_data_input name, cohort, hobby
    puts "Now we have #{@students.count} students" if @students.count > 1
    puts "Now we have 1 student" if @students.count == 1
  end
end

def student_data_input name, cohort, hobby
  @students << {name: name, cohort: cohort, hobby: hobby}
end

def save_students
  puts "Input the filename to save as : "
  filename = STDIN.gets.chomp
  CSV.open(filename , "w") do |file|        #replaced the File.open with CSV.open to refractor the code
  @students.each do |student|
    file << [student[:name], student[:cohort], student[:hobby]]
    end
  end
  puts "#{@students.count} Students saved to #{filename}"
  puts
end

def load_students(filename= "students.csv") #Here we give filename a default value, if the argument is not supplied students.csv is used
  puts "Input the filename to be loaded : "
  filename = STDIN.gets.chomp
  return if filename.nil?
  if File.exists?(filename)
    CSV.foreach(filename) do |row|          #replaced File.open with CSV.foreach it eliminates an extra loop and makes the code more readable       
      name, cohort, hobby = row
      student_data_input name, cohort, hobby
      end
  else
    puts "Sorry, #{filename} does not exist!"
    exit
  end
  puts "#{@students.count} students loaded from #{filename}"
end

def try_load_students
  filename = "students.csv" #ARGV.first# use this if filename is provided in cml
  return if filename.nil? #get out of the method if it isn't given
  if File.exists?(filename) #if it exists..
    load_students(filename)
  else
    puts "Sorry, #{filename} doesn't exist."
    exit # quit the program
  end
end

#nothing happens until we call the methods
try_load_students
interactive_menu
exit if @students.count == 0
