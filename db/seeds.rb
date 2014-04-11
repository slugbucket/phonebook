# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Category.delete_all
Category.create(:id   => '1',
                :name => 'Staff offices'
)
Category.create(:id   => '2',
                :name => 'Meeting rooms'
)
DiallingRight.delete_all
DiallingRight.create(:id          => '1',
                     :name        => 'Internal/Freefone',
                     :description => 'Internal extensions or free external numbers'
)
DiallingRight.create(:id          => '2',
                     :name        => 'Local',
                     :description => 'Local raye calls only'
)
DiallingRight.create(:id          => '3',
                     :name        => 'National',
                     :description => 'National calls excluding premium rate numbers'
)
DiallingRight.create(:id          => '4',
                     :name        => 'International',
                     :description => 'Unrestricted outside dialling'
)
Department.delete_all
Department.create(:id          => '1',
                  :name        => 'Administration',
                  :category_id => '1',
                  :default_dialling_right_id => '4',
                  :active      => '1'
)
Department.create(:id          => '2',
                  :name        => 'Sales',
                  :category_id => '1',
                  :default_dialling_right_id => '4',
                  :active      => '1'
)
Department.create(:id          => '3',
                  :name        => 'Operations',
                  :category_id => '1',
                  :default_dialling_right_id => '2',
                  :active      => '1'
)
Department.create(:id          => '4',
                  :name        => 'Research & Development',
                  :category_id => '1',
                  :default_dialling_right_id => '3',
                  :active      => '1'
)
Department.create(:id          => '5',
                  :name        => 'Accounts',
                  :category_id => '1',
                  :default_dialling_right_id => '4',
                  :active      => '1'
)
Department.create(:id          => '6',
                  :name        => 'Marketing',
                  :category_id => '1',
                  :default_dialling_right_id => '3',
                  :active      => '1'
)
Department.create(:id          => '7',
                  :name        => 'Public spaces',
                  :category_id => '2',
                  :default_dialling_right_id => '1',
                  :active      => '1'
)

