class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    ## sort the films
    need_redirected = false
    if params[:date_selected]
      session[:date_selected] = params[:date_selected]
      session[:title_sorted] = nil
      @date = 'yes'
      @title = nil
    elsif params[:title_sorted]
      session[:date_selected] = nil
      session[:title_sorted] = params[:title_sorted]
      @title = 'yes'
      @date = nil
    else
      if session[:date_selected]
        need_redirected = true
      elsif session[:title_sorted]
        need_redirected = true
      end
    end
    
    # select the films due to ratings picked.
    @all_ratings = Movie.all_ratings
    
    if params[:ratings]
      ratings = params[:ratings].keys
      if ratings != []
        session[:ratings] = params[:ratings]
        @rating_selected = ratings
      else
        if session[:ratings]
          need_redirected = true
        end
      end
    else
      if session[:ratings]
        need_redirected = true
      else
        @rating_selected = Movie.all_ratings
      end
    end
    
    if need_redirected
      flash.keep
      optional_hash = {}
      if session[:date_selected]
        optional_hash[:date_selected] = "yes"
      elsif session[:title_sorted]
        optional_hash[:title_sorted] = "yes"
      end
      
      if session[:ratings] 
        optional_hash[:ratings] = session[:ratings]
      end
      
      redirect_to movies_path(optional_hash)
    end
    
    @movies = Movie.where(:rating => @rating_selected)
    if @date
      @movies = @movies.order(:release_date)
    elsif @title
      @movies = @movies.order(:title)
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
