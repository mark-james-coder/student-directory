# Write a short program that reads its own source code (search StackOverflow to
# find out how to get the name of the currently executed file) and prints it on the screen.

puts File.read(__FILE__)
puts "This is the source code for #{File.basename(__FILE__)}"

# alternative for (__FILE__) is $0

# Source: https://stackoverflow.com/questions/47138996/get-the-source-code-of-a-ruby-file-in-the-form-of-a-string-text
