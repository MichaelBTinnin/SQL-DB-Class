--Michael Tinnin
--CIS 243 
--CityJail CH 9


/*1. List all criminals along with the crime charges filed. The report needs to include 
the criminal ID, name, crime code, and fine amount*/
--Traditional
SELECT c.criminal_id, c.last, c.first, cc.crime_code, cc.fine_amount
    FROM criminals c, crimes cr, crime_charges cc
        WHERE c.criminal_id = cr.criminal_id
        AND cr.crime_id = cc.crime_id;
        
--ANSI
SELECT criminal_id, c.last, c.first, cc.crime_code, cc.fine_amount
    FROM criminals c Join crimes cr USING(criminal_id)
    JOIN crime_charges cc USING(crime_id);
    
/*2. List all criminals along with crime status and appeal status(if applicable). The reports need
to include the criminal ID, name, crime classification, date charged, appeal filing date,
and appeal status. Show all criminals, regardless of weather they have filed an appeal*/

--Traditional
SELECT c.criminal_id, c.last, c.first, cr.classification, cr.date_charged, a.filing_date, a.status
    FROM criminals c, crimes cr, appeals a
    WHERE c.criminal_id = cr.criminal_id
    AND cr.crime_id = a.crime_id(+);
    
--ANSI
SELECT criminal_id, c.last, c.first, cr.classification, cr.date_charged, a.filing_date, a.status 
    FROM criminals c JOIN crimes cr USING(criminal_id)
    LEFT OUTER JOIN appeals a USING(crime_id);
    
/*3. List all criminals along with crime information. The report needs to include the criminal ID,
name, crime classification, date charged, crime code, and fine amount. Include only crimes
classified as "Other." Sort the list by criminal IDand date charged*/
--Traditional
SELECT c.criminal_id, c.last, c.first, cr.classification, cr.date_charged, cc.crime_code, cc.fine_amount
    FROM criminals c, crimes cr, crime_charges cc
        WHERE c.criminal_id = cr.criminal_id
        AND cr.crime_id = cc.crime_id
        AND cr.classification = 'O'
            ORDER BY c.criminal_id, cr.date_charged;
            
--ANSI
SELECT criminal_id, c.last, c.first, cr.classification, cr.date_charged, cc.crime_code, cc.fine_amount
    FROM criminals c JOIN crimes cr USING(criminal_id)
    JOIN crime_charges cc USING(crime_id)
        WHERE cr.classification = 'O'
            ORDER BY criminal_id, cr.date_charged;
            
/*4. Create an alphabetical list of all criminals, including criminal ID, name, violent offender status,
parole status, and any known aliases*/

--Traditional
SELECT c.criminal_id, c.last, c.first, c.v_status, c.p_status, a.alias
    FROM aliases a, criminals c
        WHERE a.criminal_id(+) = c.criminal_id
            ORDER BY last, first;
            
--ANSI
SELECT criminal_id, c.last, c.first, c.v_status, c.p_status, a.alias
    FROM aliases a RIGHT OUTER JOIN criminals c USING(criminal_id)
        ORDER BY last, first;
        
/*5. A table named Prob_Contact contains the required frequency of contact with a probation officer,
based on the length of the probation period(the number of days assigned to probation). Review the data in this table,
which indicates ranges for the number of daysand applicable contact frequencies. Create a list containind the 
name of each criminal who has been assigned a probation period, which is indicated by the sentence type. The list should contain the criminal name,
probation start date, probation end date, and required frequency of contact. Sort the list by criminal name and probation start date*/
--Traditional
SELECT c.last, c.first, s.start_date, s.end_date, p.con_freq
    FROM criminals c, sentences s, prob_contact p
        WHERE c.criminal_id = s.criminal_id
        AND s.end_date - s.start_date BETWEEN p.low_amt AND p.high_amt
        AND s.type = 'P'
            ORDER BY last, first, start_date;
            
--ANSI
SELECT c.last, c.first, s.start_date, s.end_date, p.con_freq
    FROM criminals c JOIN sentences s USING(criminal_id)
    JOIN prob_contact p ON s.end_date - s.start_date BETWEEN p.low_amt AND p.high_amt
    ORDER BY last, first, start_date;

/*6. A column named Mgr_ID has been added to the Prob_Officers table and contains the ID
number of the probation supervisor for each officer. Produce a list showing each 
probation officer's name and his or her supervisor's name. Sort the list alphabetically by
probation officer name*/    
--Traditional
SELECT p.last, p.first, s.last || ' ' ||s.first "Supervisor"
    FROM prob_officers p, prob_officers s
        WHERE s.prob_id = p.mgr_id
            ORDER BY p.last, p.first;
            
--ANSI
SELECT p.last, p.first, s.last || ' ' || s.first "Supervisor"
    FROM prob_officers p JOIN prob_officers s
        ON s.prob_id = p.mgr_id
            ORDER BY p.last, p.first;
        
