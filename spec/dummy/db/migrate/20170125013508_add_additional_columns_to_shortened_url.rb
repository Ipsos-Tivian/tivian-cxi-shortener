class AddAdditionalColumnsToShortenedUrl < ActiveRecord::Migration
  def change
    # add_column :shortened_urls, :related_id, :uuid
    # add_column :shortened_urls, :source_type, :string, limit: 50

    # add_index :shortened_urls, [:related_id, :source_type]
  end
end
