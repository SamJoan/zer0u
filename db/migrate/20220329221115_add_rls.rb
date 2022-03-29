class AddRls < ActiveRecord::Migration[7.0]
  def change
    # Define RLS policy
    reversible do |dir|
      dir.up do
        # Use FORCE to ensure the restrictions apply to the table owner as well.	
        # Per docs: Superusers and roles with the BYPASSRLS attribute always bypass the row security system when accessing a table. 
        # Table owners normally bypass row security as well, though a table owner can choose to be subject to row security with ALTER TABLE ... FORCE ROW LEVEL SECURITY.
        # https://www.postgresql.org/docs/current/ddl-rowsecurity.html
        execute 'ALTER TABLE documents ENABLE ROW LEVEL SECURITY'
        execute 'ALTER TABLE documents FORCE ROW LEVEL SECURITY'
        execute "CREATE POLICY documents_app_user ON documents TO rortest USING (user_id = NULLIF(current_setting('rls.customer_id', TRUE), '')::bigint)"
      end
      dir.down do
        execute 'DROP POLICY documents_app_user ON documents'
        execute 'ALTER TABLE documents DISABLE ROW LEVEL SECURITY'
      end
    end
  end
end
