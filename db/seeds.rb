# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
n=10
i=0
while i<n do
  print i
  a=User.new
  a.email='test'+(i+1).to_s+'@gmail.com'
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

i=0
while i<3 do
  a=Group.new
  a.name="g"+(i+1).to_s
  if i==0 or i==2
    a.isDepartment="true"
  else
    a.isDepartment="false"
  end
  a.save
  i=i+1
end

i=0
while i<15 do
  if i<5
    a=Allfile.new
    a.name="f"+(i+1).to_s
    a.priority="low"
    a.timeRecievedCurrentOwner=Time.now
    a.currentOwner_id=1
    a.created_by_id=1
    a.save
    userfile=FileUser.new()
    userfile.fileId_id=i+1
    userfile.userId_id=1
    userfile.modify=true
    userfile.view=true
    userfile.save
  elsif i>=5 and i<10
    a=Allfile.new
    a.name="f"+(i+1).to_s
    a.priority="medium"
    a.timeRecievedCurrentOwner=Time.now
    a.currentOwner_id=1
    a.created_by_id=1
    a.save
    userfile=FileUser.new()
    userfile.fileId_id=i+1
    userfile.userId_id=1
    userfile.modify=true
    userfile.view=true
    userfile.save
  else
    a=Allfile.new
    a.name="f"+(i+1).to_s
    a.priority="high"
    a.timeRecievedCurrentOwner=Time.now
    a.currentOwner_id=1
    a.created_by_id=1
    a.save
    userfile=FileUser.new()
    userfile.fileId_id=i+1
    userfile.userId_id=1
    userfile.modify=true
    userfile.view=true
    userfile.save
  end
  i=i+1
end
