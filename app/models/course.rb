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

class Course < ActiveRecord::Base
  attr_accessible :department, :course_num, :course_code, :name, :credits, :description, :total_seats, :open_seats, :professor, :num_professors, :undergrad, :gened_codes
end
