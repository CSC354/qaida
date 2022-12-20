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
    ADD date_joined DATE NOT NULL DEFAULT '2022-12-13';

-- TODO Implement avatars
-- ALTER TABLE SIJL.USERS
--     ADD avatar VARCHAR(10) NOT NULL DEFAULT 'empty';


CREATE TABLE DISCUSS.ARGUMENTS
(
    id             INT IDENTITY (1, 1) NOT NULL,
    sijl_id        INT                 NOT NULL,
    in_response    INT                 NULL,
    argument       NVARCHAR(MAX)       NOT NULL,
    argument_start SMALLINT            NULL, -- argument start point [0-index] for responses
    argument_end   SMALLINT            NULL, -- argument end point [0-index] for responses
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
