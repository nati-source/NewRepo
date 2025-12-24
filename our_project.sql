create database project_Tracking_and_Managment;
use  project_Tracking_and_Managment

-- ADMIN table
CREATE TABLE ADMIN (
    admin_id INT PRIMARY KEY,
    full_name VARCHAR(20),
    firstName VARCHAR(20),
    middleName VARCHAR(20),
    lastName VARCHAR(20),
    email VARCHAR(20),
    password VARCHAR(20),
    status VARCHAR(10),
    createUserCount INT
);

-- HOD table
CREATE TABLE HOD (
    hod_id INT PRIMARY KEY,
    full_name VARCHAR(20),
    firstName VARCHAR(20),
    middleName VARCHAR(20),
    lastName VARCHAR(20),
    email VARCHAR(20),
    password VARCHAR(20),
    status VARCHAR(10),
    officeNumber VARCHAR(10)
);

-- ADVISOR table
CREATE TABLE ADVISOR (
    advisor_id INT PRIMARY KEY,
    full_name VARCHAR(20),
    firstName VARCHAR(20),
    middleName VARCHAR(20),
    lastName VARCHAR(20),
    email VARCHAR(20),
    password VARCHAR(20),
    status VARCHAR(10),
    course VARCHAR(10)
);


-- GROUP table
CREATE TABLE GROUPS (
    group_id INT PRIMARY KEY,
    group_name VARCHAR(20)
);


-- STUDENT table (without multivalued attributes)
CREATE TABLE STUDENT (
    student_id INT PRIMARY KEY,
    full_name VARCHAR(20),
    firstName VARCHAR(20),
    middleName VARCHAR(20),
    lastName VARCHAR(20),
    email VARCHAR(20),
    password VARCHAR(20),
    status VARCHAR(10),
    group_id INT,
    GPA DECIMAL(3,2),
    FOREIGN KEY (group_id) REFERENCES GROUPS(group_id)
);

-- STUDENT multivalued attributes
CREATE TABLE STUDENT_LOCATION (
    student_id INT,
    location VARCHAR(20),
    PRIMARY KEY (student_id, location),
    FOREIGN KEY (student_id) REFERENCES STUDENT(student_id)
);

CREATE TABLE STUDENT_CONTRIBUTION (
    contribution_id INT PRIMARY KEY,
    student_id INT NOT NULL,
    contribution TEXT NOT NULL,
    FOREIGN KEY (student_id) REFERENCES STUDENT(student_id)
);

-- GROUP schedule (multivalued)
CREATE TABLE GROUP_SCHEDULE (
    group_id INT,
    schedule_item VARCHAR(20),
    PRIMARY KEY (group_id, schedule_item),
    FOREIGN KEY (group_id) REFERENCES GROUPS(group_id)
);

-- PROJECT table
CREATE TABLE PROJECT (
    project_id INT PRIMARY KEY,
    projectName VARCHAR(30),
    group_id INT UNIQUE,
    FOREIGN KEY (group_id) REFERENCES GROUPS(group_id)
);

-- TASK table
CREATE TABLE TASK (
    task_id INT PRIMARY KEY,
    student_id INT,
    project_id INT,
    task_title VARCHAR(30),
    do_date DATE,
    FOREIGN KEY (student_id) REFERENCES STUDENT(student_id),
    FOREIGN KEY (project_id) REFERENCES PROJECT(project_id)
);

-- ASSIGN relationship (Advisor assigns Task to Student)
CREATE TABLE ASSIGN (
    advisor_id INT,
    student_id INT,
    task_id INT,
    assigned_at DATETIME,
    PRIMARY KEY (advisor_id, student_id, task_id),
    FOREIGN KEY (advisor_id) REFERENCES ADVISOR(advisor_id),
    FOREIGN KEY (student_id) REFERENCES STUDENT(student_id),
    FOREIGN KEY (task_id) REFERENCES TASK(task_id)
);

-- MESSAGE table (recursive relationship: any role can send/receive)
CREATE TABLE MESSAGE (
    message_id INT PRIMARY KEY,
    sender_type VARCHAR(40),   -- 'ADMIN', 'HOD', 'ADVISOR', 'STUDENT'
    sender_id INT,
    receiver_type VARCHAR(40), -- same as above
    receiver_id INT,
    message_body TEXT,
    sent_at DATETIME
);