# README

Issue so can't deploy:

Caused by:
ActiveRecord::StatementInvalid: PG::UndefinedTable: ERROR:  relation "friends" does not exist
: CREATE TABLE "friendships" ("id" bigserial primary key, "user_id" bigint, "friend_id" bigint, "created_at" timestamp NOT NULL, "updated_at" timestamp NOT NULL, CONSTRAINT "fk_rails_e3733b59b7"
FOREIGN KEY ("user_id")
  REFERENCES "users" ("id")
, CONSTRAINT "fk_rails_d78dc9c7fd"
FOREIGN KEY ("friend_id")
  REFERENCES "friends" ("id")
)