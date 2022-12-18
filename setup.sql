USE master;

IF DB_ID ('SIJL') IS NOT NULL DROP DATABASE SIJL;


IF @@ERROR = 3702
   RAISERROR ('Database cannot be dropped because there are still open connections.', 127, 127)
   WITH NOWAIT, LOG;


CREATE DATABASE SIJL;

GO
USE SIJL;
GO
CREATE SCHEMA SIJL AUTHORIZATION dbo;

GO
CREATE TABLE SIJL.USERS (
  id int IDENTITY (1, 1) NOT NULL,
  hash BINARY (64) NOT NULL,
  first_name varchar(30) NOT NULL,
  last_name varchar(30) NOT NULL,
  email varchar(254) NOT NULL UNIQUE,
  username varchar(64) NOT NULL UNIQUE,
  age smallint NOT NULL,
  CONSTRAINT[PK_User_UserID] PRIMARY KEY CLUSTERED (id ASC))
GO

ALTER TABLE SIJL.USERS
  ADD github varchar (60) NULL;

ALTER TABLE SIJL.USERS
  ADD home VARCHAR(300) NULL;

ALTER TABLE SIJL.USERS
  ADD about VARCHAR(1500) NULL;

ALTER TABLE SIJL.USERS
  ADD twitter VARCHAR(40) NULL;

ALTER TABLE SIJL.USERS
  ADD date_joined DATE NOT NULL DEFAULT '2022-12-13';

ALTER TABLE SIJL.USERS
  ADD avatar VARCHAR(10) NOT NULL DEFAULT 'empty';


-- SELECT
--   first_name,
--   last_name,
--   username,
--   github,
--   home,
--   about,
--   twitter
-- FROM
--   SIJL.USERS
-- WHERE
--   username = 'saleh'


-- UPDATE
--   SOMEONE
-- SET
--   SOMEONE.first_name = @firstname,
--   SOMEONE.last_name = @lastname,
--   SOMEONE.github = @github,
--   SOMEONE.home = @home,
--   SOMEONE.about = @about,
--   SOMEONE.twitter = @twitter,
-- FROM
--   SIJL.USERS as SOMEONE
-- WHERE
--   SOMEONE.username = 'saleh'


  -- INSERT INTO SIJL.USERS(hash, first_name, last_name, email,username,age) VALUES (HashBytes('SHA2_512', "Test" ), "Test" , "Test" , "Test" , "Test" , 31 )
  -- stmt, err := s.DB.Prepare(``)
