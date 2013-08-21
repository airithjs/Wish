class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :userid, presence: true
  validates :username, presence: true
  validates_uniqueness_of :userid

  def self.current
    Thread.current[:user]
  end
  
  def self.current=(user)
    Thread.current[:user] = user
  end
end
