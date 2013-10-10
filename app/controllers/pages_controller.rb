class PagesController < ApplicationController
  layout 'admin'

  def index
    list
    render('list')
  end

  def list
    @pages = Page.order("pages.position ASC")
  end

	def show
		@page = Page.find(params[:id])

	end

	def new
		@subject_count =Subject.count + 1
		@page = Page.new(:name => 'default')

	end

	def create
		#instantiste a new ojject using form paramaters
		@page = Page.new(params[:page])

		#save the object
		if @page.save

		#if save succeeds, redirect to the list action
		flash[:notice] = "Page created."
		redirect_to(:action => 'list')
	else
		#if save fails, redisplay the form so user can fix problems
		@subject_count =Subject.count
		render('new')
	end
end

	def edit
		@subject_count =Subject.count
		@page = Page.find(params[:id])

end

def update
#find ojject using form paramaters
		@page = Page.find(params[:id])

		#save the object
		if @page.update_attributes(params[:page])

		#if save succeeds, redirect to the list action
		flash[:notice] = "Page Updated."
		redirect_to(:action => 'show', :id => @page.id)
	else
		#if save fails, redisplay the form so user can fix problems
		@subject_count =Subject.count
		render('edit')
	end
end

def delete
		@page = Page.find(params[:id])
	end

def destroy
		@page = Page.find(params[:id])
		@page.destroy
		flash[:notice] = "Page Destroyed."
		redirect_to(:action => 'list')

	end
	
end
