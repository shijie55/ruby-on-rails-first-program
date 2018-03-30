class Event < ApplicationRecord
	validates :name,
              :presence => true

    has_many :attendees, dependent: :destroy
    belongs_to :category

    # 多對多關聯
    has_many :event_groupships, dependent: :destroy
    # rails提供的方法through ，可以讓多對多表直接關聯
    has_many :groups, :through => :event_groupships, dependent: :destroy
end
