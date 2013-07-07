# == Schema Information
#
# Table name: sections
#
#  id                  :integer          not null, primary key
#  identifier          :string(255)
#  course_code         :string(255)
#  section_num         :string(255)
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

class Section < ActiveRecord::Base
  attr_accessible :identifier, :course_code, :section_num, :professor, :seats_total, :seats_open, :seats_waitlist, :lecture_days, :lecture_start, :lecture_end, :lecture_building, :lecture_room, :has_discussion, :disc_days, :disc_start, :disc_end, :disc_building, :disc_room
end
