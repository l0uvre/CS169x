Given /^the following (.*?):$/ do |type, table|
  table.hashes.each do |elem|
    if type == "users"
      User.create!(elem)
    elsif type == "articles"
      Article.create!(elem)
    else
      Comment.create!(elem)
    end
  end
end

Given /I sign in with login "(.+)" and password "(.+)"$/ do |user, pwd|
  visit '/accounts/login'
  fill_in 'user_login', :with => user
  fill_in 'user_password', :with => pwd
  click_button 'Login'
end

Given /^I merge the artice with the other's id (\d+)$/ do |article_id|
  steps %Q{ 
    And I fill in "merge_with" with "#{article_id}"
    And I press "Merge" 
  }
end
