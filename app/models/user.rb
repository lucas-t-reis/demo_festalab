class User < ApplicationRecord
    validates :name, :email, :cpf, presence: { message: MessagesHelper.blank }

    validates :email, email: { message: MessagesHelper.invalid }, uniqueness: { message: MessagesHelper.already_registered }

    validates :cpf, cpf: { message: MessagesHelper.invalid }

    validates :phone, phone: { message: MessagesHelper.invalid }

    scope :search, -> (query) {
        where("name LIKE ? OR email LIKE ? OR phone LIKE ? OR cpf LIKE ?",
                "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%")
    }
end
