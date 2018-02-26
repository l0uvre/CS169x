require "rails_helper"

describe MoviesController do 
  describe 'create and destroy a movie' do
    context 'create a movie' do
      it 'should create a new movie and redirect to the index page' do
        get :new
        expect(response).to render_template(:new)
        #expect(Movie).to receive(:create!).with({:title => 'title', :rating => 'R'}).and_return(double('movie'))
        post :create, :movie => {:title => 'title', :rating => 'R'}
        expect(response).to redirect_to(movies_path)
        #post :create, :title => 'title'
      end
    end
    
    context 'destroy a movie' do
      it 'should delete the selected movie' do
        fake_movie = instance_double("Movie", :director => "director1", :id => 1)
        #expect(Movie).to receive(:destroy)
        get :destroy, :id => 1
        expect(response).to redirect_to(movies_path)
      end
    end
  end
  
  describe 'edit' do
    it 'should be able to edit a movie and render a edit template' do
      fake_movie = instance_double("Movie", :director => "director1", :id => 1)
      expect(Movie).to receive(:find)
      get :edit, :id => 1
      expect(response).to render_template(:edit)
    end
    
  end
  
  describe 'display all movie' do 
    it 'should be able to display movies and render the appropriate template' do
        get :index
        expect(response).to render_template(:index)
      end
    it 'should call the ordering model method when title selected' do
      #expect(Movie).to receive(:order).with({:title => :asc})
      get :index, :sort => 'title'
      #expect(response).to render_template(:index)
    end
    it 'should call the ordering model method when release_date selected' do
      #expect(Movie).to receive(:order).with({:release_date => :asc})
      get :index, :sort => 'release_date'
      #expect(response).to render_template(:index)
    end
  end
  
  describe 'find movies by the exact same director given the movie' do
    before :each do
      @fake_results = [double('film1'), double('film2')]
    end
    it 'should call the model method to invoke the search, ' do
      expect(Movie).to receive(:find_by_same_director).with("1").and_return(@fake_results)
      get :same_director, :id => 1
    end
    
    describe 'after calling the model searching method, ' do
      context 'when the movie has valid director field' do
        before :each do 
          allow(Movie).to receive(:find_by_same_director).and_return(@fake_results)
          get :same_director, :id => 1
        end
        it 'should render the appropriate view.' do
          expect(response).to render_template("same_director")
        end
        it 'should make the result movies available to the rendered view.' do
          expect(assigns(:movies)).to eq(@fake_results)
        end
      end
    
      context 'when the movie has no director field, ' do
        it 'redirect to the home page' do
          allow(Movie).to receive(:find_by_same_director).and_return(nil)
          get :same_director, :id => 1
          expect(response).to redirect_to(movies_path)
        end
      end
    end
  end
end