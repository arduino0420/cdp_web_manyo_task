50.times do |i|
  Task.create!(
    title: "タスク#{i + 1}",
    content: "タスク#{i + 1}の内容",
    deadline_on: Date.current + (i + 1).days,
    priority: Task.priorities.keys[i % Task.priorities.size],
    status: Task.statuses.keys[i % Task.statuses.size]
  )
end