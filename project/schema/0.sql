
--
--      DATABASES EXTENSIONS
--
CREATE EXTENSION pgcrypto;


--
--      updated_at columd update
--
CREATE OR REPLACE FUNCTION updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$ language 'plpgsql';


CREATE TABLE users
(
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email character varying(255) NOT NULL,
  password character varying(255) DEFAULT NULL,
  created_at timestamp with time zone NOT NULL DEFAULT NOW(),
  updated_at timestamp with time zone NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_users_id ON users ("id");
CREATE INDEX idx_users_email ON users ("email");
CREATE INDEX idx_users_created_at ON users ("created_at");
CREATE INDEX idx_users_updated_at ON users ("updated_at");

CREATE TRIGGER update_users_modtime BEFORE UPDATE ON users FOR EACH ROW EXECUTE PROCEDURE updated_at_column();
