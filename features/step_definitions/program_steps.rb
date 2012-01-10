Given /^there is a featured program$/ do
  @program = Program.create!(:author_username => "username",
                              :slug => "slug",
                              :title => "My Featured Program",
                              :featured => true)
end

Then /^I should be able to view a highlighted program$/ do
  visit programs_path
  within "#featured" do
    page.should have_content("My Featured Program")
  end
end

def upload_program(user)
  @program = Program.create!(:author_username => user.username,
                              :slug => "slug",
                              :title => "#{user.username}'s program")
end

Given /^I have uploaded a program$/ do
  upload_program(@user)
end

Given /^a user has uploaded a program$/ do
  @user = User.create!(:username => "some_user",
                        :password => "password",
                        :password_confirmation => "password",
                        :email => "some_user@example.com")
  upload_program(@user)
end

def visit_user_programs_page
  visit user_path(@user)
  within ".about-user" do
    find(".user-programs").click()
  end
  page.should have_content(@program.title.titleize)
end

Then /^I should be able to view my programs$/ do
  visit_user_programs_page
end

Then /^I should be able to view their programs$/ do
  visit_user_programs_page
end