class IncomingMailsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    Rails.logger.log params[:envelope][:to]
    Rails.logger.log params[:subject]
    Rails.logger.log params[:plain]
    Rails.logger.log params[:html]
    Rails.logger.log params[:attachments][0] if params[:attachment]

    render :text => 'success', :status => 200
  end
end
