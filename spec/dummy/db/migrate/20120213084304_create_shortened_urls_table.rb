class CreateShortenedUrlsTable < ActiveRecord::Migration
  def change
    enable_extension 'hstore'
    enable_extension 'uuid-ossp'
    create_table :shortened_urls, id: :uuid do |t|
      # we can link this to a user for interesting things
      t.uuid :owner_id
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
      t.hstore :meta

      # a column to help linking shortened url with a message
      t.uuid :related_id

      # reference for origin where url will be accessed
      t.string :source_type, limit: 50

      t.timestamps
    end

    # we will lookup the links in the db by key and owners.
    # also make sure the unique keys are actually unique
    add_index :shortened_urls, :unique_key, unique: true
    add_index :shortened_urls, :url
    add_index :shortened_urls, [:owner_id, :owner_type]
    add_index :shortened_urls, [:related_id, :source_type]
    add_index :shortened_urls, :meta, using: :gist
  end
end
