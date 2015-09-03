Sequel.migration do
  change do
    create_table(:bumps) do
      primary_key :id
      Integer :event_id, null: false
      Time :time, null: false
      String :push_token, size: 60, null: false, default: ''
      Float :latitude, null: false
      Float :longtitude, null: false
      Time :created_at, null: false, default: Sequel::CURRENT_TIMESTAMP
    end
  end
end
