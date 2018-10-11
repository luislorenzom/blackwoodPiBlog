class ModelWithStatus < ApplicationRecord
    self.abstract_class = true
    
    def destroy
        update_attribute(:enabled, 0)
    end

    def revive 
        update_attribute(:enabled, 1)
    end

end