require 'rails_helper'

RSpec.describe "rootpage" do
    it "shows login link if user is not logged in" do
        visit '/'
        expect(page).to have_link("Log In", href: '/login')
    end

    it "greets the user by its name and provides logout link" do
        visit '/login'
        fill_in "name", with: "Gina"
        click_on "login"

        expect(page).to have_text("Hi, Gina.")
        expect(page).to have_selector("input#logout")
    end
end

RSpec.describe "loginpage" do
    it "has a form that lets the user input its name" do
        visit '/login'
        expect(page).to have_selector("form") do |f|
            f.to have_selector("input#name")
            f.to have_selector("input#login")
        end
    end

    it "reroutes user back to login page if they do not input their name in form" do
        visit '/login'
        fill_in "name", with: ""
        click_on "login"
        expect(page).to_not have_text("Hi, ")
        expect(page).to_not have_selector("input#logout")
        expect(page).to have_selector("form")
        expect(page.current_path).to eq("/login")
    end 
    
end