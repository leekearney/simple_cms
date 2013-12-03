class ImagesController < ApplicationController
   layout 'admin'

  before_filter :confirm_logged_in
  before_filter :find_subject
  def index
    list
    render('list')
  end

  def list
    @images = Image.order("images.position ASC")
  end

	def show
		@image = image.find(params[:id])

	end

	def new

		@image = Image.new
	end

	def create
    @image = Image.new(params[:image])
    if @image.save
      flash[:notice] = "Image created."
      redirect_to(:action => 'list')
    else
      #@section_count = Section.count + 1
      @sections = Section.order('position ASC')
      render('new')
    end
  end
	def edit
		@image = image.find(params[:id])
		@image_count = @subject.images.size
		@subjects = Subject.order('position ASC')
	end


def update
#find ojject using form paramaters
		@image = image.find(params[:id])

		#save the object
		new_position = params[:image].delete(:position)
		if @image.update_attributes(params[:image])
		@image.move_to_position(new_position)
		#if save succeeds, redirect to the list action
		flash[:notice] = "image Updated."
		redirect_to(:action => 'show', :id => @image.id, :subject_id => @image.subject_id)
	else
		#if save fails, redisplay the form so user can fix problems
		@image_count = @subject.images.size
		@subjects = Subject.order('position ASC')
		render('edit')
	end
end

def delete
    @image = Images.find(params[:id])
  end

def destroy
    Images.find(params[:id]).destroy
    flash[:notice] = "Image destroyed."
    redirect_to(:action => 'list')
  end

	private

	def find_subject
		if params[:subject_id]
			@subject = Subject.find_by_id(params[:subject_id])
	end
	
end
end