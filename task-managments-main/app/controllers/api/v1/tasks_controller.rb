module Api
  module V1
    class TasksController < ApplicationController
      def index
        @tasks =
          FindTasks.new.call(params).page(params[:page]).per(params[:per_page])
        authorize @tasks
        render json: serializer(@tasks)
      end

      def show
        render json: serializer(task)
      end

      def create
        @task = Task.new(task_params)
        binding.break
        if @task.save
          @task.employees.each do |employee|
            TasksEmployeeMailer
            .with(employee: employee)
            .task_created
            .deliver_later
          end

          render json: serializer(@task), status: :created
        else
          render json: @task.errors, status: :unprocessable_entity
        end
      end

      def update
        if task.update(task_params)
          render json: serializer(task)
        else
          render json: task.errors, status: :unprocessable_entity
        end
      end

      def update_enabled
        render json: serializer(task) if task.update(status: !task.status)
      end

      def destroy
        task.destroy
      end

      private

      def task_params
        params.require(:task).permit(
          :title,
          :description,
          :start_date,
          :end_date,
          :tag_id,
          :enterprise_id,
          task_assignments_attributes: %i[id employee_id _destroy]
        )
      end

      def task
        Task.find(params[:id])
      end

      def serializer(object)
        TaskSerializer.new(object).serializable_hash.to_json
      end
    end
  end
end
