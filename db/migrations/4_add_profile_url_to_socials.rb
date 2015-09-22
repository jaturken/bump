Sequel.migration do
  change do
    alter_table(:bumps) do
      add_column :profile_url, String, null: false, default: '', size: 64
    end
  end
end
