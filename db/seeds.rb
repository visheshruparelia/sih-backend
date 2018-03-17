# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
n=5
i=0
while i<n do
  print i
  a=User.new
  a.email='test'+i.to_s+'@gmail.com'
  a.password=12345678
  a.password_confirmation=12345678
  if i==4
    a.add_role "superadmin"
  end
  if i==3
    a.add_role "admin"
  end
  a.save
  i=i+1
end
