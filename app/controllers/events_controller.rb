class EventsController < ApplicationController
	before_action :authenticate_company!
	def index

		if params[:keyword]
			@events = Event.where("name like ?", ["%#{params[:keyword]}%"])
		else
			@events = Event.all	
		end

		if params[:order] == "name"
			@events = @events.order("name")
		end
		
		#Rails.logger.debug("event: #{@event.inspect}")
		# 返回的類型，訪問  路徑.類型，就可以訪問到該種類型的頁面
		respond_to do |format|
		    format.html # index.html.erb
		    format.xml { render :xml => @events.to_xml }
		    format.json { render :json => @events.to_json }
		    format.atom { @feed_title = "My event list" } # index.atom.builder
  		end
	end

	def show
		@event = Event.find(params[:id])

		respond_to do |format|
		    format.html # show.html.erb
		    format.xml # show.xml.builder
		    format.json { render :json => { id: @event.id, name: @event.name }.to_json }
	  	end
	end

	def edit
		@event = Event.find(params[:id])
	end

	def update
		@event = Event.find(params[:id])
		if @event.update(event_params)
			flash[:notice]="success to update"
			redirect_to events_path
		else
			flash[:alert]="fail to update"
			render :edit
		end

	end

	def new
		@event = Event.new
	end

	def create
		@event = Event.new(event_params)
		@event.status = "private"
		if @event.save
			flash[:notice]="success to create"
			redirect_to events_path
		else
			flash[:alert]="fail to create"
			render :new
		end
	end

	def destroy
		@event = Event.find(params[:id])

		@event.destroy
		
		redirect_to events_path
	end

	def latest
		@events = Event.order("id desc").limit(3)
		render :index
	end

	def bulk_update
		# Event.destroy_all
		# redirect_back fallback_location: root_path
		# 使用array是防止前臺未選擇checkbox傳過來空值，會將nil轉成空數組
		ids = Array(params[:ids])
		# find方法給一個找不到的id會拋異常，find_by_id不會，只會返回一個空值
		# compact會將數組裏的nil去除
		events = ids.map{|i| Event.find_by_id(i)}.compact

		if params[:commit] == "Delete"
			events.each do |e| 
				 e.destroy  
			end
		elsif params[:commit] == "Update"
			events.each do |e| 
				 e.update(:status => "published") 
			end
		end

		redirect_back fallback_location: root_path
	end

	private
	# 強類型，如果要往數據庫存，除了一個一個的存，就需要加強類型，不然存不進去
	def event_params
	  #strong
	  params.require(:event).permit(:name, :description, :category_id, :group_ids=>[])
	end
end
