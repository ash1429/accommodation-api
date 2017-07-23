class CreateNotices < ActiveRecord::Migration[5.1]
  def change
    create_table :notices do |t|
      t.string :notice_for
      t.string :details
      t.string :important_dates
      t.string :attachments_needed

      t.timestamps
    end
  end
end
