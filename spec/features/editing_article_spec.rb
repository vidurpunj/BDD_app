require 'rails_helper'

RSpec.feature "Editing an article" do
  before do
    password = [*(0..9), *('a'..'z'), *('A'..'Z')].sample(8).join
    @user = User.create({email: Faker::Internet.email, password: password})
    @user.confirm
    @article = Article.create({title: Faker::Book.title , body: Faker::Lorem.paragraph_by_chars(number: 256), user: @user})
  end

  scenario "After Login, user updates an article" do
    login_as(@user) ## user need to login before editing an article ## login_as provided by Warden through devise

    visit '/'
    click_link @article.title
    click_link 'Edit'
    title = Faker::Book.title
    fill_in :Title, with: title
    body = Faker::Lorem.paragraph_by_chars(number: 256)
    fill_in :Body, with: body
    click_button 'Update Article'
    expect(page).to have_content('Article was successfully updated.')
    expect(page).to have_content(title)
    expect(page).to have_content(body)
    expect(page.current_path).to eq(article_path(@article))  ## Match path
  end

  scenario "without Login, user can't edit/delete an article" do
    visit '/'
    click_link @article.title
    expect(page).not_to have_link('Edit')
    expect(page).not_to have_link('Delete Article')
  end
  
  scenario "user logged in and not owner" do
    password = [*(0..9), *('a'..'z'), *('A'..'Z')].sample(8).join
    @john = User.create(email: Faker::Internet.email, password: password)
    @john.confirm
    login_as(@john)
    visit '/'
    click_link @article.title
    expect(page).not_to have_link('Edit')
    expect(page).not_to have_link('Delete Article')
  end
end