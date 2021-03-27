# frozen_string_literal: true

class AddArchiveToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :archived, :boolean, default: false
  end
end
