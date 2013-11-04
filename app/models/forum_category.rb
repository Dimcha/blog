# -*- encoding : utf-8 -*-
class ForumCategory < ActiveRecord::Base

  attr_accessible :name, :category_start, :owner_id

  has_many :tickets, :foreign_key => "category_id", :dependent => :destroy
  validates :name, presence: { message: 'Name cannot be blank' }

end

=begin
    CREATE TABLE `forum_categories` (
      `id` INT( 11 ) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
      `name` VARCHAR( 255 ) NOT NULL,
      `owner_id` INT( 11 ) UNSIGNED NOT NULL
      `category_start` datetime NOT NULL,
      `last_update` datetime DEFAULT NULL
    ) ENGINE InnoDB;
=end