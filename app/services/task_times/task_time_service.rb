class TaskTimes::TaskTimeService
  attr_reader :user, :params
  
  def initialize (user, params)
    @user = user
    @params = params
  end

  def create_task
    if true # validate here if the task already exists for this week
      ActiveRecord::Base.transaction do
        task = current_user.tasks.new(params)
        if @task.save
          if resume_task()
            #implement error creating time
          end
        else
          #implement error creating task
        end
      end
    end
  end

  def resume_task
    ActiveRecord::Base.transaction do
      deactivate_all_task_times(task_id)
      return unless update_task_time(get_task_time)
      return create_task_time(task_id)
    end
  end

  private
  def deactivate_all_task_times(task_id)
    TaskTimes.where("task_id = ?", task_id).update_all(is_active: false)
  end

   def update_task_time(existing_task)
    if existing_task
      existing_task.is_active = true
      existing_task.save
    end
  end

  def create_task_time(task_id)
    TaskTime.new(task_id: task_id, start_date: start_date, is_active: true).save
  end

  def get_task_time
    if params[:task_id].present? && params[:start_date].present?
      TaskTime.where("task_id = ? AND start_date::date = ?", params[:task_id], params[:start_date].to_date).first
    end
  end
end