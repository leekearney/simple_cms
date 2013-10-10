class SectionsController < ApplicationController
	layout 'admin'

	def index
		list
		render('list')
	end

	def list
		@sections = Section.order("sections.position ASC")
	end

	def show
		@section = Section.find(params[:id])
	end

	def new
		@subject_count =Subject.count + 1
		@section = Section.new(:name => 'default')
	end

	def create
		#instantiste a new ojject using form paramaters
		@section = Section.new(params[:section])

		#save the object
		if @section.save

      #if save succeeds, redirect to the list action
      flash[:notice] = "Section created."
      redirect_to(:action => 'list')
    else
      #if save fails, redisplay the form so user can fix problems
      render('new')
    end
  end

	def edit
		@subject_count =Subject.count
		@section = Section.find(params[:id])
  end

  def update
    #find ojject using form paramaters
		@section = Section.find(params[:id])

		#save the object
		if @section.update_attributes(params[:section])

      #if save succeeds, redirect to the list action
      flash[:notice] = "Section Updated."
      redirect_to(:action => 'show', :id => @section.id)
    else
      #if save fails, redisplay the form so user can fix problems
      @subject_count =Subject.count
      render('edit')
    end
  end

  def delete
		@section = Section.find(params[:id])
	end

  def destroy
		@section = Section.find(params[:id])
		@section.destroy
		flash[:notice] = "Section Destroyed."
		redirect_to(:action => 'list')
	end

end
