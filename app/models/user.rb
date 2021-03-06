# frozen_string_literal: true

# Basic user model generated by `devise`
class User < ApplicationRecord
  has_many :annotations
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def admin?
    admin
  end
end
