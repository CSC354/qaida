USE master;
-- TODO add premision for each scheme

IF DB_ID('QAIDA') IS NOT NULL DROP DATABASE QAIDA;


IF @@ERROR = 3702
    RAISERROR ('Database cannot be dropped because there are still open connections.', 127, 127)
        WITH NOWAIT, LOG;


CREATE DATABASE QAIDA;
GO
USE QAIDA;
GO
CREATE SCHEMA SIJL AUTHORIZATION dbo;
GO
CREATE SCHEMA DISCUSS AUTHORIZATION dbo;
GO


CREATE TABLE SIJL.USERS
(
    id            INT IDENTITY (1, 1) NOT NULL,
    password_hash BINARY(64)          NOT NULL,
    first_name    VARCHAR(30)         NOT NULL,
    last_name     VARCHAR(30)         NOT NULL,
    email         VARCHAR(254)        NOT NULL UNIQUE,
    username      VARCHAR(64)         NOT NULL UNIQUE,
    age           TINYINT             NOT NULL,
    CONSTRAINT [PK_SIJL_UserID] PRIMARY KEY CLUSTERED (id ASC)
)

ALTER TABLE SIJL.USERS
    ADD github varchar(60) NULL;

ALTER TABLE SIJL.USERS
    ADD home VARCHAR(300) NULL;

ALTER TABLE SIJL.USERS
    ADD about NVARCHAR(1500) NULL;
-- TODO check in the backend for size

ALTER TABLE SIJL.USERS
    ADD twitter VARCHAR(40) NULL;

ALTER TABLE SIJL.USERS
    ADD date_joined DATE NOT NULL DEFAULT GETDATE();


CREATE TABLE DISCUSS.ARGUMENTS
(
    id             INT IDENTITY (1, 1) NOT NULL,
    sijl_id        INT                 NOT NULL,
    in_response    INT                 NULL,
    argument       NVARCHAR(MAX)       NOT NULL, -- TODO constraint size in the backend
    argument_start SMALLINT            NULL,     -- argument start point [0-index] for responses
    argument_end   SMALLINT            NULL,     -- argument end point [0-index] for responses
    CONSTRAINT [PK_DISCUSS_ArgumentID] PRIMARY KEY CLUSTERED (id ASC),
    FOREIGN KEY (in_response) REFERENCES DISCUSS.ARGUMENTS (id),
    FOREIGN KEY (sijl_id) REFERENCES SIJL.USERS (id),
    CONSTRAINT [CHECK1] CHECK
        (
            (argument_end IS NOT NULL
                AND argument_start IS NOT NULL
                AND in_response IS NOT NULL
                AND argument_end > 0
                )
            OR
            (argument_start IS NULL
                AND argument_end IS NULL
                AND in_response IS NULL)
        )
)


CREATE TABLE DISCUSS.TAGS
(
    id       INT IDENTITY (1, 1) NOT NULL,
    tag_name NVARCHAR(200) UNIQUE, -- TODO Constraint in the backend side
    CONSTRAINT [PK_DISCUSS_TagsID] PRIMARY KEY CLUSTERED (id ASC),
)


CREATE TABLE DISCUSS.ARGUMENTS_TAGS
(

    id          INT IDENTITY (1, 1) NOT NULL,
    argument_id INT                 NOT NULL,
    tag_id      INT                 NOT NULL,
    UNIQUE (argument_id, tag_id),
    CONSTRAINT [PK_DISCUSS_ArgumentTagsID] PRIMARY KEY CLUSTERED (id ASC),
    FOREIGN KEY (argument_id) REFERENCES DISCUSS.ARGUMENTS (id),
    FOREIGN KEY (tag_id) REFERENCES DISCUSS.TAGS (id),
)


CREATE TABLE DISCUSS.VOTES
(
    id          INT IDENTITY (1, 1) NOT NULL,
    sijl_id     INT                 NOT NULL,
    argument_id INT                 NOT NULL,
    UNIQUE (sijl_id, argument_id),
    CONSTRAINT [PK_DISCUSS_Vote_ID] PRIMARY KEY CLUSTERED (id ASC),
    FOREIGN KEY (argument_id) REFERENCES DISCUSS.ARGUMENTS (id),
    FOREIGN KEY (sijl_id) REFERENCES SIJL.USERS (id),
)


-- CREATE TABLE DISCUSS.VOTES (
--   argument_id int NOT NULL,
--   CONSTRAINT []

-- )


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

-- INSERT INTO DISCUSS.ARGUMENTS (sijl_id, in_response, argument, argument_start, argument_end) VALUES ()
-- INSERT INTO DISCUSS.ARGUMENTS_TAGS (id, argument_id, tag_id) VALUES ()
-- INSERT INTO DISCUSS.TAGS(id, tag_name) VALUES ()
-- 
-- 
-- 
-- 
-- USE QAIDA;
-- INSERT INTO DISCUSS.ARGUMENTS (sijl_id, argument) VALUES (1, 'qtqt') SELECT SCOPE_IDENTITY() AS id
-- 
-- 
-- INSERT INTO SIJL.USERS(password_hash, first_name, last_name,
--                        email, username, age)
-- VALUES (HashBytes('SHA2_512', 'saleh'), 'Saleh', 'Muhammed',
--         'wa@fq.com', 'saleh', 12)
-- INSERT INTO DISCUSS.ARGUMENTS (in_response, argument, argument_start, argument_end) VALUES ()

-- INSERT INTO DISCUSS.ARGUMENTS_TAGS(argument_id, tag_id) VALUES ()

-- SELECT COUNT(*) FROM DISCUSS.VOTES votes WHERE votes.argument_id == @id

-- SELECT id FROM DISCUSS.ARGUMENTS arg WHERE arg.in_response is NULL ORDER BY id DESC;
-- SELECT id FROM DISCUSS.ARGUMENTS arg WHERE arg.in_response IS NOT NULL ORDER BY id DESC;  
-- SELECT id FROM DISCUSS.ARGUMENTS arg WHERE arg.sijl_id = @id ORDER BY id DESC;  


-- MERGE INTO DISCUSS. AS target
-- USING (
--     SELECT '<username>' AS username, '<email>' AS email
-- ) AS source
-- ON (target.username = source.username AND target.email = source.email)
-- 
-- WHEN MATCHED THEN
--     DELETE
-- 
-- WHEN NOT MATCHED THEN
--     INSERT (hash, first_name, last_name, email, username, age)
--     VALUES (HASHBYTES('SHA2_256', '<password>'), '<first_name>', '<last_name>', '<email>', '<username>', <age>);
-- 
-- 
-- 
-- 
-- 
-- 
-- -- MERGE INTO DISCUSS.VOTES AS target
-- USING (
--     SELECT '<sijl_id>' AS sijl_id, '<argument_id>' AS argument_id
-- ) AS source
-- ON (target.sijl_id = source.sijl_id AND target.argument_id = source.argument_id)
-- 
-- WHEN MATCHED THEN
--     DELETE
-- 
-- WHEN NOT MATCHED THEN
--     INSERT (sijl_id, argument_id)
--     VALUES ('<sijl_id>', '<argument_id>')
--     ;

-- INSERT INTO DISCUSS.TAGS(tag_name) VALUES (@tag)

-- SELECT sjl.id FROM SIJL.USERS sjl WHERE sjl.username = @username