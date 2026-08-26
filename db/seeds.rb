50.times do |i|
  Task.create!(
    title: "タスク#{i + 1}",
    content: "タスク#{i + 1}の内容"
  )
end