# frozen_string_literal: true

class CreateInitialSchemafile < ActiveRecord::Migration[7.1]
  def change
    create_table :initial_schemafiles do |t|
      enable_extension 'plpgsql'

      create_table 'active_storage_attachments', force: :cascade do |t|
        t.string 'name', null: false
        t.string 'record_type', null: false
        t.bigint 'record_id', null: false
        t.bigint 'blob_id', null: false
        t.datetime 'created_at', null: false
        t.index ['blob_id'], name: 'index_active_storage_attachments_on_blob_id'
        t.index %w[record_type record_id name blob_id], name: 'index_active_storage_attachments_uniqueness',
                                                        unique: true
      end

      create_table 'active_storage_blobs', force: :cascade do |t|
        t.string 'key', null: false
        t.string 'filename', null: false
        t.string 'content_type'
        t.text 'metadata'
        t.string 'service_name', null: false
        t.bigint 'byte_size', null: false
        t.string 'checksum'
        t.datetime 'created_at', null: false
        t.index ['key'], name: 'index_active_storage_blobs_on_key', unique: true
      end

      create_table 'active_storage_variant_records', force: :cascade do |t|
        t.bigint 'blob_id', null: false
        t.string 'variation_digest', null: false
        t.index %w[blob_id variation_digest], name: 'index_active_storage_variant_records_uniqueness', unique: true
      end

      create_table 'comments', force: :cascade do |t|
        t.text 'body'
        t.bigint 'user_id', null: false
        t.bigint 'post_id', null: false
        t.datetime 'created_at', null: false
        t.datetime 'updated_at', null: false
        t.index ['post_id'], name: 'index_comments_on_post_id'
        t.index ['user_id'], name: 'index_comments_on_user_id'
      end

      create_table 'events', force: :cascade do |t|
        t.string 'title'
        t.string 'body'
        t.datetime 'event_date'
        t.datetime 'created_at', null: false
        t.datetime 'updated_at', null: false
      end

      create_table 'like_posts', force: :cascade do |t|
        t.bigint 'user_id', null: false
        t.bigint 'post_id', null: false
        t.datetime 'created_at', null: false
        t.datetime 'updated_at', null: false
        t.index ['post_id'], name: 'index_like_posts_on_post_id'
        t.index ['user_id'], name: 'index_like_posts_on_user_id'
      end

      create_table 'locations', force: :cascade do |t|
        t.bigint 'user_id'
        t.string 'seat_name'
        t.datetime 'created_at', null: false
        t.datetime 'updated_at', null: false
        t.jsonb 'points'
        t.integer 'location_type', default: 0
        t.index ['user_id'], name: 'index_locations_on_user_id'
      end

      create_table 'matches', force: :cascade do |t|
        t.datetime 'match_date'
        t.bigint 'event_id'
        t.datetime 'created_at', null: false
        t.datetime 'updated_at', null: false
        t.integer 'opponent'
        t.string 'stadium'
        t.integer 'result'
        t.integer 'team_score'
        t.integer 'away_team_score'
        t.index ['event_id'], name: 'index_matches_on_event_id'
      end

      create_table 'notifications', force: :cascade do |t|
        t.text 'message'
        t.bigint 'user_id', null: false
        t.bigint 'post_id', null: false
        t.datetime 'created_at', null: false
        t.datetime 'updated_at', null: false
        t.index ['post_id'], name: 'index_notifications_on_post_id'
        t.index ['user_id'], name: 'index_notifications_on_user_id'
      end

      create_table 'posts', force: :cascade do |t|
        t.bigint 'user_id', null: false
        t.text 'body'
        t.string 'image'
        t.datetime 'created_at', null: false
        t.datetime 'updated_at', null: false
        t.index ['user_id'], name: 'index_posts_on_user_id'
      end

      create_table 'seats', force: :cascade do |t|
        t.string 'seat_name'
        t.float 'latitude'
        t.float 'longitude'
        t.datetime 'created_at', null: false
        t.datetime 'updated_at', null: false
        t.integer 'location_type', default: 0, null: false
        t.jsonb 'spots', default: []
        t.bigint 'location_id'
        t.index ['location_id'], name: 'index_seats_on_location_id'
        t.index ['seat_name'], name: 'index_seats_on_seat_name', unique: true
      end

      create_table 'user_locations', force: :cascade do |t|
        t.bigint 'user_id'
        t.date 'date'
        t.datetime 'created_at', null: false
        t.datetime 'updated_at', null: false
        t.integer 'icon'
        t.bigint 'location_id'
        t.integer 'location_type'
        t.index ['location_id'], name: 'index_user_locations_on_location_id'
        t.index ['user_id'], name: 'index_user_locations_on_user_id'
      end

      create_table 'user_matches', force: :cascade do |t|
        t.bigint 'user_id', null: false
        t.bigint 'match_id', null: false
        t.datetime 'created_at', null: false
        t.datetime 'updated_at', null: false
        t.date 'date'
        t.index ['match_id'], name: 'index_user_matches_on_match_id'
        t.index ['user_id'], name: 'index_user_matches_on_user_id'
      end

      create_table 'users', force: :cascade do |t|
        t.string 'email', default: '', null: false
        t.string 'encrypted_password', default: '', null: false
        t.string 'reset_password_token'
        t.datetime 'reset_password_sent_at'
        t.datetime 'remember_created_at'
        t.datetime 'created_at', null: false
        t.datetime 'updated_at', null: false
        t.string 'user_name'
        t.string 'first_name'
        t.string 'last_name'
        t.string 'avatar'
        t.string 'favorite_player'
        t.integer 'favorite_viewing_block'
        t.bigint 'location_id'
        t.string 'provider'
        t.string 'uid'
        t.integer 'role', default: 0, null: false
        t.index ['email'], name: 'index_users_on_email', unique: true
        t.index ['location_id'], name: 'index_users_on_location_id'
        t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
      end

      add_foreign_key 'active_storage_attachments', 'active_storage_blobs', column: 'blob_id'
      add_foreign_key 'active_storage_variant_records', 'active_storage_blobs', column: 'blob_id'
      add_foreign_key 'comments', 'posts'
      add_foreign_key 'comments', 'users'
      add_foreign_key 'like_posts', 'posts'
      add_foreign_key 'like_posts', 'users'
      add_foreign_key 'matches', 'events'
      add_foreign_key 'notifications', 'posts'
      add_foreign_key 'notifications', 'users'
      add_foreign_key 'posts', 'users'
      add_foreign_key 'user_locations', 'locations'
      add_foreign_key 'user_locations', 'users'
      add_foreign_key 'user_matches', 'matches'
      add_foreign_key 'user_matches', 'users'
      add_foreign_key 'users', 'seats', column: 'location_id'
      t.timestamps
    end
  end
end
