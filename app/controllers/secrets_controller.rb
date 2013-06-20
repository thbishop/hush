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
      render :file => 'public/404.html',
             :status => :not_found,
             :layout => false
    end
  end

  private
  def secret_params
    params.require(:secret).permit(:data)
  end

end
