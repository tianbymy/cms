class CreateInfodeployComments < ActiveRecord::Migration
  def change
    create_table :infodeploy_comments do |t|

      t.timestamps
    end
  end
end
