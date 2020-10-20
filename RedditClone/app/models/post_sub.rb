class PostSub < ApplicationRecord

    validates :post_id, :sub_id, presence: true

    belongs_to :post, 
    primary_key: :id,
    foreign_key: :post_id, 
    class_name: :Post 

    belongs_to :sub, 
    primary_key: :id,
    foreign_key: :sub_id, 
    class_name: :Sub 


end