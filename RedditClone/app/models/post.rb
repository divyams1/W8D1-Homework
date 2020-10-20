class Post < ApplicationRecord

    belongs_to :author, 
    primary_key: :id, 
    foreign_key: :author_id,
    class_name: :User 

    belongs_to :sub,
    primary_key: :id,
    foreign_key: :sub_id,
    class_name: :Sub 


    has_many :crossposts, 
        primary_key: :id, 
        foreign_key: :post_id, 
        class_name: :PostSub
end