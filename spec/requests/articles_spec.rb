require "rails_helper"

RSpec.describe "Articles", type: :request do

  before do
    password = [*(0..9), *('a'..'z'), *('A'..'Z')].sample(8).join
    @user = User.create({email: Faker::Internet.email, password: password})
    @user.confirm

    @article = Article.create(title: Faker::Book.title, body: Faker::Lorem.paragraph_by_chars(number: 256), user: @user)
  end

  describe 'GET /articles/:id' do
    context 'with existing article' do
      before { get "/articles/#{@article.id}" }

      it "handle existing article" do
        expect(response.status).to eq(200) # or
        # expect(response).to have_http_status(:ok)
      end
    end

    context 'GET "/articles/xxxx"' do
      before { get "/articles/xxxx" }
      it "handle not-existing article" do
        expect(response).to have_http_status(302)
        flash_message = "The article you are looking for could not be found"
        expect(flash[:alert]).to eq(flash_message)
      end
    end
  end

  describe "GET /artciles/:id/:edit" do
    context "without signed-in user" do
      before { get "/articles/#{@article.id}/edit" }

      it "redirect to the login page" do
        expect(response).to have_http_status(302)
        flash_message = 'You need to sign in or sign up before continuing.'
        expect(flash[:alert]).to eq flash_message ## Check flash message
      end
    end

    context "with signed-in user not owner" do
      before do
        password = [*(0..9), *('a'..'z'), *('A'..'Z')].sample(8).join
        @user = User.create({email: Faker::Internet.email, password: password})
        @user.confirm
        login_as(@user)
        get "/articles/#{@article.id}/edit"
      end

      it "redirect to the home page" do
        flash_message = "You can edit your own article."
        expect(flash[:alert]).to eq(flash_message)
        expect(response).to have_http_status(302)
      end
    end

    context "signed in user as owner" do
      before do
        login_as(@user)
        get "/articles/#{@article.id}/edit"
      end

      it "successfully edit" do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "DELETE /articles/:id" do
    context "signed in user not owner" do
      before do
        password = [*(0..9), *('a'..'z'), *('A'..'Z')].sample(8).join
        @john = User.create({email: Faker::Internet.email, password: password})
        @john.confirm
        login_as(@john)
        delete "/articles/#{@article.id}"
      end
      it "redirects to root path" do
        flash_message = 'You are not the owner of this article'
        expect(flash[:alert]).to eq(flash_message)
        expect(response).to have_http_status(302)
      end
    end

  end
end
