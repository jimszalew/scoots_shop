require 'rails_helper'

# As an authenticated Admin: I can create an item.
describe 'Admin can create an item' do
  scenario 'from link on admin dashboard' do
    admin = User.create(username: 'scootypuff',
                        email: 'scootypuff@scoots.com',
                        password: 'hmmmmmmmm',
                        role: 1)
    Category.create(name: "Cross Country")
    Category.create(name: "Crosstown")
    Category.create(name: "Sport")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    admin.admin!
    visit admin_dashboard_path(id: admin.id)

    expect(page).to have_link 'Create New Item'
    click_link 'Create New Item'

    expect(current_path).to eq new_admin_item_path

    fill_in 'item[title]', with: 'Scoot scoot scoot'
    fill_in 'item[description]', with: 'all over the place'
    fill_in 'item[price]', with: 199.99
    check "Cross Country"
    
    click_button 'Create Item'

    item = Item.last

    expect(current_path).to eq item_path(item.id)
    expect(page).to have_content(item.title)
    expect(page).to have_content(item.description)
    expect(page).to have_content(item.price)
    expect(page).to have_content(item.categories.last.name)
    expect(page).to have_css "img[src='#{item.image}']"
  end
end
