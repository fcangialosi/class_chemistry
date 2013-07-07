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
#  lecture_days        :string(255)
#  lecture_start       :time
#  lecture_end         :time
#  lecture_building    :string(255)
#  lecture_room        :integer
#  has_discussion      :boolean          default(FALSE)
#  disc_days           :string(255)
#  disc_start          :time
#  disc_end            :time
#  disc_building       :string(255)
#  disc_room           :integer
#  freshman_connection :boolean          default(FALSE)
#  sci_evening         :boolean          default(FALSE)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'test_helper'

class SectionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
