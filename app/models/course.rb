# == Schema Information
#
# Table name: courses
#
#  id          :integer          not null, primary key
#  department  :string(255)
#  course_num  :integer
#  course_code :string(255)
#  name        :string(255)
#  credits     :integer
#  professor   :string(255)
#  description :text
#  perm_req    :boolean          default(FALSE)
#  prereq      :text
#  restriction :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Course < ActiveRecord::Base
  # attr_accessible :title, :body
end
