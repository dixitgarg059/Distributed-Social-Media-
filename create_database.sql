DROP DATABASE IF EXISTS DDS;

CREATE SCHEMA DDS;

USE DDS;

CREATE TABLE Horizontal_Fragments (
    Fragment_ID VARCHAR(120) NOT NULL,
    Predicate_Condition VARCHAR(120),
    PRIMARY KEY(Fragment_ID)
);

CREATE TABLE Vertical_Fragments (
    Fragment_ID VARCHAR(120) NOT NULL,
    PRIMARY KEY(Fragment_ID)
);

CREATE TABLE Column_Mappings (
    Fragment_ID VARCHAR(120) NOT NULL,
    COLUMN_NAME VARCHAR(100) NOT NULL
);

CREATE TABLE Derived_Fragments (
    Fragment_ID VARCHAR(120) NOT NULL,
    Derived_Table_Name VARCHAR(100) NOT NULL,
    Derived_Column_Name VARCHAR(120) NOT NULL,
    PRIMARY KEY(Fragment_ID)
);

CREATE TABLE DHF_Mappings (
    Parent_Fragment_ID VARCHAR(120) NOT NULL,
    Child_Fragment_ID VARCHAR(120) NOT NULL,
    FOREIGN KEY (Parent_Fragment_ID) REFERENCES Horizontal_Fragments(Fragment_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Child_Fragment_ID) REFERENCES Derived_Fragments(Fragment_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Sites (
    Site_ID VARCHAR(120) NOT NULL,
    Site_Address VARCHAR(100) NOT NULL,
    Site_Username VARCHAR(100) NOT NULL,
    Site_Password VARCHAR(100) NOT NULL,
    PRIMARY KEY (Site_ID)
);

DROP TABLE IF EXISTS Fragment_Information;

CREATE TABLE Fragment_Information (
    TableName VARCHAR(100) NOT NULL,
    Fragment_Type VARCHAR(12),
    Fragment_ID VARCHAR(120) NOT NULL,
    Vertical_Fragment_ID VARCHAR(120),
    Horizontal_Fragment_ID VARCHAR(120),
    Derived_Fragment_ID VARCHAR(120),
    PRIMARY KEY(Fragment_ID),
    FOREIGN KEY (Vertical_Fragment_ID) REFERENCES Vertical_Fragments(Fragment_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Horizontal_Fragment_ID) REFERENCES Horizontal_Fragments(Fragment_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Derived_Fragment_ID) REFERENCES Derived_Fragments(Fragment_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Fragment_Site_Mapping (
    Site_ID VARCHAR(120) NOT NULL,
    Fragment_ID VARCHAR(120) NOT NULL,
    FOREIGN KEY (Site_ID) REFERENCES Sites(Site_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Fragment_ID) REFERENCES Fragment_Information(Fragment_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

/*insert data to table here that is write insert querries here*/
-- LOCK TABLES Horizontal_Fragments WRITE;
INSERT INTO
    Horizontal_Fragments
VALUES
    ("Post_Fg_1", "author_id, mod with 4, 0"),
    ("Post_Fg_2", "author_id, mod with 4, 1"),
    ("Post_Fg_3", "author_id, mod with 4, 2"),
    ("Post_Fg_4", "author_id, mod with 4, 3"),
    ("Group_Fg_1", "group_type == education"),
    ("Group_Fg_2", "group_type == dating"),
    ("Group_Fg_3", "group_type == entertainment"),
    ("Group_Fg_4", "group_type == lifestyle"),
    (
        "Followers_Fg_1",
        "followed_by_id, mod with 4, 0"
    ),
    (
        "Followers_Fg_2",
        "followed_by_id, mod with 4, 1"
    ),
    (
        "Followers_Fg_3",
        "followed_by_id, mod with 4, 2"
    ),
    (
        "Followers_Fg_4",
        "followed_by_id, mod with 4, 3"
    );

-- UNLOCK TABLES;
-- LOCK TABLES Vertical_Fragments WRITE;
INSERT INTO
    Vertical_Fragments
VALUES
    ("User_Fg_1"),
    ("User_Fg_2");

-- UNLOCK Tables;
-- LOCK TABLES Derived_Fragments WRITE;
INSERT INTO
    Derived_Fragments
VALUES
    ("Reactions_Fg_1", "Post", "post_id"),
    ("Reactions_Fg_2", "Post", "post_id"),
    ("Reactions_Fg_3", "Post", "post_id"),
    ("Reactions_Fg_4", "Post", "post_id"),
    ("Comments_Fg_1", "Post", "post_id"),
    ("Comments_Fg_2", "Post", "post_id"),
    ("Comments_Fg_3", "Post", "post_id"),
    ("Comments_Fg_4", "Post", "post_id"),
    ("Group_Members_Fg_1", "Group", "group_id"),
    ("Group_Members_Fg_2", "Group", "group_id"),
    ("Group_Members_Fg_3", "Group", "group_id"),
    ("Group_Members_Fg_4", "Group", "group_id");

-- UNLOCK Tables;
-- LOCK TABLES Column_Mappings WRITE;
INSERT INTO
    Column_Mappings
VALUES
    ("User_Fg_1", "user_id"),
    ("User_Fg_1", "username"),
    ("User_Fg_1", "password"),
    ("User_Fg_1", "mobile_number"),
    ("User_Fg_2", "user_id"),
    ("User_Fg_2", "profile_name"),
    ("User_Fg_2", "eduction"),
    ("User_Fg_2", "DOB"),
    ("User_Fg_2", "sex"),
    ("User_Fg_2", "relationship_status"),
    ("User_Fg_2", "profile_picture"),
    ("User_Fg_2", "location");

-- UNLOCK Tables;
-- LOCK TABLES Sites WRITE;
INSERT INTO
    Sites
VALUES
    ("Site_1", "10.3.5.215", "user", "iiit123"),
    ("Site_2", "10.3.5.214", "user", "iiit123"),
    ("Site_3", "10.3.5.213", "user", "iiit123"),
    ("Site_4", "10.3.5.212", "user", "iiit123");

-- UNLOCK Tables;
-- LOCK TABLES Fragment_Site_Mapping WRITE;
INSERT INTO
    Fragment_Information
VALUES
    (
        "User",
        "VF",
        "User_VF_1",
        "User_Fg_1",
        NULL,
        NULL
    ),
    (
        "User",
        "VF",
        "User_VF_2",
        "User_Fg_2",
        NULL,
        NULL
    ),
    (
        "Post",
        "HF",
        "Post_HF_1",
        NULL,
        "Post_Fg_1",
        NULL
    ),
    (
        "Post",
        "HF",
        "Post_HF_2",
        NULL,
        "Post_Fg_2",
        NULL
    ),
    (
        "Post",
        "HF",
        "Post_HF_3",
        NULL,
        "Post_Fg_3",
        NULL
    ),
    (
        "Post",
        "HF",
        "Post_HF_4",
        NULL,
        "Post_Fg_4",
        NULL
    ),
    (
        "Reactions",
        "DHF",
        "Reactions_DHF_1",
        NULL,
        NULL,
        "Reactions_Fg_1"
    ),
    (
        "Reactions",
        "DHF",
        "Reactions_DHF_2",
        NULL,
        NULL,
        "Reactions_Fg_2"
    ),
    (
        "Reactions",
        "DHF",
        "Reactions_DHF_3",
        NULL,
        NULL,
        "Reactions_Fg_3"
    ),
    (
        "Reactions",
        "DHF",
        "Reactions_DHF_4",
        NULL,
        NULL,
        "Reactions_Fg_4"
    ),
    (
        "Comments",
        "DHF",
        "Comments_DHF_1",
        NULL,
        NULL,
        "Comments_Fg_1"
    ),
    (
        "Comments",
        "DHF",
        "Comments_DHF_2",
        NULL,
        NULL,
        "Comments_Fg_2"
    ),
    (
        "Comments",
        "DHF",
        "Comments_DHF_3",
        NULL,
        NULL,
        "Comments_Fg_3"
    ),
    (
        "Comments",
        "DHF",
        "Comments_DHF_4",
        NULL,
        NULL,
        "Comments_Fg_4"
    ),
    (
        "Group",
        "HF",
        "Group_HF_1",
        NULL,
        "Group_Fg_1",
        NULL
    ),
    (
        "Group",
        "HF",
        "Group_HF_2",
        NULL,
        "Group_Fg_2",
        NULL
    ),
    (
        "Group",
        "HF",
        "Group_HF_3",
        NULL,
        "Group_Fg_3",
        NULL
    ),
    (
        "Group",
        "HF",
        "Group_HF_4",
        NULL,
        "Group_Fg_4",
        NULL
    ),
    (
        "Group_Members",
        "DHF",
        "Group_Members_DHF_1",
        NULL,
        NULL,
        "Group_Members_Fg_1"
    ),
    (
        "Group_Members",
        "DHF",
        "Group_Members_DHF_2",
        NULL,
        NULL,
        "Group_Members_Fg_2"
    ),
    (
        "Group_Members",
        "DHF",
        "Group_Members_DHF_3",
        NULL,
        NULL,
        "Group_Members_Fg_3"
    ),
    (
        "Group_Members",
        "DHF",
        "Group_Members_DHF_4",
        NULL,
        NULL,
        "Group_Members_Fg_4"
    ),
    (
        "Followers",
        "HF",
        "Followers_HF_1",
        NULL,
        "Followers_Fg_1",
        NULL
    ),
    (
        "Followers",
        "HF",
        "Followers_HF_2",
        NULL,
        "Followers_Fg_2",
        NULL
    ),
    (
        "Followers",
        "HF",
        "Followers_HF_3",
        NULL,
        "Followers_Fg_3",
        NULL
    ),
    (
        "Followers",
        "HF",
        "Followers_HF_4",
        NULL,
        "Followers_Fg_4",
        NULL
    );

INSERT INTO
    Fragment_Site_Mapping
VALUES
    ("Site_1", "User_VF_1"),
    ("Site_2", "User_VF_2"),
    ("Site_1", "Post_HF_1"),
    ("Site_2", "Post_HF_2"),
    ("Site_3", "Post_HF_3"),
    ("Site_4", "Post_HF_4"),
    ("Site_1", "Reactions_DHF_1"),
    ("Site_2", "Reactions_DHF_2"),
    ("Site_3", "Reactions_DHF_3"),
    ("Site_4", "Reactions_DHF_4"),
    ("Site_1", "Comments_DHF_1"),
    ("Site_2", "Comments_DHF_2"),
    ("Site_3", "Comments_DHF_3"),
    ("Site_4", "Comments_DHF_4"),
    ("Site_1", "Group_HF_1"),
    ("Site_2", "Group_HF_2"),
    ("Site_3", "Group_HF_3"),
    ("Site_4", "Group_HF_4"),
    ("Site_1", "Group_Members_DHF_1"),
    ("Site_2", "Group_Members_DHF_2"),
    ("Site_3", "Group_Members_DHF_3"),
    ("Site_4", "Group_Members_DHF_4"),
    ("Site_1", "Followers_HF_1"),
    ("Site_2", "Followers_HF_2"),
    ("Site_3", "Followers_HF_3"),
    ("Site_4", "Followers_HF_4");

-- UNLOCK Tables;