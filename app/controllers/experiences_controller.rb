class ExperiencesController < ApplicationController
  def create
    poker_room = find_or_create_poker_room(params[:experience][:poker_room_type], params[:experience][:location], params[:url])
    params[:experience].merge!(poker_room_id: poker_room.id, poker_room_type: params[:experience][:poker_room_type])
    current_user.experiences.create(experience_params)

    online_experiences = Experience.user_experiences(current_user.id, 'OnlineSite')
    casino_experiences = Experience.user_experiences(current_user.id, 'Casino')
    if params[:experience][:poker_room_type] == "OnlineSite"
      render json: render_to_string( :partial => '/users/experiences_poker', :locals => { :online_experiences => online_experiences } ).to_json, status: :ok
    else

      render json: render_to_string( :partial => '/users/experiences_casino', :locals => {  :casino_experiences => casino_experiences } ).to_json, status: :ok
    end
  end

  def edit
    experience = Experience.find(params[:expId])
    render json: { partial: render_to_string( partial: '/users/edit_experience', locals: { experience_id: experience.id} ), id: experience.id }, status: :ok
  end

  def update
    experience = Experience.find(params[:experience][:expId])
    poker_room = find_or_create_poker_room(experience.poker_room_type, params[:experience][:location], params[:url])
    params[:experience].merge!(poker_room_id: poker_room.id)
    params[:experience].except!(:expId)

    experience.update_attributes(experience_params)
    render json: { partial: render_to_string( partial: '/users/experience', locals: { experience: experience} ), id: experience.id }, status: :ok
  end

  def destroy
    id = params[:expId]
    Experience.find(id).destroy
    render json: {id: id}, status: :ok
  end

  def autocomplete
    poker_rooms = (OnlineSite.all.map(&:name).uniq + Casino.all.map(&:name).uniq).uniq
    render json: {poker_rooms: poker_rooms}, status: :ok
  end

  private

    def find_or_create_poker_room klass, name, url
      klass.constantize.find_by_downcased_name(name.downcase) || klass.constantize.create(name: name, url: url)
    end

    def experience_params
      params.require(:experience).permit!
    end
end
