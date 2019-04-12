class Serie < ApplicationRecord
  has_many :episodes
  has_many :rentals, as: :rentable
  enum status: [:coming_soon, :preorder, :billboard]

  def rented
    rentals.any?
  end

  def total_duration
    episodes.reduce(0) do |duration, episode|
      duration + episode.duration
    end
  end

  def episodes_count
    episodes.count
  end

  def episodes_list
    episodes.map do |episode|
      {
        :title => episode.title,
        :id => episode.id,
      }
    end
  end
end

# == Schema Information
#
# Table name: series
#
#  id          :bigint(8)        not null, primary key
#  description :text
#  price       :integer
#  rating      :integer
#  status      :integer
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
