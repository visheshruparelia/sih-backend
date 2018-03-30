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
  a.name = 'official'+(i+1).to_s
  a.email= 'official'+(i+1).to_s+'@gmail.com'
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
while i<10 do
    a=User.find(i+1)
    a.name="dispatchUser"+(i+1).to_s
    a.email="dispatchUser"+(i+1).to_s+'@gmail.com'
    a.save
    i+=1
end

i=0
while i<3 do
  a=Group.new
  a.name="Section"+(i+1).to_s
  if i==0 or i==2
    a.isDepartment="true"
  else
    a.isDepartment="false"
  end
  a.save
  i=i+1
end

a=Allfile.new
a.name= "Express Passsport"
a.priority="high"
a.timeRecievedCurrentOwner=Time.now
a.currentOwner_id=1
a.created_by_id=1
a.save
userfile=FileUser.new()
userfile.fileId_id=1
userfile.userId_id=1
userfile.modify=true
userfile.view=true
userfile.save


a=Allfile.new
a.name= "License"
a.priority="medium"
a.timeRecievedCurrentOwner=Time.now
a.currentOwner_id=1
a.created_by_id=1
a.save
userfile=FileUser.new()
userfile.fileId_id=2
userfile.userId_id=1
userfile.modify=true
userfile.view=true
userfile.save


a=Allfile.new
a.name= "Aadhar"
a.priority="low"
a.timeRecievedCurrentOwner=Time.now
a.currentOwner_id=1
a.created_by_id=1
a.save
userfile=FileUser.new()
userfile.fileId_id=3
userfile.userId_id=1
userfile.modify=true
userfile.view=true
userfile.save
