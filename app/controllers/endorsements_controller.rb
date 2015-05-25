class EndorsementsController < ApplicationController
  before_action :redirect_non_signed_in_user

  def create
    endorsement = Endorsement.find_all_by_endorser_id_and_endorsee_id(current_user.id,params[:endorsement][:endorsee_id])
    e = Endorsement.create(endorsement_params)
    endorsee_user = User.find(params[:endorsement][:endorsee_id])
    @data = params[:endorsement][:endorsee_id]
    if e.save
      if current_user.opt_in ==true
        UserMailer.endorsement( params[:endorsement][:message], endorsee_user,current_user)
      end
      render json: render_to_string( :partial => '/endorsements/endorsements', :locals => {endorsements: e.endorsee.endorsements ,:endorse=> true} ).to_json, status: :ok
    elsif !endorsement.blank?
     # render json: render_to_string( :partial => '/endorsements/endorsements', :locals => {endorsements: endorsement.first.endorsee.endorsements,:endorse=> false} ).to_json, status: :ok
     render json:{:status=>"false"}, status: :ok
    end
  end

 def destroy
    endorsement = Endorsement.find(params[:ach_id])
    ach_id = endorsement.id
    endorsement.destroy
    render json: {ach_id: ach_id}, status: :ok
  end

  private

  def endorsement_params
    params[:endorsement][:endorser_id] = current_user.id

    params.require(:endorsement).permit(:message, :endorsee_id, :endorser_id)
  end
end
