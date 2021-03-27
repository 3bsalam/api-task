# frozen_string_literal: true

class CreateArchiveLog < ActiveRecord::Migration[6.1]
  def change
    create_table :archive_logs do |t|
      t.integer :operator
      t.integer :operand
      t.integer :operation
      t.timestamps
    end
  end
end
