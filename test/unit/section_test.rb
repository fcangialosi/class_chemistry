# == Schema Information
#
# Table name: sections
#
#  id                  :integer          not null, primary key
#  course_id           :integer
#  section_num         :integer
#  professor           :string(255)
#  seats_total         :integer
#  seats_open          :integer
#  seats_waitlist      :integer
#  lecture_building    :string(255)
#  lecture_room        :integer
#  lecture_times       :string(255)
#  discussion_building :string(255)
#  discussion_room     :integer
#  discussion_times    :string(255)
#  freshman_connection :boolean          default(FALSE)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'test_helper'

class SectionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
