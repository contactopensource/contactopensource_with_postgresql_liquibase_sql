--liquibase formatted sql
-- see: http://www.liquibase.org/

--changeset contact@contactopensource.com:6
--preconditions onFail:HALT onError:HALT
--precondition-sql-check expectedResult:0 SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'places'

CREATE TABLE places (
  id uuid not null primary key,

  -- Programming-related
  tenant_id uuid, -- for optional multi-tenant installation
  typecast text, -- for optional single table inheritance
  state text, -- for optional state machine transition

  -- Update-related
  updated_at_timestamp_utc timestamp, -- example: 2020-01-01T00:00:00 always UTC
  updated_at_clock_counter bigint, -- example: 123456789 as suitable for a vector clock
  updated_by_text text, -- example: explanation of who updated the contact, why, how, etc.
 
  -- General-related
  name text, -- example: 'Grand Central Station in New York City'

);

-- Programming-related
CREATE INDEX ix_places_tenant_id on places(tenant_id);;
CREATE INDEX ix_places_typecast on places(typecast);
CREATE INDEX ix_places_state on places(state);

-- Update-related
CREATE INDEX ix_places_updated_at_timestamp_utc on places(updated_at_timestamp_utc);
CREATE INDEX ix_places_updated_at_clock_counter on places(updated_at_clock_counter);
CREATE INDEX ix_places_updated_by_text on places(updated_by_text);

-- General-related
CREATE INDEX ix_places_name on places(name);

--rollback drop table places;
