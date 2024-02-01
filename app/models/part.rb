# == Schema Information
#
# Table name: parts
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Part < ApplicationRecord
  belongs_to :maintainable, polymorphic: true
end
