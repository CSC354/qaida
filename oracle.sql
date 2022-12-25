CREATE USER DEBATE IDENTIFIED BY password DEFAULT TABLESPACE users TEMPORARY TABLESPACE temp;
ALTER SESSION SET CURRENT_SCHEMA = DEBATE;

 CREATE TABLE DEBATE_USERS
(
    id            NUMBER(10) NOT NULL,
    password_hash RAW(64)          NOT NULL,
    first_name    VARCHAR2(30)         NOT NULL,
    last_name     VARCHAR2(30)         NOT NULL,
    email         VARCHAR2(254)        NOT NULL UNIQUE,
    username      VARCHAR2(64)         NOT NULL UNIQUE,
    age           NUMBER(3)             NOT NULL,
    date_joined DATE DEFAULT SYSTIMESTAMP NOT NULL,

    CONSTRAINT PK_SIJL_UserID PRIMARY KEY (id)
);

-- Generate ID using sequence and trigger
CREATE SEQUENCE DEBATE_USERS_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER DEBATE_USERS_seq_tr
 BEFORE INSERT ON DEBATE_USERS FOR EACH ROW
 WHEN (NEW.id IS NULL)
BEGIN
 SELECT DEBATE_USERS_seq.NEXTVAL INTO :NEW.id FROM DUAL;
END;
/

ALTER TABLE DEBATE_USERS
    ADD github varchar(60) NULL;

ALTER TABLE DEBATE_USERS
    ADD home VARCHAR(300) NULL;

ALTER TABLE DEBATE_USERS
    ADD about VARCHAR(1500) NULL;

ALTER TABLE DEBATE_USERS
    ADD twitter VARCHAR(40) NULL;

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE ARGUMENTS
(
    id             NUMBER(10) NOT NULL,
    sijl_id        NUMBER(10)                 NOT NULL,
    in_response    NUMBER(10)                 NULL,
    argument       NVARCHAR(MAX)       NOT NULL, -- SQLINES DEMO *** ize in the backend
    title          NVARCHAR2(200)       NULL,
    argument_start NUMBER(5)            NULL,     -- SQLINES DEMO *** int [0-index] for responses
    argument_end   NUMBER(5)            NULL,     -- SQLINES DEMO *** t [0-index] for responses
    CONSTRAINT PK_DISCUSS_ArgumentID PRIMARY KEY (id),
    FOREIGN KEY (in_response) REFERENCES ARGUMENTS (id),
    FOREIGN KEY (sijl_id) REFERENCES DEBATE_USERS (id),
    CONSTRAINT CHECK1 CHECK
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
);


DROP TABLE ARGUMENTS

CREATE TABLE ARGUMENTS
(
    id             NUMBER(10) NOT NULL,
    sijl_id        NUMBER(10)                 NOT NULL,
    in_response    NUMBER(10)                 NULL,
    
    argument       NVARCHAR2(2000)       NOT NULL,
    title          NVARCHAR2(200)       NULL,
    date_created           DATE DEFAULT SYSTIMESTAMP NOT NULL,

    argument_start NUMBER(5)            NULL,    
    argument_end   NUMBER(5)            NULL,   
    CONSTRAINT PK_DISCUSS_ArgumentID PRIMARY KEY (id),
    FOREIGN KEY (in_response) REFERENCES ARGUMENTS (id),
    FOREIGN KEY (sijl_id) REFERENCES DEBATE_USERS (id),
    CONSTRAINT CHECK1 CHECK
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
);





-- Generate ID using sequence and trigger
CREATE SEQUENCE ARGUMENTS_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER ARGUMENTS_seq_tr
 BEFORE INSERT ON ARGUMENTS FOR EACH ROW
 WHEN (NEW.id IS NULL)
BEGIN
 SELECT ARGUMENTS_seq.NEXTVAL INTO :NEW.id FROM DUAL;
END;
/





-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE DEBATE_TAGS
(
    id       NUMBER(10) NOT NULL,
    tag_name NVARCHAR2(200) UNIQUE, 
    CONSTRAINT PK_DISCUSS_TagsID PRIMARY KEY (id)
);

-- Generate ID using sequence and trigger
CREATE SEQUENCE DEBATE_TAGS_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER DEBATE_TAGS_seq_tr
 BEFORE INSERT ON DEBATE_TAGS FOR EACH ROW
 WHEN (NEW.id IS NULL)
BEGIN
 SELECT DEBATE_TAGS_seq.NEXTVAL INTO :NEW.id FROM DUAL;
END;
/


-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE ARGUMENTS_TAGS
(

    id          NUMBER(10) NOT NULL,
    argument_id NUMBER(10)                 NOT NULL,
    tag_id      NUMBER(10)                 NOT NULL,
    UNIQUE (argument_id, tag_id),
    CONSTRAINT PK_DISCUSS_ArgumentTagsID PRIMARY KEY (id),
    FOREIGN KEY (argument_id) REFERENCES ARGUMENTS (id),
    FOREIGN KEY (tag_id) REFERENCES DEBATE_TAGS (id)
);

-- Generate ID using sequence and trigger
CREATE SEQUENCE ARGUMENTS_TAGS_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER ARGUMENTS_TAGS_seq_tr
 BEFORE INSERT ON ARGUMENTS_TAGS FOR EACH ROW
 WHEN (NEW.id IS NULL)
BEGIN
 SELECT ARGUMENTS_TAGS_seq.NEXTVAL INTO :NEW.id FROM DUAL;
END;
/


-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE VOTES
(
    id          NUMBER(10) NOT NULL,
    sijl_id     NUMBER(10)                 NOT NULL,
    argument_id NUMBER(10)                 NOT NULL,
    UNIQUE (sijl_id, argument_id),
    CONSTRAINT PK_DISCUSS_Vote_ID PRIMARY KEY (id),
    FOREIGN KEY (argument_id) REFERENCES ARGUMENTS (id),
    FOREIGN KEY (sijl_id) REFERENCES DEBATE_USERS (id)
);

-- Generate ID using sequence and trigger
CREATE SEQUENCE VOTES_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER VOTES_seq_tr
 BEFORE INSERT ON VOTES FOR EACH ROW
 WHEN (NEW.id IS NULL)
BEGIN
 SELECT VOTES_seq.NEXTVAL INTO :NEW.id FROM DUAL;
END;
/
