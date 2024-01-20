# == Schema Information
#
# Table name: workshops
#
#  id         :bigint           not null, primary key
#  name       :string
#  address    :text
#  phone      :string
#  business   :string
#  location   :string
#  rating     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Workshop < ApplicationRecord
  include WorkshopScraper
end
