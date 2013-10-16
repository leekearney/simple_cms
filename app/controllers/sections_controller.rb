class SectionsController < ApplicationController
	layout 'admin'

	before_filter :confirm_logged_in

	def index
		list
		render('list')
	end

	def list
		@sections = Section.sorted.where(:page_id => @page.id)
	end

	def show
		@section = Section.find(params[:id])
	end

	def new
		@section = Section.new(:page_id => @page.id)
		@section_count = @page.sections.size + 1
		@pages = Page.order('position ASC')

	end

	def create
		#instantiste a new ojject using form paramaters
		@section = Section.new(params[:section])
		@section_count = @page.sections.size + 1
		#save the object
		if @section.save

      #if save succeeds, redirect to the list action
      flash[:notice] = "Section created."
      redirect_to(:action => 'list')
    else
      #if save fails, redisplay the form so user can fix problems
      @section_count = @page.sections.size + 1
      @pages = Page.order('position ASC')
      render('new')
    end
  end

	def edit
		@section = Section.find(params[:id])
		@section_count = @page.sections.size
		@pages = Page.order('position ASC')
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
      @section_count = @page.sections.size
      @pages = Page.order('position ASC')
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

	def find_page
		if params[:page_id]
			@page = Page.find_by_id(params[:page_id])
		end
	end

end
