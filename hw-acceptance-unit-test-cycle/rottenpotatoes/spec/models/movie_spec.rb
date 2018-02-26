require 'rails_helper'

describe Movie do
  describe 'search movies made by the same director according to the movie id.' do
    context 'when the movie has valid director field' do
     before :each do
       @movie1 = instance_double("Movie", :director => "director1", :id => 1)
       @movie2 = instance_double("Movie", :director => "director2", :id => 2)
       @test_movie = instance_double("Movie", :director => "director1", :id => 3)
       @fake_results = [@movie1, @test_movie]
       allow(Movie).to receive(:where).with(:director => "director1").and_return(@fake_results)
       allow(Movie).to receive(:find).with(@test_movie.id).and_return(@test_movie)
     end
     it 'should find movies by the same director ' do
       expect(Movie.find_by_same_director @test_movie.id).to include(@movie1)
     end
     
     it 'should not find movies by different directors' do
       expect(Movie.find_by_same_director @test_movie.id).not_to include(@movie2)
     end
    end
    
    context 'when the movie has no director field' do
      it 'should return nil' do
       test_movie2 = instance_double("Movie", :director => nil, :id => 3)
       allow(Movie).to receive(:find).with(test_movie2.id).and_return(test_movie2)
       expect(Movie.find_by_same_director test_movie2.id).to eq(nil)
      end
    end
 end
end