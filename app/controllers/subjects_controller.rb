class SubjectsController < ApplicationController
	layout 'admin'

	before_filter :confirm_logged_in
	
  def login

  end

	def index
		list
		render('list')
	end

	def list
		@subjects = Subject.order("subjects.position ASC")
	end

	def show
		@subject = Subject.find(params[:id])
	end

	def new
		@subject = Subject.new
		@subject_count = Subject.count + 1
	end

	def create
		new_position = params[:subject].delete(:position)
		#instantiste a new ojject using form paramaters
		@subject = Subject.new(params[:subject])

		#save the object
		if @subject.save
		  @subject.move_to_position(new_position)

      #if save succeeds, redirect to the list action
      flash[:notice] = "Subject created."
      redirect_to(:action => 'list')
    else
      #if save fails, redisplay the form so user can fix problems
     @subject_count =Subject.count
      render('new')
    end
  end

	def edit
		@subject_count =Subject.count + 1
		@subject = Subject.find(params[:id])
		
  end

  def update

    #find ojject using form paramaters
		@subject = Subject.find(params[:id])
		new_position = params[:subject].delete(:position)
		#save the object
		if @subject.update_attributes(params[:subject])
			@subject.move_to_position(new_position)
      #if save succeeds, redirect to the list action
      flash[:notice] = "Subject Updated."
      redirect_to(:action => 'show', :id => @subject.id)
    else
      #if save fails, redisplay the form so user can fix problems
      @subject_count =Subject.count
      render('edit')
    end
  end

  def delete
		@subject = Subject.find(params[:id])
	end

  def destroy
		subject = Subject.find(params[:id])
		subject.move_to_position(nil)
		subject.destroy
		flash[:notice] = "Subject Destroyed."
		redirect_to(:action => 'list')
	end
	def logout
  	session[:user_id] = nil
  		session[:username] = nil
  	flash[:notice] = "You have been Logged out .......Boom "
  	redirect_to(:action => "login")
  end

 
end
