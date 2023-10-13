# == Schema Information
#
# Table name: vehicles
#
#  id           :bigint           not null, primary key
#  make         :string
#  model        :string
#  year         :integer
#  vin_number   :string
#  mileage      :integer
#  user_id      :integer
#  plate_number :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
