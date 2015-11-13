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
  
    # See line 6 of index.html  
    @all_ratings = Movie.all_ratings
    
    @sort_by = params.fetch(:sort_by, session[:sort_by])
    ratings = params.fetch(:ratings, session[:ratings])
    
    session[:sort_by] = @sort_by
    session[:ratings] = ratings
    
    if ratings.nil?
      #@movies = Movie.order(@sort_by)
      redirect_to movies_path({ratings: Hash[@all_ratings.map {|x| [x, 1]}]})
    else
      @movies = Movie.where(rating: ratings.keys).order(@sort_by)
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
