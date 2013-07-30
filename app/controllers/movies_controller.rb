class MoviesController < ApplicationController
  helper_method :check_box_toggle

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.ratings_set
    @movies = sort_and_filter
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  def check_box_toggle(rating)
    get_ratings.include?(rating) if params[:ratings]
  end

  private

  def sort_and_filter
    if params[:ratings]
      Movie.where(rating: get_ratings).order(sort_column)
    else 
      Movie.order(sort_column)
    end
  end

  def sort_column
    if params[:sort_by]
      sorter = params[:sort_by]  
      if sorter == "title"
        @title_class = "hilite"
        @release_date_class = "release_date"
      elsif sorter == "release_date"
        @title_class = "title"
        @release_date_class = "hilite"
      end
      "#{sorter} ASC"
    else
      "null"
    end
  end

  def get_ratings
    params[:ratings].keys
  end



end
