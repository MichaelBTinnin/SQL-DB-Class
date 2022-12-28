--City Jail CH 8
--1. List all criminal aliases beginning with the letter B

SELECT alias
    FROM aliases
    WHERE alias LIKE 'B%';

--2. List all crimes that occured (were charged) during the month October 2008
--List the crime ID, criminal ID, date charged, and classification
DESC crimes;
SELECT crime_id, criminal_id, date_charged, classification
    FROM crimes
    WHERE date_charged > '30-SEP-08' AND date_charged < '01-NOV-08';

--3. List all crimes with a status of CA (can appeal) or IA (in appeal). 
--List the crime ID, criminal ID, date charged, and status
DESC crimes;
SELECT status FROM crimes;

SELECT crime_id, criminal_id, date_charged, status
    FROM crimes
    WHERE status = 'CA' OR status = 'IA';

--4. List all crimes classified as a felony. List the crime ID, criminal ID, date charged,
--and classification
SELECT * FROM crimes;
SELECT crime_id, criminal_id, date_charged, classification
    FROM crimes
    WHERE classification = 'F';

--5. List all crimes with a hearing date more than 14 days after the date charged.
--List the crime ID, criminal ID, date charged, and hearing date
SELECT crime_id, criminal_id, date_charged, hearing_date
    FROM crimes
    WHERE  hearing_date - date_charged > 14;

--6. List all criminals with the zip code 23510. List the criminal ID, last name,  and zip code.
--Sort the list by criminal ID.
SELECT * FROM criminals;
SELECT criminal_id, last, zip
    FROM criminals
    WHERE zip = '23510';

--7. List all crimes that don't have a hearing date scheduled. List the crime ID, 
--criminal ID, date charged, and hearing date.
SELECT * FROM crimes;
SELECT crime_id, criminal_id, date_charged, hearing_date
    FROM crimes
    WHERE hearing_date IS NULL;

--8. List all sentences with a probation officer assigned. List the sentence ID, 
--criminal ID, and probation officer ID. Sort the list by probation officer ID and then criminal ID
SELECT * FROM sentences;
SELECT sentence_id, criminal_id, prob_id
    FROM sentences
    WHERE prob_id IS NOT NULL
    ORDER BY prob_id, criminal_id;
--9.List all crimes that are classified as misdemeneors and are currently
--in appeal. List the crime ID, criminal ID, classification, and status.
SELECT * FROM crimes;
SELECT crime_id, criminal_id, classification, status
    FROM crimes
    WHERE classification = 'M' AND status = 'IA';
--10. List all crime charges with a balance owed. List the charge ID, crime ID,
--fine amount, court fee, amount paid, and amount owed
SELECT * FROM crime_charges;
SELECT charge_id, crime_id, fine_amount, court_fee, amount_paid, (fine_amount + court_fee) - amount_paid "Amount Owed"
    FROM crime_charges
    WHERE (fine_amount + court_fee) - amount_paid > 0;
--11. List all police officers who are assigned to the precinct OCVW or GHNT
--and have a status of active. List the officer ID, last name, precinct, and status.
--Sort the list by precinct and then by officer last name
SELECT * FROM officers;
SELECT officer_id, last, precinct, status
    FROM officers
    WHERE (precinct = 'OCVW' OR precinct = 'GHNT') AND status = 'A'
    ORDER BY precinct, last;