class CreateShortenedUrlsTable < ActiveRecord::Migration
  def change
    create_table :shortened_urls do |t|
      # we can link this to a user for interesting things
      t.integer :owner_id
      t.string :owner_type, limit: 20

      # the real url that we will redirect to
      t.text :url, null: false

      # the unique key
      t.string :unique_key, limit: 10, null: false

      # how many times the link has been clicked
      t.integer :use_count, null: false, default: 0

      # valid until date for expirable urls
      t.datetime :expires_at

      # add some tags for that url
      t.string :meta

      # a column to help linking shortened url with a message
      t.string :message_id

      # reference for origin where url will be accessed
      t.string :source, limit: 50

      # internal user that will access this url
      t.string :campaign_user_id

      t.timestamps
    end

    # we will lookup the links in the db by key and owners.
    # also make sure the unique keys are actually unique
    add_index :shortened_urls, :unique_key, unique: true
    add_index :shortened_urls, :url
    add_index :shortened_urls, [:owner_id, :owner_type]
    add_index :shortened_urls, :message_id
    add_index :shortened_urls, :source
    add_index :shortened_urls, :campaign_user_id
  end
end
