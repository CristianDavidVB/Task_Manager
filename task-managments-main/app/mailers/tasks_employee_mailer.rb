class TasksEmployeeMailer < ApplicationMailer
  def task_created(employee, task)
    @employee = employee
    @task = task
    mail(to: employee.email, subject: "New task assigned")
  end
end
