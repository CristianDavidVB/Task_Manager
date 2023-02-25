class TasksEmployeeMailer < ApplicationMailer
  def task_employee
    binding.break
    @employee = employee
    @task = task
    mail(to: employee.email, subject: "New task assigned")
  end
end
