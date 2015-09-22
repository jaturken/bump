Sequel.migration do
  change do
    alter_table(:socials) do
      add_column :profile_url, String, null: false, default: '', size: 64
    end
  end
end
