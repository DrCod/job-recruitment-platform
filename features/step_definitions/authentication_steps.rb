Given /^ a user visits the signin page$/ do
   visit signin_path
end

When /^ he submits innvalid signin information$/ do
   click_button "Sign in"
end

Then /^ he should see an error message$/ do
    page.should have_selector('div.alert.alert-error')
end

Given /^ the user has an account$/ do
    @user = User.create(name: "Example User", email: "user@example.com",address: "Example Location",
    phone: "Example Phone",password: "foobar", password_confirm: "foobar"
    )
end

When /^ the user submits valid signin information$/ do
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_button "Sign in"
end

Then /^ he should see his profile page$/ do
    page.should have_link('Sign out',href: signout_path)
end