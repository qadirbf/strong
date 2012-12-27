#encoding:utf-8
class MessagesController < ApplicationController

  def leave_message
    Message.create({:name => params[:User], :email => params[:email],
                    :message => params[:Message], :phone => params[:Phone],
                    :company => params[:Company], :status_id => 0})
    redirect_to "/#{params[:url]}.php"
  end

end
