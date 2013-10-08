class SubjectsController < ApplicationController
	
	layout 'admin'


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
		@subject = Subject.new(:name => 'default')

	end

	def create
		#instantiste a new ojject using form paramaters
		@subject = Subject.new(params[:subject])

		#save the object
		if @subject.save

		#if save succeeds, redirect to the list action
		flash[:notice] = "Subject created."
		redirect_to(:action => 'list')
	else
		#if save fails, redisplay the form so user can fix problems
		render('new')
	end
end

	def edit
		@subject = Subject.find(params[:id])

end

def update
#find ojject using form paramaters
		@subject = Subject.find(params[:id])

		#save the object
		if @subject.update_attributes(params[:subject])

		#if save succeeds, redirect to the list action
		flash[:notice] = "Subject Updated."
		redirect_to(:action => 'show', :id => @subject.id)
	else
		#if save fails, redisplay the form so user can fix problems
		render('edit')
	end
end

def delete
		@subject = Subject.find(params[:id])
	end

def destroy
		@subject = Subject.find(params[:id])
		@subject.destroy
		flash[:notice] = "Subject Destroyed."
		redirect_to(:action => 'list')

	end
	

end