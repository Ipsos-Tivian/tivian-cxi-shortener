class AddAdditionalColumnsToShortenedUrl < ActiveRecord::Migration
  def change
    # add_column :shortened_urls, :message_id, :string, index: true
    # add_column :shortened_urls, :source, :string, limit: 50, index: true
    # add_column :shortened_urls, :campaign_user_id, :string, index: true
  end
end
