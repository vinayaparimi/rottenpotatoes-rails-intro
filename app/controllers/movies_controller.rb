class MoviesController < ApplicationController

    def show
      id = params[:id] # retrieve movie ID from URI route
      @movie = Movie.find(id) # look up movie by unique ID
      # will render app/views/movies/show.<extension> by default
    end
  
    def index
      @all_ratings = Movie.all_ratings
      @ratings_to_show = {}

      if params[:ratings].nil?
        @ratings_to_show = Movie.all_ratings
      else
        @ratings_to_show = params[:ratings].keys
      end
          
      # if params[:ratings]
      #   session[:ratings] = params[:ratings]
      #   @ratings_to_show = params[:ratings]
      # end

      if @ratings_to_show == {}
        @movies = Movie.all_ratings.order(params[:sort])
      else
        @movies = Movie.order(params[:sort]).where(rating: @ratings_to_show)
      end
      
 

      if session[:ratings]
      flash.keep
      # redirect_to movies_path(sort_by: session[:sort_by], ratings: session[:ratings])
      end

      @sorted = 'title'
      
    

   # if !params[:sort_by].nil?
   #  @movies.order(params[:sort_by]) 
   # end



    

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
  
    private
    # Making "internal" methods private is not required, but is a common practice.
    # This helps make clear which methods respond to requests, and which ones do not.
    def movie_params
      params.require(:movie).permit(:title, :rating, :description, :release_date)
    end
  end