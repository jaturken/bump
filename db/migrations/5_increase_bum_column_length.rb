Sequel.migration do
  up do
    run 'ALTER TABLE bumps MODIFY push_token VARCHAR(200);'
  end

  down do
    run 'ALTER TABLE bumps MODIFY push_token VARCHAR(60);'
  end
end
