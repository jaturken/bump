Sequel.migration do
  change do
    create_table(:socials) do
      primary_key :id
      Integer :bump_id, null: false
      String :name, size: 16, null: false, defaul: ''
      String :push_token, size: 60, null: false, default: ''
      Time :created_at, null: false, default: Sequel::CURRENT_TIMESTAMP
    end
  end
end
