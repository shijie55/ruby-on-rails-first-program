# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

#大致知道程序经过了哪些文件，调用了哪些方法
caller_locations.each { |call| puts call.to_s }