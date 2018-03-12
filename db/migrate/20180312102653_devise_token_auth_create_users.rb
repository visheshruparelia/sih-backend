class DeviseTokenAuthCreateUsers < ActiveRecord::Migration[5.1]
    def change
    ## Required
        add_column :users, :provider, :string, :null => false, :default => "email"
        add_column :users, :uid, :string, :null => false, :default => ""

        ## Database authenticatable
        add_column :users, :encrypted_password, :string, :null => false, :default => ""

        ## Recoverable
        add_column :users, :reset_password_token, :string
        add_column :users, :reset_password_sent_at, :datetime
        add_column :users, :allow_password_change, :boolean, :default => false

        ## Rememberable
        add_column :users, :remember_created_at, :datetime

        ## Trackable
        add_column :users, :sign_in_count, :integer, :default => 0, :null => false
        add_column :users,:current_sign_in_at, :datetime
        add_column :users, :last_sign_in_at, :datetime
        add_column :users, :current_sign_in_ip, :string
        add_column :users, :last_sign_in_ip, :string

        ## Confirmable
        add_column :users, :confirmation_token, :string
        add_column :users, :confirmed_at, :datetime
        add_column :users, :confirmation_sent_at, :datetime
        add_column :users, :unconfirmed_email, :string # Only if using reconfirmable

        ## Lockable
        # add_column integer  :failed_attempts, :default => 0, :null => false # Only if lock strategy is :failed_attempts
        # add_column string   :unlock_token # Only if unlock strategy is :email or :both
        # add_column datetime :locked_at

        ## User Info
        # add_column :users, :name, :string
        add_column :users, :nickname, :string
        add_column :users, :image, :string
        add_column :users, :email, :string

        ## Tokens
        add_column :users, :tokens, :text
        add_index :users, :email,                unique: true
        add_index :users, [:uid, :provider],     unique: true
        add_index :users, :reset_password_token, unique: true
        add_index :users, :confirmation_token,   unique: true
        # add_index :users, :unlock_token,       unique: true
    end
end
