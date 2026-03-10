DROP FUNCTION IF EXISTS handle_new_user_profile() CASCADE;
CREATE OR REPLACE FUNCTION handle_new_user_profile()
RETURNS trigger
LANGUAGE plpgsql
SET search_path = public
SECURITY DEFINER
AS $$
DECLARE
  v_laboratory_id UUID;
BEGIN
  INSERT INTO laboratories(owner_id, name)
  VALUES (
    NEW.id,
    NEW.raw_user_meta_data->>'labName'
  )
  RETURNING id INTO v_laboratory_id;

  INSERT INTO user_profiles(user_id, laboratory_id, name, phone )
  VALUES (
    NEW.id,
    v_laboratory_id,
    NEW.raw_user_meta_data->>'name',
    NEW.raw_user_meta_data->>'phone'
  );

  RETURN NEW;
END;
$$;
