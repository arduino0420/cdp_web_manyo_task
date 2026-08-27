unless Rails.env.test?
  admin = User.find_or_create_by!(email: 'admin@example.com') do |user|
    user.name = '管理者'
    user.password = 'password'
    user.password_confirmation = 'password'
    user.admin = true
  end

  user = User.find_or_create_by!(email: 'user@example.com') do |u|
    u.name = '一般ユーザ'
    u.password = 'password'
    u.password_confirmation = 'password'
    u.admin = false
  end

  Task.delete_all

  25.times do |i|
    admin.tasks.create!(
      title: "管理者タスク#{i + 1}",
      content: "管理者タスク#{i + 1}の内容",
      deadline_on: Date.current + (i + 1).days,
      priority: Task.priorities.keys[i % Task.priorities.size],
      status: Task.statuses.keys[i % Task.statuses.size]
    )
  end

  25.times do |i|
    user.tasks.create!(
      title: "一般ユーザタスク#{i + 1}",
      content: "一般ユーザタスク#{i + 1}の内容",
      deadline_on: Date.current + (i + 1).days,
      priority: Task.priorities.keys[i % Task.priorities.size],
      status: Task.statuses.keys[i % Task.statuses.size]
    )
  end
end
