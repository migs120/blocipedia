class CreateCollabortators < ActiveRecord::Migration
    def change

    create_table :collaborators do |t|
        t.references :user
        t.references :wiki
        t.timestamps
    end
    

     

  end
end
