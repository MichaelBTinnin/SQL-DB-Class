DROP TABLE  criminals CASCADE CONSTRAINTS;
DROP TABLE  crimes CASCADE CONSTRAINTS;
DROP TABLE appeals CASCADE CONSTRAINTS;
DROP TABLE crime_officers CASCADE CONSTRAINTS;
DROP TABLE crime_charges CASCADE CONSTRAINTS;
DROP TABLE aliases CASCADE CONSTRAINTS;
DROP TABLE prob_officers CASCADE CONSTRAINTS;
DROP TABLE sentences CASCADE CONSTRAINTS;
DROP TABLE officers CASCADE CONSTRAINTS;
DROP TABLE crime_codes CASCADE CONSTRAINTS;

CREATE TABLE criminals
  (criminal_id NUMBER(6),
   last VARCHAR2(15),
   first VARCHAR2(10),
   street VARCHAR2(30),
   city VARCHAR2(20),
   state CHAR(2),
   zip CHAR(5),
   phone CHAR(10),
   v_status CHAR(1) DEFAULT 'N',
   p_status CHAR(1) DEFAULT 'N' );
   
CREATE TABLE crimes
  (crime_id NUMBER(9),
   criminal_id NUMBER(6),
   classification CHAR(1),
   date_charged DATE,
   status CHAR(2),
   hearing_date DATE,
   appeal_cut_date DATE);
ALTER TABLE crimes
  MODIFY (classification DEFAULT 'U');
ALTER TABLE crimes
  ADD (date_recorded DATE DEFAULT SYSDATE);
ALTER TABLE criminals
  ADD CONSTRAINT criminals_id_pk PRIMARY KEY (criminal_id);
ALTER TABLE criminals
  ADD CONSTRAINT criminals_vstatus_ck CHECK (v_status IN('Y','N'));
ALTER TABLE criminals
  ADD CONSTRAINT criminals_pstatus_ck CHECK (p_status IN('Y','N'));
ALTER TABLE crimes
  ADD CONSTRAINT crimes_id_pk PRIMARY KEY (crime_id);
ALTER TABLE crimes
  ADD CONSTRAINT crimes_class_ck CHECK (classification IN('F','M','O','U'));
ALTER TABLE crimes
  ADD CONSTRAINT crimes_status_ck CHECK (status IN('CL','CA','IA'));
ALTER TABLE crimes
  ADD CONSTRAINT crimes_criminalid_fk FOREIGN KEY (criminal_id)
             REFERENCES criminals(criminal_id);
ALTER TABLE crimes
  MODIFY (criminal_id NOT NULL);
  
CREATE TABLE appeals
  (appeal_id NUMBER(5),
   crime_id NUMBER(9) NOT NULL,
   filing_date DATE,
   hearing_date DATE,
   status CHAR(1) DEFAULT 'P',
     CONSTRAINT appeals_id_pk PRIMARY KEY (appeal_id),
     CONSTRAINT appeals_crimeid_fk FOREIGN KEY (crime_id)
             REFERENCES crimes(crime_id),
     CONSTRAINT appeals_status_ck CHECK (status IN('P','A','D')) );

CREATE TABLE aliases
  (alias_id NUMBER(6),
  criminal_id NUMBER(6),
  alias VARCHAR2(10));

ALTER TABLE aliases
  ADD CONSTRAINT aliases_id_pk PRIMARY KEY (alias_id);
ALTER TABLE aliases
  ADD CONSTRAINT appeals_criminalid_fk FOREIGN KEY (criminal_id)
             REFERENCES criminals(criminal_id);
ALTER TABLE aliases
  MODIFY (criminal_id NOT NULL);
  
CREATE TABLE prob_officers
  (prob_id NUMBER(5),
  last VARCHAR2(15),
  first VARCHAR2(10),
  street VARCHAR2(30),
  city VARCHAR2(20),
  state CHAR(2),
  zip CHAR(5),
  phone CHAR(10),
  email VARCHAR2(30),
  status CHAR(1) DEFAULT 'A' );  
  
ALTER TABLE prob_officers
   ADD CONSTRAINT probofficers_id_pk PRIMARY KEY (prob_id);
ALTER TABLE prob_officers
  ADD CONSTRAINT probofficers_status_ck CHECK (status IN('A','I'));


CREATE TABLE sentences
  (sentence_id NUMBER(6),
  criminal_id NUMBER(6),
  crime_id NUMBER(9),
  type CHAR(1),
  prob_id NUMBER(5),
  start_date DATE,
  end_date DATE,
  violations NUMBER(3));

ALTER TABLE sentences
  ADD CONSTRAINT sentences_id_pk PRIMARY KEY (sentence_id);
ALTER TABLE sentences
  ADD CONSTRAINT sentences_crimeid_fk FOREIGN KEY (crime_id)
             REFERENCES crimes(crime_id);
ALTER TABLE sentences
  MODIFY (crime_id NOT NULL);
ALTER TABLE sentences
  ADD CONSTRAINT sentences_probid_fk FOREIGN KEY (prob_id)
             REFERENCES prob_officers(prob_id);
ALTER TABLE sentences
  ADD CONSTRAINT sentences_type_ck CHECK (type IN('J','H','P'));

CREATE TABLE officers
  (officer_id NUMBER(8),
  last VARCHAR2(15),
  first VARCHAR2(10),
  precinct CHAR(4),
  badge VARCHAR2(14),
  phone CHAR(10),
  status CHAR(1) DEFAULT 'A' );

ALTER TABLE officers
  ADD CONSTRAINT officers_id_pk PRIMARY KEY (officer_id);
ALTER TABLE officers
  ADD CONSTRAINT officers_status_ck CHECK (status IN('A','I'));

CREATE TABLE crime_officers
  (crime_id NUMBER(9),
   officer_id NUMBER(8),
     CONSTRAINT crimeofficers_cid_oid_pk PRIMARY KEY (crime_id,officer_id),
     CONSTRAINT crimeofficers_crimeid_fk FOREIGN KEY (crime_id)
             REFERENCES crimes(crime_id),
     CONSTRAINT crimeofficers_officerid_fk FOREIGN KEY (officer_id)
             REFERENCES officers(officer_id) );
            
CREATE TABLE crime_codes
  (crime_code NUMBER(3),
  code_description VARCHAR2(30));

ALTER TABLE crime_codes
  ADD CONSTRAINT crimecodes_code_pk PRIMARY KEY (crime_code);

CREATE TABLE crime_charges
  (charge_id NUMBER(10),
   crime_id NUMBER(9) NOT NULL,
   crime_code NUMBER(3) NOT NULL,
   charge_status CHAR(2),
   fine_amount NUMBER(7,2),
   court_fee NUMBER(7,2),
   amount_paid NUMBER(7,2),
   pay_due_date DATE,
     CONSTRAINT crimecharges_id_pk PRIMARY KEY (charge_id),
     CONSTRAINT crimecharges_crimeid_fk FOREIGN KEY (crime_id)
             REFERENCES crimes(crime_id),
     CONSTRAINT crimecharges_code_fk FOREIGN KEY (crime_code)
             REFERENCES crime_codes(crime_code),
     CONSTRAINT crimecharges_status_ck CHECK (charge_status IN('PD','GL','NG')) );


