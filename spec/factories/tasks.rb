FactoryBot.define do
  factory :task do
    title { '書類作成' }
    content { '企画書を作成する。' }
    deadline_on { Date.current + 3.days }
    priority { :中 }
    status { :未着手 }
  end

  factory :second_task, class: Task do
    title { 'メール送信' }
    content { '顧客へ営業のメールを送る。' }
    deadline_on { Date.current + 2.days }
    priority { :高 }
    status { :着手中 }
  end

  factory :third_task, class: Task do
    title { '会議準備' }
    content { '会議資料を準備する。' }
    deadline_on { Date.current + 1.day }
    priority { :低 }
    status { :完了 }
  end
end
