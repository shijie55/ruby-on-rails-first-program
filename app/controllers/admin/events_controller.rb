class Admin::EventsController < ApplicationController

	before_action :authenticate_company!
	# before_action :authenticate

	# layout指定預設的layout（在layout文件夾內）
	# 不能用symbol，只能用""，否則會找不到
	layout "admin"

	def index
		puts '================='
		puts ENV['test']
		puts '================='

		puts '================='
		puts ENV['ONLY_STORY_DATABASE_USERNAME']
		puts '================='

		@events = Event.all		
	end

	# private
	# def authenticate
 #       authenticate_or_request_with_http_basic do |user_name, password|
 #           user_name == "username" && password == "password"
 #       end
 #    end
end
