class TaskTimes::TaskTimeService
  attr_accessor :params

  def initialize (user, params)
    @user = user
    @params = params
  end

  def create_task
    # Función de marlon devuelve el id de la tarea si existe y de lo contrario devuelve nil
    if false # validate here if the task already exists for this week
      ActiveRecord::Base.transaction do
        task = current_user.tasks.new(params)
        if @task.save
          if resume_task
            #implement error creating time
          end
        else
          #implement error creating task
        end
      end
    else
      # Fix
      if resume_task #pass the id of the task tha is returned by the function that marlon did
        #implement error creating time
      end
    end
  end

  def resume_task    
    ActiveRecord::Base.transaction do
      binding.pry
      deactivate_all_task_times
      #return unless update_task_time(get_task_time_with_date)
      if update_task_time(get_task_time_with_date)
        return
      end
      return create_task_time
    end
  end

  def stop_task
    ActiveRecord::Base.transaction do
      binding.pry
      task_time = get_active_task_time
      if task_time.start_date.to_date == params[:end_time].to_date # A task is being stopped in the same day
        end_task_time(task_time, params[:end_time])
      elsif # The task was stopped in a future day from where it was started
        end_task_time(task_time, task_time.start_date.end_of_day) # Finish the existing task time EOD
        days_between_dates = ((task_time.end_time - task_time.start_date) / 86400).ceil
        finish_time = task_time.end_time
        for i in 1..days_between_dates
          params.start_date = task_time.start_date.to_date.tomorrow.beginning_of_day
          create_task # Creating new task for the next day
          if i == days_between_dates # In the last iteration it must set the end_time to the time when the task was stopped by the user
            params.end_time = finish_time
          else
            params.end_time = params.start_time.end_of_day
          end
          stop_task
        end
      end
    end
  end

  private

  attr_reader :user

  def end_task_time(task_time, end_time)
    task_time.end_time = end_time 
    task_time.is_active = false
    task_time.hours = ((task_time.end_time - task_time.start_date) / 3600).round(2)
    task_time.save
  end

  def deactivate_all_task_times
    if params[:task_id].present?
      TaskTime.where("task_id = ?", params[:task_id]).update_all(is_active: false)
    end
  end

   def update_task_time(existing_task)
    if existing_task
      existing_task.is_active = true
      existing_task.save
    end
  end

  def create_task_time
    TaskTime.new(task_id: params[:task_id], start_date: params[:start_date], is_active: true).save
  end

  def get_active_task_time
    if params[:task_id].present?
      TaskTime.where("task_id = ? AND is_active = true", params[:task_id]).first
    end
  end

  def get_task_time_with_date
    if params[:task_id].present? && params[:start_date].present?
      TaskTime.where("task_id = ? AND start_date::date = ?", params[:task_id], params[:start_date].to_date).first
    end
  end
end