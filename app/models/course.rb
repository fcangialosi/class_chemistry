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
#  FSAW           :boolean          default(FALSE)
#  FSAR           :boolean          default(FALSE)
#  FSMA           :boolean          default(FALSE)
#  FSOC           :boolean          default(FALSE)
#  FSPW           :boolean          default(FALSE)
#  DSHS           :boolean          default(FALSE)
#  DSHU           :boolean          default(FALSE)
#  DSNS           :boolean          default(FALSE)
#  DSNL           :boolean          default(FALSE)
#  DSSP           :boolean          default(FALSE)
#  DVCC           :boolean          default(FALSE)
#  DVUP           :boolean          default(FALSE)
#  SCIS           :boolean          default(FALSE)
#  HSorHU         :boolean          default(FALSE)
#  HSorSP         :boolean          default(FALSE)
#  HSorNS         :boolean          default(FALSE)
#  HUorSP         :boolean          default(FALSE)
#  NLorSP         :boolean          default(FALSE)
#  HSorHUorSP     :boolean          default(FALSE)
#  NLorNSorSP     :boolean          default(FALSE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Course < ActiveRecord::Base
  attr_accessible :department, :course_num, :course_code, :name, :credits, :description, :total_seats, :open_seats, :professor, :num_professors, :undergrad, :FSAW, :FSAR, :FSMA, :FSOC, :FSPW, :DSHS, :DSHU, :DSNS, :DSNL, :DSSP, :DVCC, :DVUP, :SCIS, :HSorHU, :HSorSP, :HSorNS, :HUorSP, :NLorSP, :HSorHUorSP, :NLorNSorSP
end
