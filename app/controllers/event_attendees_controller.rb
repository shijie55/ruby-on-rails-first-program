class EventAttendeesController < ApplicationController

	def index
		@event = Event.find(params[:event_id])
		@attendees = @event.attendees
	end

	def show
		@event = Event.find(params[:event_id])
		@attendee = @event.attendees.find(params[:id])
	end

	def edit
		@event = Event.find(params[:event_id])
		@attendee = @event.attendees.find(params[:id])
	end

	def update
		@event = Event.find(params[:event_id])
		@attendee = @event.attendees.find(params[:id])
		if @attendee.update(attendee_param)
			flash[:notice] = "success to update"
			redirect_to event_attendees_path(@event)
		else
			flash[:alert] = "fail to update"
			render :edit
		end
	end

	def destroy
		@event = Event.find(params[:event_id])
		@attendee = @event.attendees.find(params[:id])
		@attendee.destroy

		flash[:alert] = "delete success"
		redirect_to event_attdenees_path(@event)
	end

	def new
		@event = Event.find(params[:event_id])
		@attendee = @event.attendees.new
	end

	def create
		@event = Event.find(params[:event_id])
		@attendee = @event.attendees.new(attendee_param)

		if @attendee.save
			flash[:notice] = "success to create"
			redirect_to event_attendees_path(@event)
		else
			flash[:alert] = "fail to create"
			render :new
		end
	end

	private
	def attendee_param
		params.require(:attendee).permit(:name)
	end
end
