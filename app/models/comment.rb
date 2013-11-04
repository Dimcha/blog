# -*- encoding : utf-8 -*-
class Comment < ActiveRecord::Base

  attr_accessible :content, :ticket_id, :user_id, :comment_time
  has_one :ticket

  belongs_to :user

end

=begin
    CREATE TABLE `comments` (
      `id` INT( 11 ) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
      `content` text NOT NULL,
      `ticket_id` INT( 11 ) UNSIGNED NOT NULL,
      `user_id` INT( 11 ) UNSIGNED NOT NULL,
      `comment_time` datetime NOT NULL
    ) ENGINE InnoDB;
=end