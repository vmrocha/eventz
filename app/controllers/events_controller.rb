class EventsController < ApplicationController
  before_action :require_signin, except: %i[index show]
  before_action :require_admin, except: %i[index show]
  before_action :set_event, only: %i[show edit update destroy]

  def index
    @events = case params[:filter]
    when "free" then Event.free
    when "past" then Event.past
    when "recent" then Event.recent
    else Event.upcoming
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to @event, notice: "Event successfully created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    if current_user && current_user.likes.find_by(event: @event)
      @like = current_user.likes.find_by(event: @event)
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: "Event successfully updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    redirect_to events_url,
                status: :see_other,
                alert: "Event successfully deleted!"
  end

  private

  def event_params
    params.require(:event).permit(
      :name,
      :description,
      :location,
      :price,
      :starts_at,
      :image_file_name,
      :capacity,
      category_ids: []
    )
  end

  def set_event
    @event = Event.find_by!(slug: params[:id])
  end
end
