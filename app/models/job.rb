class Job < ApplicationRecord
    belongs_to :user

    validates :job_description, :length =>{ :maximum => 900}
end
