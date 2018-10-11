# Roles
roles = Role.create([
    {name: 'admin'}, 
    {name: 'reader'}
])

# Users
users = User.create([
    {name: 'admin', email: 'admin@piBlog.com', password: 'M4ster-0f-Un1v3rs3', enabled: true},
    {name: 'reader', email: 'reader@piBlog.com', password: 'S1mpl3?m0rt41', enabled: true}
])

# Assignments
Assignment.create([ 
    {user: users.first, role: roles.first}, 
    {user: users.second, role: roles.second}
])