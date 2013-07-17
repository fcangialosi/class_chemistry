# == Schema Information
#
# Table name: courses
#
#  id             :integer          not null, primary key
#  department     :string(255)
#  course_num     :integer
#  course_code    :string(255)
#  name           :string(255)
#  credits        :integer
#  description    :text
#  total_seats    :integer
#  open_seats     :integer
#  professor      :string(255)
#  num_professors :integer
#  undergrad      :boolean          default(TRUE)
#  gened_codes    :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
