class AppsController < ApplicationController
  def new
    @app = App.new
  end
  
  def create
    @app = current_user.apps.build(app_params)
    
    if @app.save
      flash[:notice] = "App saved successfully"
      redirect_to @app
    else
      flash[:error] = "App failed to save. Please try again later"
      render :edit
    end
  
  end
  
  def show
    @app = App.find(params[:id])
  end
  
  def index
    @apps = current_user.apps
  end
  
  def edit
    @app = App.find(params[:id])
  end
  
  def update
    @app = App.find(params[:id])
    if @app.update_attributes(app_params)
      redirect_to @app, notice: "App updated"
    else
      flash[:error] = "App failed to update. Please try again later"
      render :edit
    end
  end
  
  def destroy
    @app = App.find(params[:id])
    
    if @app.destroy
      redirect_to apps_path, notice: "App deleted successfully"
    else
      flash[:error] = "App failed to delete. Please try again"
      render :show
    end
  end
  
  private
  
  def app_params
    params.require(:app).permit(:name, :url)
  end
end
