CREATE DATABASE project_tracking_and_management_system;
USE project_tracking_and_management_system;

CREATE TABLE USER (
    user_id VARCHAR(10) PRIMARY KEY,
    firstName VARCHAR(20) NOT NULL,
    middleName VARCHAR(20),
    lastName VARCHAR(20),
    email VARCHAR(30) UNIQUE NOT NULL,
    password VARCHAR(20) NOT NULL,
    status VARCHAR(10)
);

CREATE TABLE ADMIN (
    admin_id VARCHAR(10) PRIMARY KEY,
    createdUserCount INT,
    FOREIGN KEY (admin_id) REFERENCES USER(user_id)
);

CREATE TABLE HOD (
    hod_id VARCHAR(10) PRIMARY KEY,
    officeNumber VARCHAR(10),
    FOREIGN KEY (hod_id) REFERENCES USER(user_id)
);


CREATE TABLE ADVISOR (
    advisor_id VARCHAR(10) PRIMARY KEY,
    course VARCHAR(10),
    FOREIGN KEY (advisor_id) REFERENCES USER(user_id)
);

CREATE TABLE GROUPS (
    group_id INT PRIMARY KEY,
    group_name VARCHAR(20) UNIQUE NOT NULL,
    group_leader_id VARCHAR(10)
);

CREATE TABLE STUDENT (
    student_id VARCHAR(10) PRIMARY KEY,
    gender CHAR(1),
    section CHAR(1),
    GPA DECIMAL(3,2),
    group_id INT,
    FOREIGN KEY (student_id) REFERENCES USER(user_id),
    FOREIGN KEY (group_id) REFERENCES GROUPS(group_id)
);

ALTER TABLE GROUPS
ADD CONSTRAINT FK_GROUP_LEADER
FOREIGN KEY (group_leader_id) REFERENCES STUDENT(student_id);


CREATE TABLE STUDENT_LOCATION (
    student_id VARCHAR(10),
    location VARCHAR(20),
    PRIMARY KEY (student_id, location),
    FOREIGN KEY (student_id) REFERENCES STUDENT(student_id)
);

CREATE TABLE STUDENT_CONTRIBUTION (
    contribution_id VARCHAR(10) PRIMARY KEY,
    student_id VARCHAR(10) NOT NULL,
    contribution TEXT NOT NULL,
    FOREIGN KEY (student_id) REFERENCES STUDENT(student_id)
);

CREATE TABLE PROJECT (
    project_id VARCHAR(10) PRIMARY KEY,
    projectName VARCHAR(30) NOT NULL,
    group_id INT UNIQUE,
    FOREIGN KEY (group_id) REFERENCES GROUPS(group_id)
);

CREATE TABLE TASK (
    task_id VARCHAR(10) PRIMARY KEY,
    task_title VARCHAR(30),
    do_date DATE,
    project_id VARCHAR(10),
    student_id VARCHAR(10),
    FOREIGN KEY (project_id) REFERENCES PROJECT(project_id),
    FOREIGN KEY (student_id) REFERENCES STUDENT(student_id)
);

    advisor_id VARCHAR(10),
    task_id VARCHAR(10),
    assigned_at DATETIME,
    PRIMARY KEY (advisor_id, task_id),
    FOREIGN KEY (advisor_id) REFERENCES ADVISOR(advisor_id),
    FOREIGN KEY (task_id) REFERENCES TASK(task_id)
);


CREATE TABLE MESSAGE (
    message_id VARCHAR(10) PRIMARY KEY,
    sender_id VARCHAR(10),
    receiver_id VARCHAR(10),
    message_body TEXT,
    sent_at DATETIME,
    FOREIGN KEY (sender_id) REFERENCES USER(user_id),
    FOREIGN KEY (receiver_id) REFERENCES USER(user_id)
);
