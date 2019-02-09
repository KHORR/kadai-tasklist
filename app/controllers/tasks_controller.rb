class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit, :update, :destroy]
    before_action :correct_user, only: [:show, :edit, :update, :destroy]
    
    before_action :require_user_logged_in
    
    def index
        # @tasks = Task.all
        # @tasks = current_user.tasks
        @tasks = current_user.tasks.order('created_at DESC').page(params[:page])
    end
    
    def show
        set_task
        # 下記の内容はcorrect_userと同じことをしている
        # if @task.user.id != current_user
        #     redirect_to root_url
        # end
    end
    
    def new
        @task = Task.new
    end
    
    def create
         @task = current_user.tasks.build(task_params)
       # @task = Task.new(task_params)
       # @task.user_id = @current_user.id
        
        if @task.save
            flash[:success] = 'Taskが正常に投稿されました'
           # redirect_to @task
             redirect_to root_url
        else
            @tasks = current_user.tasks.order('created_at DESC').page(params[:page])
            flash.now[:danger] = 'Taskが正常に投稿されませんでした'
            render :new
        end
    end
    
    def edit
        set_task
    end
    
    def update
      set_task
      
      if @task.update(task_params)
     
          flash[:success] = 'Taskは正常に更新されました'
          redirect_to @task
      else
          flash.now[:danger] = 'Taskは正常に更新されませんでした'
          render :edit
      end
        
    end
    
    def destroy
        set_task
        @task.destroy
      
        flash[:success] = 'Taskは正常に削除されました'
        redirect_to tasks_url
    end
    
    private
    #Strong Parameter
    
    def set_task
        @task = Task.find(params[:id])
    end

    def task_params
        params.require(:task).permit(:content, :status, :user_id)
    end
    
    def correct_user
      @task = current_user.tasks.find_by(id: params[:id])
        unless @task
          redirect_to root_url
        end
    end
 end
