#Creating a new
When /^I supply valid information to new post form$/ do
  visit(root_path)
  fill_in "post_title", with:"Title post"
  attach_file "post_photo", "#{Rails.root}/spec/files/denis.png"
  click_button "Post"
end

Then /^the post should be added to the database$/ do
	expect(Post.find_by_title("Title post")).not_to be_nil
end

Then /^the post should have a photo$/ do
  post = Post.find_by_title("Title post")
  expect(post.photo).to have_content("denis")
end

Then /^it should appear on the post feed$/ do
  expect(page).to have_xpath("//img[contains(@src, \"denis.png\")]")
	expect(page).to have_content("Title post")
end

Then /^it should appear on "(.*?)" wall$/ do |email|
  visit user_path(User.find_by_email(email))
  expect(page).to have_content("Title post")
end

Then /^I as "(.*?)" should be the owner$/ do |email|
  expect(Post.find_by_title("Title post").user).to eq(User.find_by_email(email))
end

#Post management

Given /^I own the "(.*?)"$/ do |post|
  user = User.find_by_email("alexander.vasyuk@berkeley.edu")
  post = create(:post, title:post, user:user)
  visit user_path(user)
end

When /^I delete "(.*?)"$/ do |arg1|
  click_link "delete"
end

Then /^"(.*?)" is no longer in the db$/ do |post|
    expect(Post.find_by_title(post)).to be_nil
end

Then /^it does not appear in the feed$/ do
  visit root_path
  expect(page).not_to have_content("Big post")
end