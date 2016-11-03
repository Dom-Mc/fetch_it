# == Schema Information
#
# Table name: accounts
#
#  id           :integer          not null, primary key
#  slug         :string
#  first_name   :string           default(""), not null
#  last_name    :string           default(""), not null
#  company      :string
#  account_type :integer          default("Personal"), not null
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe Account, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
