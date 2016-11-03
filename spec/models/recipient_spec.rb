# == Schema Information
#
# Table name: recipients
#
#  id         :integer          not null, primary key
#  order_id   :integer
#  first_name :string           default(""), not null
#  last_name  :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Recipient, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
