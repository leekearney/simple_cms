module PositionMover

	def move_to_position(new_position)
		max_position = self.class.where(position_scope).count

		unless max_position.nil?
			new_position = [[1, new_position.to_i].max, max_position].min 
		end

		if position == new_position # do nothing
			return true
		elsif position.nil? #not in list yet
			increment_items(new_position, 1000000)
		elsif new_position.nil? # remove from list
			decrement_items(position+1, 1000000)
		elsif new_position < position # shift lower items up
			increment_items(new_position, position-1)
		elsif new_position > position #shift higher items down
			decrement_items(position+1, new_position)
		end
		return update_attribute(:position, new_position)
	end 

	private

	def position_scope
		"1=1"
	end

	def increment_items(first, last)
		items = self.class.where(["position >= ? AND position <= ? AND #{position_scope}", first, last])
		items.each {|i| i.update_attribute(:position, i.position + 1) }
	end

	def decrement_items(first, last)
		items = self.class.where(["position >= ? AND position <= ? AND #{position_scope}", first, last])
		items.each {|i| i.update_attribute(:position, i.position - 1) }
	end

end

