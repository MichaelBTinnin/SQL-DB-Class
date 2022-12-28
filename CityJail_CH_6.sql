--1. Head DBA requested the creation of a sequence for the primary key columns of the Criminals and Crime tables. After creating the sequences
-- add a new Criminal named Johnny Capps to the Criminals table by using the correct sequence. (Use any values for the remainder columns) A crime 
--needs to be added for the criminal, too. Add a row to the Crimes table, referencing the sequence value already generated for the Criminal_Id and using
--the correct sequence to generate the Crime_Id value. (Use any values for the remainder of columns)
DESC criminals;
DESC crimes;
SELECT * FROM criminals;
SELECT * FROM crimes;
DROP SEQUENCE criminals_criminalId_seq;

CREATE SEQUENCE criminals_criminalId_seq;
CREATE SEQUENCE crime_criminal_Id_seq;

INSERT INTO criminals
    VALUES(criminals_criminalId_seq.NEXTVAL, 'Capps', 'Johnny', '1st Street', 'Ft. Collins', 'CO', '80526', '0000000000', NULL, NULL);

INSERT INTO crimes
    VALUES(crime_criminal_ID_seq.NEXTVAL, 3, NULL, NULL, NULL, NULL, NULL, NULL);

--2. The last name, street, and phone number columns of the Criminals table are used quite often
-- in the WHERE clause condition of queries. Create objects that might improve data retrival for these queries
CREATE INDEX criminals_last_idx
    ON criminals(last);
    
CREATE INDEX criminals_street_idx
    ON criminals(street);
    
CREATE INDEX criminals_phone_idx
    ON criminals(phone);

--3. Would a bitmap index be appropriate for any columns in the City Jail database (assuming the columns are used in search and/or sort opperations.)
--If so, identify the columns and explain why a bitmap index is appropriate for them
DESC crimes;
DESC appeals;
DESC crime_charges;
DESC crimes;
DESC sentences;
DESC prob_officers;
DESC officers;
DESC criminals;
DESC crime_officers;
--Regions has low selectivity, status also have low selectivity.
--4. Would using the City Jail database be any easier with the creation of synonyms? Explain why or why not.
--Yes. Synonyms would shorten what is needed to be written to refer to a table in the City Jail database. 
--Synonyms could avoid security risks by hiding actual table names, this would save time recovering your info, if even possible.

