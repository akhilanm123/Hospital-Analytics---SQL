CREATE TABLE physician (
    employeeid SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    position VARCHAR(100),
    ssn VARCHAR(20) UNIQUE NOT NULL
);
CREATE TABLE department (
    departmentid SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    head INT REFERENCES physician(employeeid)
);
CREATE TABLE affiliated_with (
    physician INT REFERENCES physician(employeeid),
    department INT REFERENCES department(departmentid),
    primaryaffiliation BOOLEAN,
    PRIMARY KEY (physician, department)
);
CREATE TABLE procedure (
    procedure_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    cost DECIMAL(10,2) NOT NULL
);
CREATE TABLE trained_in (
    physician INT REFERENCES physician(employeeid),
    treatment INT REFERENCES procedure(procedure_id),
    certificationdate DATE NOT NULL,
    certificationexpires DATE NOT NULL,
    PRIMARY KEY (physician, treatment)
);

CREATE TABLE patient (
    ssn VARCHAR(20) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address TEXT,
    phone VARCHAR(15),
    insuranceid VARCHAR(20),
    pcp INT REFERENCES physician(employeeid)  -- Primary Care Physician
);
CREATE TABLE nurse (
    employeeid SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    position VARCHAR(100),
    registered BOOLEAN,
    ssn VARCHAR(20) UNIQUE NOT NULL
);
CREATE TABLE appointment (
    appointmentid SERIAL PRIMARY KEY,
    patient VARCHAR(20) REFERENCES patient(ssn),
    prepnurse INT REFERENCES nurse(employeeid),
    physician INT REFERENCES physician(employeeid),
    start_dt_time TIMESTAMP NOT NULL,
    end_dt_time TIMESTAMP NOT NULL,
    examinationroom VARCHAR(20)
);
CREATE TABLE medication (
    medication_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    brand VARCHAR(100),
    description TEXT
);
CREATE TABLE prescribes (
    physician INT REFERENCES physician(employeeid),
    patient VARCHAR(20) REFERENCES patient(ssn),
    medication INT REFERENCES medication(medication_id),
    date TIMESTAMP NOT NULL,
    appointment INT REFERENCES appointment(appointmentid),
    dose VARCHAR(50),
    PRIMARY KEY (physician, patient, medication, date)
);

CREATE TABLE block (
    blockfloor INT,
    blockcode INT,
    PRIMARY KEY (blockfloor, blockcode)
);
CREATE TABLE room (
    roomnumber SERIAL PRIMARY KEY,
    roomtype VARCHAR(50),
    blockfloor INT,
    blockcode INT,
    unavailable BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (blockfloor, blockcode) REFERENCES block(blockfloor, blockcode)
);
CREATE TABLE on_call (
    nurse INT REFERENCES nurse(employeeid),
    blockfloor INT,
    blockcode INT,
    oncallstart TIMESTAMP NOT NULL,
    oncallend TIMESTAMP NOT NULL,
    PRIMARY KEY (nurse, blockfloor, blockcode, oncallstart, oncallend),
    FOREIGN KEY (blockfloor, blockcode) REFERENCES block(blockfloor, blockcode)
);
CREATE TABLE stay (
    stay_id SERIAL PRIMARY KEY,
    patient VARCHAR(20) REFERENCES patient(ssn),
    room INT REFERENCES room(roomnumber),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL
);
CREATE TABLE undergoes (
    patient VARCHAR(20) REFERENCES patient(ssn),
    procedure INT REFERENCES procedure(procedure_id),
    stay INT REFERENCES stay(stay_id),
    date DATE NOT NULL,
    physician INT REFERENCES physician(employeeid),
    assistingnurse INT REFERENCES nurse(employeeid),
    PRIMARY KEY (patient, procedure, stay, date)
);
SELECT table_name FROM information_schema.tables 
WHERE table_schema = 'public';

--------------------------------------

INSERT INTO physician (name, position, ssn) VALUES
('Dr. James Carter', 'Cardiologist', '111-22-3333'),
('Dr. Emily Watson', 'Neurologist', '222-33-4444'),
('Dr. Michael Brown', 'Orthopedic Surgeon', '333-44-5555'),
('Dr. Sophia Martinez', 'Pediatrician', '444-55-6666'),
('Dr. Daniel Anderson', 'General Physician', '555-66-7777'),
('Dr. Olivia Thompson', 'Dermatologist', '666-77-8888');

INSERT INTO department (name, head) VALUES
('Cardiology', 1),
('Neurology', 2),
('Orthopedics', 3),
('Pediatrics', 4),
('General Medicine', 5);

INSERT INTO affiliated_with (physician, department, primaryaffiliation) VALUES
(1, 1, TRUE),
(2, 2, TRUE),
(3, 3, TRUE),
(4, 4, TRUE),
(5, 5, TRUE),
(6, 5, FALSE);

INSERT INTO patient (ssn, name, address, phone, insuranceid, pcp) VALUES
('100000001', 'Alice Johnson', '123 Maple St', '555-1010', 'INS-001', 5),
('100000002', 'Bob Williams', '456 Oak Ave', '555-1020', 'INS-002', 6),
('100000003', 'Charlie Brown', '789 Pine Rd', '555-1030', 'INS-003', 5),
('100000004', 'Daisy Evans', '159 Cedar Ln', '555-1040', 'INS-004', 1),
('100000005', 'Ethan Wright', '753 Spruce St', '555-1050', 'INS-005', 3),
('100000006', 'Fiona Harper', '951 Birch Dr', '555-1060', 'INS-006', 2),
('100000007', 'George Anderson', '852 Redwood Blvd', '555-1070', 'INS-007', 1),
('100000008', 'Hannah Lewis', '369 Palm St', '555-1080', 'INS-008', 4),
('100000009', 'Ian Walker', '258 Magnolia Ave', '555-1090', 'INS-009', 6),
('100000010', 'Jasmine Carter', '147 Ashwood Rd', '555-1100', 'INS-010', 2),
('100000011', 'Kevin Parker', '321 Elm St', '555-1110', 'INS-011', 5),
('100000012', 'Laura Mitchell', '654 Cedar Ave', '555-1120', 'INS-012', 4),
('100000013', 'Mason Scott', '987 Birch Blvd', '555-1130', 'INS-013', 3),
('100000014', 'Natalie Adams', '741 Pine Ct', '555-1140', 'INS-014', 1),
('100000015', 'Oliver Thompson', '852 Oakwood Dr', '555-1150', 'INS-015', 6),
('100000016', 'Penelope Hall', '963 Maple Ln', '555-1160', 'INS-016', 2),
('100000017', 'Quinn White', '357 Redwood St', '555-1170', 'INS-017', 5),
('100000018', 'Ryan King', '159 Willow Rd', '555-1180', 'INS-018', 4),
('100000019', 'Sophia Foster', '789 Juniper Ct', '555-1190', 'INS-019', 3),
('100000020', 'Tristan Young', '654 Spruce Ave', '555-1200', 'INS-020', 1),
('100000021', 'Ursula Carter', '951 Cypress Ln', '555-1210', 'INS-021', 6),
('100000022', 'Vincent Robinson', '357 Oakwood Dr', '555-1220', 'INS-022', 2),
('100000023', 'Wendy Cooper', '159 Maple Ct', '555-1230', 'INS-023', 5),
('100000024', 'Xander Harris', '963 Pine St', '555-1240', 'INS-024', 4),
('100000025', 'Yasmine Bennett', '741 Elm Rd', '555-1250', 'INS-025', 3),
('100000026', 'Zachary Collins', '852 Cedar Ave', '555-1260', 'INS-026', 1),
('100000027', 'Abigail Turner', '357 Juniper St', '555-1270', 'INS-027', 6),
('100000028', 'Brandon Scott', '951 Willow Rd', '555-1280', 'INS-028', 2),
('100000029', 'Catherine Parker', '159 Redwood Ct', '555-1290', 'INS-029', 5),
('100000030', 'Daniel Adams', '654 Birch Ln', '555-1300', 'INS-030', 4),
('100000031', 'Emma Lewis', '789 Spruce St', '555-1310', 'INS-031', 3),
('100000032', 'Felix Hall', '963 Cedar Rd', '555-1320', 'INS-032', 1),
('100000033', 'Grace Young', '741 Maple Dr', '555-1330', 'INS-033', 6),
('100000034', 'Henry King', '852 Pine St', '555-1340', 'INS-034', 2),
('100000035', 'Isabella Carter', '357 Oakwood Rd', '555-1350', 'INS-035', 5),
('100000036', 'Jack Robinson', '951 Elm Ct', '555-1360', 'INS-036', 4),
('100000037', 'Katherine Foster', '159 Cypress Ln', '555-1370', 'INS-037', 3),
('100000038', 'Liam Bennett', '654 Willow St', '555-1380', 'INS-038', 1),
('100000039', 'Mia Collins', '789 Redwood Ave', '555-1390', 'INS-039', 6),
('100000040', 'Noah Turner', '963 Spruce Rd', '555-1400', 'INS-040', 2),
('100000041', 'Olivia Parker', '741 Juniper Ct', '555-1410', 'INS-041', 5),
('100000042', 'Paul Scott', '852 Birch Ln', '555-1420', 'INS-042', 4),
('100000043', 'Quincy Adams', '357 Cedar Dr', '555-1430', 'INS-043', 3),
('100000044', 'Rebecca Lewis', '159 Oakwood Rd', '555-1440', 'INS-044', 1),
('100000045', 'Samuel King', '654 Elm St', '555-1450', 'INS-045', 6),
('100000046', 'Tina Young', '789 Pine Ave', '555-1460', 'INS-046', 2),
('100000047', 'Ulysses Carter', '963 Maple Rd', '555-1470', 'INS-047', 5),
('100000048', 'Victoria Robinson', '741 Cypress St', '555-1480', 'INS-048', 4),
('100000049', 'William Foster', '852 Willow Ln', '555-1490', 'INS-049', 3),
('100000050', 'Zoe Mitchell', '987 Juniper Ct', '555-1500', 'INS-050', 4);
INSERT INTO nurse (name, position, registered, ssn) VALUES
('Emma Wilson', 'Head Nurse', TRUE, '777-88-9999'),
('Noah Davis', 'Assistant Nurse', FALSE, '888-99-0000'),
('Liam Robinson', 'ICU Nurse', TRUE, '999-00-1111'),
('Ava Thomas', 'Pediatrics Nurse', TRUE, '111-22-3333'),
('Mason Hall', 'General Nurse', FALSE, '222-33-4444'),
('Sophia White', 'Surgical Nurse', TRUE, '333-44-5555'),
('James Young', 'Emergency Nurse', TRUE, '444-55-6666'),
('Charlotte King', 'Cardiology Nurse', TRUE, '555-66-7777');
INSERT INTO appointment (patient, prepnurse, physician, start_dt_time, end_dt_time, examinationroom) VALUES
('100000001', 1, 5, '2025-02-01 09:00:00', '2025-02-01 09:30:00', 'Room 101'),
('100000002', 2, 6, '2025-02-02 10:00:00', '2025-02-02 10:30:00', 'Room 102'),
('100000003', 3, 5, '2025-02-03 11:00:00', '2025-02-03 11:30:00', 'Room 103'),
('100000004', 4, 1, '2025-02-04 12:00:00', '2025-02-04 12:30:00', 'Room 104'),
('100000005', 5, 3, '2025-02-05 13:00:00', '2025-02-05 13:30:00', 'Room 105'),
('100000006', 6, 2, '2025-02-06 14:00:00', '2025-02-06 14:30:00', 'Room 106'),
('100000007', 7, 1, '2025-02-07 15:00:00', '2025-02-07 15:30:00', 'Room 107'),
('100000008', 8, 4, '2025-02-08 16:00:00', '2025-02-08 16:30:00', 'Room 108'),
('100000009', 1, 6, '2025-02-09 09:00:00', '2025-02-09 09:30:00', 'Room 101'),
('100000010', 2, 2, '2025-02-10 10:00:00', '2025-02-10 10:30:00', 'Room 102'),
('100000011', 3, 5, '2025-02-11 11:00:00', '2025-02-11 11:30:00', 'Room 103'),
('100000012', 4, 4, '2025-02-12 12:00:00', '2025-02-12 12:30:00', 'Room 104'),
('100000013', 5, 3, '2025-02-13 13:00:00', '2025-02-13 13:30:00', 'Room 105'),
('100000014', 6, 1, '2025-02-14 14:00:00', '2025-02-14 14:30:00', 'Room 106'),
('100000015', 7, 2, '2025-02-15 15:00:00', '2025-02-15 15:30:00', 'Room 107'),
('100000016', 8, 5, '2025-02-16 16:00:00', '2025-02-16 16:30:00', 'Room 108'),
('100000017', 1, 6, '2025-02-17 09:00:00', '2025-02-17 09:30:00', 'Room 101'),
('100000018', 2, 3, '2025-02-18 10:00:00', '2025-02-18 10:30:00', 'Room 102'),
('100000019', 3, 1, '2025-02-19 11:00:00', '2025-02-19 11:30:00', 'Room 103'),
('100000020', 4, 4, '2025-02-20 12:00:00', '2025-02-20 12:30:00', 'Room 104'),
('100000021', 5, 5, '2025-02-21 13:00:00', '2025-02-21 13:30:00', 'Room 105'),
('100000022', 6, 2, '2025-02-22 14:00:00', '2025-02-22 14:30:00', 'Room 106'),
('100000023', 7, 1, '2025-02-23 15:00:00', '2025-02-23 15:30:00', 'Room 107'),
('100000024', 8, 3, '2025-02-24 16:00:00', '2025-02-24 16:30:00', 'Room 108'),
('100000025', 1, 6, '2025-02-25 09:00:00', '2025-02-25 09:30:00', 'Room 101'),
('100000026', 2, 2, '2025-02-26 10:00:00', '2025-02-26 10:30:00', 'Room 102'),
('100000027', 3, 5, '2025-02-27 11:00:00', '2025-02-27 11:30:00', 'Room 103'),
('100000028', 4, 4, '2025-02-28 12:00:00', '2025-02-28 12:30:00', 'Room 104'),
('100000029', 5, 3, '2025-02-01 13:00:00', '2025-02-01 13:30:00', 'Room 105'),
('100000030', 6, 1, '2025-02-02 14:00:00', '2025-02-02 14:30:00', 'Room 106'),
('100000031', 7, 2, '2025-02-03 15:00:00', '2025-02-03 15:30:00', 'Room 107'),
('100000032', 8, 5, '2025-02-04 16:00:00', '2025-02-04 16:30:00', 'Room 108'),
('100000033', 1, 6, '2025-02-05 09:00:00', '2025-02-05 09:30:00', 'Room 101'),
('100000034', 2, 3, '2025-02-06 10:00:00', '2025-02-06 10:30:00', 'Room 102'),
('100000035', 3, 1, '2025-02-07 11:00:00', '2025-02-07 11:30:00', 'Room 103'),
('100000036', 4, 4, '2025-02-08 12:00:00', '2025-02-08 12:30:00', 'Room 104'),
('100000037', 5, 5, '2025-02-09 13:00:00', '2025-02-09 13:30:00', 'Room 105'),
('100000038', 6, 2, '2025-02-10 14:00:00', '2025-02-10 14:30:00', 'Room 106'),
('100000039', 7, 1, '2025-02-11 15:00:00', '2025-02-11 15:30:00', 'Room 107'),
('100000040', 8, 3, '2025-02-12 16:00:00', '2025-02-12 16:30:00', 'Room 108'),
('100000041', 1, 6, '2025-02-13 09:00:00', '2025-02-13 09:30:00', 'Room 101'),
('100000042', 2, 3, '2025-02-14 10:00:00', '2025-02-14 10:30:00', 'Room 102'),
('100000043', 3, 1, '2025-02-15 11:00:00', '2025-02-15 11:30:00', 'Room 103'),
('100000044', 4, 4, '2025-02-16 12:00:00', '2025-02-16 12:30:00', 'Room 104'),
('100000045', 5, 5, '2025-02-17 13:00:00', '2025-02-17 13:30:00', 'Room 105'),
('100000046', 6, 2, '2025-02-18 14:00:00', '2025-02-18 14:30:00', 'Room 106'),
('100000047', 7, 1, '2025-02-19 15:00:00', '2025-02-19 15:30:00', 'Room 107'),
('100000048', 8, 3, '2025-02-20 16:00:00', '2025-02-20 16:30:00', 'Room 108'),
('100000049', 1, 6, '2025-02-21 09:00:00', '2025-02-21 09:30:00', 'Room 101'),
('100000050', 2, 2, '2025-02-22 10:00:00', '2025-02-22 10:30:00', 'Room 102');
INSERT INTO medication (medication_id, name, brand, description) VALUES
(1, 'Paracetamol', 'MedCo', 'Pain reliever and fever reducer'),
(2, 'Aspirin', 'Pharma Inc.', 'Anti-inflammatory and blood thinner'),
(3, 'Amoxicillin', 'HealthCorp', 'Antibiotic used to treat bacterial infections'),
(4, 'Ibuprofen', 'MediLife', 'Nonsteroidal anti-inflammatory drug (NSAID) for pain relief'),
(5, 'Metformin', 'Diabetex', 'Used for type 2 diabetes management'),
(6, 'Losartan', 'CardioPharm', 'Used to treat high blood pressure and heart failure'),
(7, 'Atorvastatin', 'CholestMed', 'Used to lower cholesterol levels'),
(8, 'Cetirizine', 'AllergyRelief', 'Antihistamine for allergy treatment'),
(9, 'Omeprazole', 'GastroCare', 'Reduces stomach acid, used for GERD treatment'),
(10, 'Prednisone', 'SteroidMeds', 'Corticosteroid for inflammation and immune suppression'),
(11, 'Albuterol', 'Respira', 'Bronchodilator used for asthma and breathing disorders'),
(12, 'Hydrochlorothiazide', 'DiureticPlus', 'Diuretic used to treat high blood pressure and fluid retention');
INSERT INTO prescribes (physician, patient, medication, date, appointment, dose) VALUES
(1, '100000001', 1, '2025-02-01 09:30:00', 1, '500mg'),
(2, '100000002', 2, '2025-02-02 10:30:00', 2, '250mg'),
(3, '100000003', 3, '2025-02-03 11:30:00', 3, '500mg'),
(4, '100000004', 4, '2025-02-04 12:30:00', 4, '200mg'),
(5, '100000005', 5, '2025-02-05 13:30:00', 5, '850mg'),
(6, '100000006', 6, '2025-02-06 14:30:00', 6, '50mg'),
(1, '100000007', 7, '2025-02-07 15:30:00', 7, '10mg'),
(2, '100000008', 8, '2025-02-08 16:30:00', 8, '10mg'),
(3, '100000009', 9, '2025-02-09 09:30:00', 9, '20mg'),
(4, '100000010', 10, '2025-02-10 10:30:00', 10, '10mg'),
(5, '100000011', 11, '2025-02-11 11:30:00', 11, '90mcg'),
(6, '100000012', 12, '2025-02-12 12:30:00', 12, '25mg'),
(1, '100000013', 1, '2025-02-13 13:30:00', 13, '500mg'),
(2, '100000014', 2, '2025-02-14 14:30:00', 14, '250mg'),
(3, '100000015', 3, '2025-02-15 15:30:00', 15, '500mg'),
(4, '100000016', 4, '2025-02-16 16:30:00', 16, '200mg'),
(5, '100000017', 5, '2025-02-17 09:30:00', 17, '850mg'),
(6, '100000018', 6, '2025-02-18 10:30:00', 18, '50mg'),
(1, '100000019', 7, '2025-02-19 11:30:00', 19, '10mg'),
(2, '100000020', 8, '2025-02-20 12:30:00', 20, '10mg'),
(3, '100000021', 9, '2025-02-21 13:30:00', 21, '20mg'),
(4, '100000022', 10, '2025-02-22 14:30:00', 22, '10mg'),
(5, '100000023', 11, '2025-02-23 15:30:00', 23, '90mcg'),
(6, '100000024', 12, '2025-02-24 16:30:00', 24, '25mg'),
(1, '100000025', 1, '2025-02-25 09:30:00', 25, '500mg'),
(2, '100000026', 2, '2025-02-26 10:30:00', 26, '250mg'),
(3, '100000027', 3, '2025-02-27 11:30:00', 27, '500mg'),
(4, '100000028', 4, '2025-02-28 12:30:00', 28, '200mg'),
(5, '100000029', 5, '2025-02-01 13:30:00', 29, '850mg'),
(6, '100000030', 6, '2025-02-02 14:30:00', 30, '50mg'),
(1, '100000031', 7, '2025-02-03 15:30:00', 31, '10mg'),
(2, '100000032', 8, '2025-02-04 16:30:00', 32, '10mg'),
(3, '100000033', 9, '2025-02-05 09:30:00', 33, '20mg'),
(4, '100000034', 10, '2025-02-06 10:30:00', 34, '10mg'),
(5, '100000035', 11, '2025-02-07 11:30:00', 35, '90mcg'),
(6, '100000036', 12, '2025-02-08 12:30:00', 36, '25mg'),
(1, '100000037', 1, '2025-02-09 13:30:00', 37, '500mg'),
(2, '100000038', 2, '2025-02-10 14:30:00', 38, '250mg'),
(3, '100000039', 3, '2025-02-11 15:30:00', 39, '500mg'),
(4, '100000040', 4, '2025-02-12 16:30:00', 40, '200mg'),
(5, '100000041', 5, '2025-02-13 09:30:00', 41, '850mg'),
(6, '100000042', 6, '2025-02-14 10:30:00', 42, '50mg'),
(1, '100000043', 7, '2025-02-15 11:30:00', 43, '10mg'),
(2, '100000044', 8, '2025-02-16 12:30:00', 44, '10mg'),
(3, '100000045', 9, '2025-02-17 13:30:00', 45, '20mg'),
(4, '100000046', 10, '2025-02-18 14:30:00', 46, '10mg'),
(5, '100000047', 11, '2025-02-19 15:30:00', 47, '90mcg'),
(6, '100000048', 12, '2025-02-20 16:30:00', 48, '25mg'),
(1, '100000049', 1, '2025-02-21 09:30:00', 49, '500mg'),
(2, '100000050', 2, '2025-02-22 10:30:00', 50, '250mg');

SELECT * FROM room;
SELECT * FROM room;
SELECT * FROM block;
INSERT INTO block (blockfloor, blockcode) VALUES
(1, 1),
(2, 2);
SELECT * FROM block;
INSERT INTO block (blockfloor, blockcode) VALUES (3, 3);



INSERT INTO room (roomnumber, roomtype, blockfloor, blockcode, unavailable) VALUES
(111, 'Deluxe', 1, 1, FALSE),
(112, 'Private', 2, 2, FALSE),
(113, 'General', 3, 3, TRUE),
(114, 'General', 1, 1, FALSE),
(115, 'ICU', 2, 2, TRUE),
(116, 'Deluxe', 3, 3, FALSE),
(117, 'Private', 2, 2, TRUE),
(118, 'General', 3, 3, FALSE),
(119, 'ICU', 1, 1, TRUE),
(120, 'Deluxe', 2, 2, FALSE);



INSERT INTO stay (patient, room, start_date, end_date) VALUES
('100000001', 101, '2025-02-01', '2025-02-05'),
('100000002', 102, '2025-02-02', '2025-02-06'),
('100000003', 103, '2025-02-03', '2025-02-07'),
('100000004', 104, '2025-02-04', '2025-02-08'),
('100000005', 105, '2025-02-05', '2025-02-09'),
('100000006', 106, '2025-02-06', '2025-02-10'),
('100000007', 107, '2025-02-07', '2025-02-11'),
('100000008', 108, '2025-02-08', '2025-02-12'),
('100000009', 109, '2025-02-09', '2025-02-13'),
('100000010', 110, '2025-02-10', '2025-02-14'),
('100000011', 111, '2025-02-11', '2025-02-15'),
('100000012', 112, '2025-02-12', '2025-02-16'),
('100000013', 113, '2025-02-13', '2025-02-17'),
('100000014', 114, '2025-02-14', '2025-02-18'),
('100000015', 115, '2025-02-15', '2025-02-19'),
('100000016', 116, '2025-02-16', '2025-02-20'),
('100000017', 117, '2025-02-17', '2025-02-21'),
('100000018', 118, '2025-02-18', '2025-02-22'),
('100000019', 119, '2025-02-19', '2025-02-23'),
('100000020', 120, '2025-02-20', '2025-02-24'),
('100000021', 101, '2025-02-21', '2025-02-25'),
('100000022', 102, '2025-02-22', '2025-02-26'),
('100000023', 103, '2025-02-23', '2025-02-27'),
('100000024', 104, '2025-02-24', '2025-02-28'),
('100000025', 105, '2025-02-25', '2025-03-01'),
('100000026', 106, '2025-02-26', '2025-03-02'),
('100000027', 107, '2025-02-27', '2025-03-03'),
('100000028', 108, '2025-02-28', '2025-03-04'),
('100000029', 109, '2025-03-01', '2025-03-05'),
('100000030', 110, '2025-03-02', '2025-03-06');

select * from patient
SELECT ssn FROM patient WHERE ssn IN ('10000001', '10000002', '10000003');

select * from undergoes
SELECT * FROM procedure;
INSERT INTO procedure (procedure_id, name, cost) VALUES
(101, 'Appendectomy', 5000),
(102, 'Bypass Surgery', 15000),
(103, 'Knee Replacement', 12000),
(104, 'Cataract Surgery', 3000),
(105, 'MRI Scan', 2000),
(106, 'CT Scan', 2500),
(107, 'Blood Test', 500),
(108, 'Chemotherapy', 8000),
(109, 'Dialysis', 3500),
(110, 'Hip Replacement', 13000);


SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'stay'

select * from stay
SELECT stay_id FROM stay ORDER BY stay_id;
SELECT MAX(stay_id) FROM stay
select * from physician

INSERT INTO stay (stay_id, patient, room, start_date, end_date) VALUES
(91, '100000001', 101, '2025-02-01', '2025-02-05'),
(92, '100000002', 102, '2025-02-02', '2025-02-06'),
(93, '100000003', 103, '2025-02-03', '2025-02-07'),
(94, '100000004', 104, '2025-02-04', '2025-02-08'),
(95, '100000005', 105, '2025-02-05', '2025-02-09'),
(96, '100000006', 106, '2025-02-06', '2025-02-10'),
(97, '100000007', 107, '2025-02-07', '2025-02-11'),
(98, '100000008', 108, '2025-02-08', '2025-02-12'),
(99, '100000009', 109, '2025-02-09', '2025-02-13'),
(100, '100000010', 110, '2025-02-10', '2025-02-14');

select * from physician
select employeeid from nurse
SELECT procedure_id FROM procedure;


INSERT INTO undergoes (patient, procedure, stay, date, physician, assistingnurse) VALUES
('100000001', 101, 91, '2025-02-01', 1, 2),
('100000002', 102, 92, '2025-02-02', 2, 3),
('100000003', 103, 93, '2025-02-03', 3, 4),
('100000004', 104, 94, '2025-02-04', 4, 5),
('100000005', 105, 95, '2025-02-05', 5, 6),
('100000006', 106, 96, '2025-02-06', 6, 7),
('100000007', 107, 97, '2025-02-07', 1, 8),
('100000008', 108, 98, '2025-02-08', 2, 1),
('100000009', 109, 99, '2025-02-09', 3, 2),
('100000010', 110, 100, '2025-02-10', 4, 3),
('100000011', 101, 91, '2025-02-11', 5, 4),
('100000012', 102, 92, '2025-02-12', 6, 5),
('100000013', 103, 93, '2025-02-13', 1, 6),
('100000014', 104, 94, '2025-02-14', 2, 7),
('100000015', 105, 95, '2025-02-15', 3, 8),
('100000016', 106, 96, '2025-02-16', 4, 1),
('100000017', 107, 97, '2025-02-17', 5, 2),
('100000018', 108, 98, '2025-02-18', 6, 3),
('100000019', 109, 99, '2025-02-19', 1, 4),
('100000020', 110, 100, '2025-02-20', 2, 5),
('100000021', 101, 91, '2025-02-21', 3, 6),
('100000022', 102, 92, '2025-02-22', 4, 7),
('100000023', 103, 93, '2025-02-23', 5, 8),
('100000024', 104, 94, '2025-02-24', 6, 1),
('100000025', 105, 95, '2025-02-25', 1, 2);

select * from on_call
SELECT * FROM block;
INSERT INTO block (blockfloor, blockcode) VALUES
(4, 4),
(5, 5);


INSERT INTO on_call (nurse, blockfloor, blockcode, oncallstart, oncallend) VALUES
(1, 1, 1, '2025-02-01 08:00:00', '2025-02-01 16:00:00'),
(2, 2, 2, '2025-02-01 16:00:00', '2025-02-02 00:00:00'),
(3, 3, 3, '2025-02-02 00:00:00', '2025-02-02 08:00:00'),
(4, 1, 1, '2025-02-02 08:00:00', '2025-02-02 16:00:00'),
(5, 2, 2, '2025-02-02 16:00:00', '2025-02-03 00:00:00'),
(6, 3, 3, '2025-02-03 00:00:00', '2025-02-03 08:00:00'),
(7, 4, 4, '2025-02-03 08:00:00', '2025-02-03 16:00:00'),
(8, 5, 5, '2025-02-03 16:00:00', '2025-02-04 00:00:00'),
(1, 2, 2, '2025-02-04 00:00:00', '2025-02-04 08:00:00'),
(2, 3, 3, '2025-02-04 08:00:00', '2025-02-04 16:00:00'),
(3, 4, 4, '2025-02-04 16:00:00', '2025-02-05 00:00:00'),
(4, 5, 5, '2025-02-05 00:00:00', '2025-02-05 08:00:00'),
(5, 1, 1, '2025-02-05 08:00:00', '2025-02-05 16:00:00'),
(6, 2, 2, '2025-02-05 16:00:00', '2025-02-06 00:00:00'),
(7, 3, 3, '2025-02-06 00:00:00', '2025-02-06 08:00:00'),
(8, 4, 4, '2025-02-06 08:00:00', '2025-02-06 16:00:00'),
(1, 5, 5, '2025-02-06 16:00:00', '2025-02-07 00:00:00'),
(2, 1, 1, '2025-02-07 00:00:00', '2025-02-07 08:00:00'),
(3, 2, 2, '2025-02-07 08:00:00', '2025-02-07 16:00:00'),
(4, 3, 3, '2025-02-07 16:00:00', '2025-02-08 00:00:00'),
(5, 4, 4, '2025-02-08 00:00:00', '2025-02-08 08:00:00'),
(6, 5, 5, '2025-02-08 08:00:00', '2025-02-08 16:00:00'),
(7, 1, 1, '2025-02-08 16:00:00', '2025-02-09 00:00:00'),
(8, 2, 2, '2025-02-09 00:00:00', '2025-02-09 08:00:00'),
(1, 3, 3, '2025-02-09 08:00:00', '2025-02-09 16:00:00');

SELECT * FROM trained_in;
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'trained_in';

SELECT * FROM trained_in ORDER BY physician, treatment;

SELECT * FROM trained_in;
ROLLBACK;
TRUNCATE TABLE trained_in RESTART IDENTITY CASCADE;
SELECT conname, conrelid::regclass AS table_name, confrelid::regclass AS foreign_table_name 
FROM pg_constraint 
WHERE conname = 'trained_in_pkey';

INSERT INTO trained_in (physician, treatment, certificationdate, certificationexpires)
VALUES
(1, 101, '2023-01-01', '2028-01-01'),
(2, 102, '2023-02-01', '2028-02-01'),
(3, 103, '2023-03-01', '2028-03-01'),
(4, 104, '2023-04-01', '2028-04-01'),
(5, 105, '2023-05-01', '2028-05-01'),
(6, 106, '2023-06-01', '2028-06-01'),
(1, 107, '2023-07-01', '2028-07-01'),
(2, 108, '2023-08-01', '2028-08-01'),
(3, 109, '2023-09-01', '2028-09-01'),
(4, 110, '2023-10-01', '2028-10-01');
INSERT INTO trained_in (physician, treatment, certificationdate, certificationexpires)
VALUES
(5, 101, '2023-11-01', '2028-11-01'),
(6, 102, '2023-12-01', '2028-12-01'),
(1, 103, '2024-01-01', '2029-01-01'),
(2, 104, '2024-02-01', '2029-02-01'),
(3, 105, '2024-03-01', '2029-03-01'),
(4, 106, '2024-04-01', '2029-04-01'),
(5, 107, '2024-05-01', '2029-05-01'),
(6, 108, '2024-06-01', '2029-06-01'),
(1, 109, '2024-07-01', '2029-07-01'),
(2, 110, '2024-08-01', '2029-08-01'),
(3, 101, '2024-09-01', '2029-09-01'),
(4, 102, '2024-10-01', '2029-10-01'),
(5, 103, '2024-11-01', '2029-11-01'),
(6, 104, '2024-12-01', '2029-12-01'),
(1, 105, '2025-01-01', '2030-01-01');

SELECT COUNT(*) FROM trained_in;



**Hospital Database SQL Queries**

Below are the SQL queries to answer the 39 questions based on the hospital database.

--- 1) Find all the information of the nurses who are yet to be registered.

SELECT * 
FROM nurse 
WHERE registered = FALSE;


--- 2) Find the name of the nurse who is the head of their department.

SELECT n.name 
FROM nurse n
JOIN department d ON n.employeeid = d.head;


--- 3) Find the name of the physicians who are the head of each department.

SELECT p.name, d.name AS department_name 
FROM physician p
JOIN department d ON p.employeeid = d.head;


--- 4) Count the number of patients who have taken an appointment with at least one physician.

SELECT COUNT(DISTINCT patient) AS total_patients 
FROM appointment;


--- 5) Retrieve the names of all the physicians who have performed at least one procedure.

SELECT DISTINCT p.name 
FROM physician p
JOIN undergoes u ON p.employeeid = u.physician;


--- 6) Find the number of procedures performed by each physician.

SELECT u.physician, COUNT(u.procedure) AS procedure_count 
FROM undergoes u
GROUP BY u.physician;


--- 7) Find the number of rooms available in each block.

SELECT blockfloor, blockcode, COUNT(*) AS available_rooms 
FROM room
WHERE unavailable = FALSE
GROUP BY blockfloor, blockcode;


--- 8) Retrieve the list of patients who have undergone a specific procedure (e.g., procedure_id = 105).

SELECT p.name 
FROM patient p
JOIN undergoes u ON p.ssn = u.patient
WHERE u.procedure = 105;


--- 9) Find the names of nurses who have been on-call in block 1.

SELECT DISTINCT n.name 
FROM nurse n
JOIN on_call oc ON n.employeeid = oc.nurse
WHERE oc.blockfloor = 1;


--- 10) Count the number of appointments scheduled for each physician.

SELECT physician, COUNT(*) AS total_appointments 
FROM appointment
GROUP BY physician;


--- 11) Retrieve the names of patients who have been admitted in the hospital (i.e., have an entry in the `stay` table).

SELECT p.name 
FROM patient p
JOIN stay s ON p.ssn = s.patient;


 --- 12) Find the number of procedures performed in each room.

SELECT r.roomnumber, COUNT(u.procedure) AS procedure_count 
FROM room r
JOIN stay s ON r.roomnumber = s.room
JOIN undergoes u ON s.stay_id = u.stay
GROUP BY r.roomnumber;


--- 13) Retrieve the details of physicians who are trained in more than 2 procedures.

SELECT physician, COUNT(treatment) AS total_procedures 
FROM trained_in 
GROUP BY physician
HAVING COUNT(treatment) > 2;


--- 14) List all procedures that have not been performed on any patient.

SELECT procedure_id, name 
FROM procedure 
WHERE procedure_id NOT IN (SELECT DISTINCT procedure FROM undergoes);


--- 15) Find the names of patients who have been prescribed medication but have never undergone a procedure.

SELECT DISTINCT p.name 
FROM patient p
JOIN prescribes pr ON p.ssn = pr.patient
WHERE p.ssn NOT IN (SELECT DISTINCT patient FROM undergoes);


--- 16) Retrieve the list of all physicians who have trained in a procedure but have never performed it.

SELECT DISTINCT p.name 
FROM physician p
JOIN trained_in t ON p.employeeid = t.physician
WHERE t.treatment NOT IN (SELECT DISTINCT procedure FROM undergoes WHERE physician = p.employeeid);




--- 17) Retrieve the list of patients who have been admitted in the hospital for more than 7 days.

SELECT p.name 
FROM patient p
JOIN stay s ON p.ssn = s.patient
WHERE (s.end_date - s.start_date) > 7;


--- 18) Retrieve the names of nurses who have assisted in at least 5 procedures.

SELECT n.name 
FROM nurse n
JOIN undergoes u ON n.employeeid = u.assistingnurse
GROUP BY n.name
HAVING COUNT(*) >= 5;

--- 19)  Find the physician who has trained the most procedures.
SELECT physician, COUNT(treatment) AS total_trained 
FROM trained_in 
GROUP BY physician
ORDER BY total_trained DESC
LIMIT 1;

--- 20) Retrieve the names of physicians who have appointments but haven't performed any procedures.
SELECT physician, COUNT(treatment) AS total_trained 
FROM trained_in 
GROUP BY physician
ORDER BY total_trained DESC
LIMIT 1; 

--- 21) Count the number of patients treated by each physician.
SELECT physician, COUNT(DISTINCT patient) AS total_patients 
FROM appointment
GROUP BY physician;

--- 22) Retrieve the list of nurses who have assisted in procedures but were not on-call.

SELECT DISTINCT n.name
FROM nurse n
JOIN undergoes u ON n.employeeid = u.assistingnurse
WHERE n.employeeid NOT IN (SELECT DISTINCT nurse FROM on_call);


--- 23) Find the departments with the most physicians.

SELECT department, COUNT(*) AS physician_count
FROM physician
GROUP BY department
ORDER BY physician_count DESC
LIMIT 1;


--- 24) Retrieve the details of patients who have been admitted more than once.

SELECT patient, COUNT(*) AS admission_count
FROM stay
GROUP BY patient
HAVING COUNT(*) > 1;


--- 25) Find the room that has been occupied the longest.

SELECT room, SUM(end_date - start_date) AS total_days
FROM stay
GROUP BY room
ORDER BY total_days DESC
LIMIT 1;


--- 26) Retrieve the names of physicians who have never been on-call.

SELECT DISTINCT p.name
FROM physician p
WHERE p.employeeid NOT IN (SELECT DISTINCT nurse FROM on_call);


--- 27) Find the most common diagnosis among patients.

SELECT diagnosis, COUNT(*) AS frequency
FROM patient_diagnosis
GROUP BY diagnosis
ORDER BY frequency DESC
LIMIT 1;


--- 28) Retrieve the list of medications that have been prescribed more than 10 times.

SELECT m.name, COUNT(*) AS prescription_count
FROM medication m
JOIN prescribes p ON m.code = p.medication
GROUP BY m.name
HAVING COUNT(*) > 10;


--- 29) Find the physicians who have trained in a procedure but haven't renewed their certification.

SELECT DISTINCT p.name
FROM physician p
JOIN trained_in t ON p.employeeid = t.physician
WHERE t.certificationexpires < CURRENT_DATE;


--- 30) Retrieve the number of patients each nurse has assisted in procedures.

SELECT assistingnurse, COUNT(*) AS assisted_procedures
FROM undergoes
GROUP BY assistingnurse;


--- 31) Find the total number of procedures performed each month.

SELECT EXTRACT(MONTH FROM date) AS month, COUNT(*) AS total_procedures
FROM undergoes
GROUP BY EXTRACT(MONTH FROM date);

--- 32) Retrieve the details of patients who have both an appointment and a stay record.

SELECT DISTINCT p.*
FROM patient p
JOIN appointment a ON p.ssn = a.patient
JOIN stay s ON p.ssn = s.patient;


--- 33) Find the average length of hospital stays per department.

SELECT d.name AS department, AVG(s.end_date - s.start_date) AS avg_stay_days
FROM stay s
JOIN room r ON s.room = r.roomnumber
JOIN department d ON r.department = d.department_id
GROUP BY d.name;


--- 34) Count the number of procedures performed in each department.

SELECT d.name AS department, COUNT(u.procedure) AS total_procedures
FROM undergoes u
JOIN physician p ON u.physician = p.employeeid
JOIN department d ON p.department = d.department_id
GROUP BY d.name;


--- 35) Retrieve the details of the most expensive procedure performed in the hospital.

SELECT *
FROM procedure
ORDER BY cost DESC
LIMIT 1;




