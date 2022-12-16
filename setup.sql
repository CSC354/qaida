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
    id INT IDENTITY(1,1) NOT NULL,
    hash BINARY(64) NOT NULL,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    email VARCHAR(254) NOT NULL UNIQUE,
    username VARCHAR(64) NOT NULL UNIQUE,
    age smallint NOT NULL,
    CONSTRAINT [PK_User_UserID] PRIMARY KEY CLUSTERED (id ASC)
)
GO


-- INSERT INTO SIJL.USERS(hash, first_name, last_name, email,username,age) VALUES (HashBytes('SHA2_512', "Test" ), "Test" , "Test" , "Test" , "Test" , 31 )
-- stmt, err := s.DB.Prepare(``)
