class Sub < ApplicationRecord
    validates :title, :description, presence: true 

    belongs_to :moderator,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User 

    has_many :posts,
    primary_key: :id,
    foreign_key: :sub_id,
    class_name: :Post

    
    
    has_many :crossposts, 
        primary_key: :id, 
        foreign_key: :sub_id, 
        class_name: :PostSub
 
end
    