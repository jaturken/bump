Sequel.migration do
  change do
    alter_table(:bumps) do
      add_column :generate_code, String, null: false, default: '', size: 8
    end
  end
end
