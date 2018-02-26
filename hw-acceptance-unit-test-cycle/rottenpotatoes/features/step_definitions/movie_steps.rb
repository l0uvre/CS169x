# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create(movie)
  end
end

Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  page.body.should =~ /#{e1}.*#{e2}/m
  # fail "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  ratings = rating_list.split(', ')
  if uncheck
    ratings.each do |rating|
      steps "When I uncheck \"ratings_#{rating}\""
    end
  else
    ratings.each do |rating|
      steps "When I check \"ratings[#{rating}]\""
    end
  end
end

Then /^I should see all the movies$/ do
  # Make sure that all the movies in the app are visible in the table
  rows = page.all(:css, 'tbody tr').count
  expect(rows).to eq Movie.count
  Movie.all.each do |movie|
    steps "I should see \"#{movie}\""
  end
end

Then(/the director of "([^"]*)" should be "([^"]*)"/) do |title, director|
  steps %Q{
     Then I am on the details page for "#{title}"
     And I should see "#{director}"
  }
end
