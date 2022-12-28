--CIty Jail CH 7
--Michael Tinnin
/* Criminal Records Department
Create Session, SELECT, INSERT UPDATE
ON criminals crimes, crime_charges, aliases, crime_codes */

--Create user
CREATE USER bfife
    IDENTIFIED BY password;

--Create the role for the criminal records department
CREATE ROLE c_rec_role;

--Allow anyone with this role to connectto the database
GRANT CREATE SESSION
    TO c_rec_role;
    
--Attach the appropriate privlages to the role (object privileges)
--Reference all tables with the correct schema
GRANT SELECT, INSERT, UPDATE
    ON student.criminals
    TO c_rec_role;
    
GRANT SELECT, INSERT, UPDATE
    ON student.crimes
    TO c_rec_role;
    
GRANT SELECT, INSERT, UPDATE
    ON student.crime_charges
    TO c_rec_role;
    
GRANT SELECT, INSERT, UPDATE
    ON student.aliases
    TO c_rec_role;
    
GRANT SELECT, INSERT, UPDATE
    ON student.officers
    TO c_rec_role;
    
GRANT SELECT, INSERT, UPDATE
    ON student.crime_codes
    TO c_rec_role;
    
--Assign the user to the role
GRANT c_rec_role TO bfife;

/* Court Recording Department 
    CREATE SESSION, SELECT, INSERT, UPDATE ON
    appeals, sentences, prob_officers*/
CREATE USER recording_dept
    IDENTIFIED BY password;

CREATE ROLE c_recording_role;

GRANT CREATE SESSION 
    TO c_recording_role;

GRANT SELECT, INSERT, UPDATE
    ON student.appeals
    TO c_recording_role;
    
GRANT SELECT, INSERT, UPDATE
    ON student.sentences
    TO c_recording_role;
    
GRANT SELECT, INSERT, UPDATE
    ON student.prob_officers
    TO c_recording_role;
    
GRANT c_recording_role TO recording_dept;
/*Crimes analysis department
    CREATE SESSION, SELECT ANY TABLE*/
--CREATE USER
CREATE USER agriffith
    IDENTIFIED BY password;
    
--Create the role for the crimes analysis department
CREATE ROLE c_analysis_role;

--Allow anyone with this role to connect to the database
GRANT CREATE SESSION
    TO c_analysis_role;
    
--Attach the appropriate privileges to the role (object privileges)
--Reference all tables with the correct schema
GRANT SELECT ANY TABLE
    TO c_analysis_role;
    
/*Data officer Remove crimes, court, and probation data based on approved
requests from any of the other departments*/

CREATE USER data_officer
    IDENTIFIED BY password;

CREATE ROLE data_officer_role;
    

GRANT DELETE ANY TABLE
    TO data_officer_role; 
    
GRANT data_officer_role TO data_officer;
    
    