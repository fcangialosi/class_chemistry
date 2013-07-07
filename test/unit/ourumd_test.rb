# == Schema Information
#
# Table name: ourumds
#
#  id            :integer          not null, primary key
#  course_id     :integer
#  graph_url     :text
#  gpa           :float
#  perc_a_plus   :integer
#  perc_a        :integer
#  perc_a_minus  :integer
#  perc_b_plus   :integer
#  perc_b        :integer
#  perc_b_minus  :integer
#  perc_c_plus   :integer
#  perc_c        :integer
#  perc_c_minus  :integer
#  perc_d_plus   :integer
#  perc_d        :integer
#  perc_d_minus  :integer
#  perc_f        :integer
#  perc_drop     :integer
#  num_students  :integer
#  num_sections  :integer
#  num_semesters :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'test_helper'

class OurumdTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
