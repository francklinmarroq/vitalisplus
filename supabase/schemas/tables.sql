CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE laboratories (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name VARCHAR(255) NOT NULL,
  address VARCHAR(255),
  email VARCHAR(255),
  phone_number VARCHAR(8),
  owner_id UUID NOT NULL REFERENCES auth.users(id)
);

CREATE TABLE tax_info (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  laboratory_id UUID REFERENCES laboratories(id),
  end_authorized_range INTEGER,
  current_voice_number INTEGER DEFAULT 0,
  establishment_point VARCHAR(3),
  emission_point VARCHAR(3),
  document_type VARCHAR(3)
);

CREATE TABLE roles (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  laboratory_id UUID NOT NULL REFERENCES laboratories(id),
  name VARCHAR(30) NOT NULL
);
CREATE TABLE user_profiles (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES auth.users(id),
  laboratory_id UUID NOT NULL REFERENCES laboratories(id),
  name VARCHAR(100) NOT NULL, 
  phone VARCHAR(8) NOT NULL,
  role_id UUID REFERENCES roles(id)
);





