# -*- encoding : utf-8 -*-
class Ticket < ActiveRecord::Base

  attr_accessible :summary, :category_id, :resolution, :ticket_start, :ticket_endtime, :last_update

  has_many :comments, :dependent => :destroy
  has_one  :forum_category

  belongs_to :user
  belongs_to :forum_category
  belongs_to :creator, :class_name => 'User', :foreign_key => 'owner_id'
  belongs_to :closer, :class_name => 'User', :foreign_key => 'closed_id'

end

=begin
    CREATE TABLE `tickets` (
      `id` INT( 11 ) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
      `summary` VARCHAR( 255 ) NOT NULL,
      `category_id` INT( 11 ) UNSIGNED NOT NULL,
      `resolution` enum(new,invalid,fixed,duplicate) DEFAULT NULL,
      `ticket_start` datetime NOT NULL,
      `ticket_endtime` datetime DEFAULT NULL,
      `last_update` datetime DEFAULT NULL
    ) ENGINE InnoDB;
=end