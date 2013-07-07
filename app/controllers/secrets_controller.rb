class SecretsController < ApplicationController
  def new
    @secret = Secret.new
  end

  def create
    @secret = Secret.new secret_params

    if @secret.save
      render :action => 'link'
    else
      render :action => 'new'
    end
  end

  def show
    @secret = Secret.find params[:id]

    if @secret
      render
    else
      render :template => 'errors/404',
             :layout => 'application',
             :status => :not_found
    end
  end

  private
  def secret_params
    params.require(:secret).permit(:data)
  end

end
