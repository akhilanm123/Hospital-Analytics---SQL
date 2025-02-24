
CREATE TABLE physician (
employeeid SERIAL PRIMARY KEY,
name VARCHAR (100) NOT NULL,
position VARCHAR(100),
ssn VARCHAR(20) UNIQUE NOT NULL
);

SELECT * FROM physician;

INSERT INTO  physician (name, position, ssn) VALUES
('John Dorian', 'Staff Internist', '111-11-1111'),
('Elliot Reid', 'Attending Physician', '222-22-2222'),
('Christopher Turk', 'Surgical Attending Physician', '333-33-3333'),
('Percival', 'Senior Attending Physician', '444-44-4444');

Select * from physician;
Select * from physician where position = 'Attending Physician';

CREATE TABLE patients (
ssn VARCHAR(20) PRIMARY KEY,   -- Unique patients ID
name VARCHAR(100) NOT NULL,    -- Patient's name
address TEXT,                  -- Patient's address
phone VARCHAR(15),             -- Phone number
insuranceid VARCHAR(30),        -- Insurance details
pcp INT REFERENCES physician(employeeid) -- Primary Care Physician (Doctor ID)
)

select * from patients;

INSERT INTO patients (ssn, name, address, phone, insuranceid, pcp) VALUES 
('100000001', 'John Smith', '42 Foobar Lane', '555-0256', '68476213', 2),
('100000002', 'Grace Ritchie', '37 Snafu Drive', '555-0512', '36546321', 4),
('100000003', 'Dennis Doe', '101 Omgbbq Street', '555-1204', '65465421', 1),
('100000004', 'Emma Johnson', '12 Maple Street', '555-1234', '87456231', 3),
('100000005', 'Liam Brown', '78 Oak Avenue', '555-5678', '98745632', 4),
('100000006', 'Olivia Davis', '90 Pine Road', '555-9012', '65478912', 2),
('100000007', 'Noah Wilson', '34 Birch Lane', '555-3456', '32165498', 3),
('100000008', 'Ava Martinez', '56 Cedar Drive', '555-7890', '23154687', 1),
('100000009', 'Sophia Anderson', '89 Elm Street', '555-2345', '54698721', 4),
('100000010', 'Mason White', '23 Spruce Court', '555-6789', '87965412', 2),
('100000011', 'Isabella Thompson', '67 Walnut Lane', '555-8901', '21436587', 1),
('100000012', 'James Taylor', '45 Poplar Road', '555-4321', '36547821', 3),
('100000013', 'Charlotte Harris', '98 Redwood Blvd', '555-8765', '12547896', 4),
('100000014', 'Benjamin Clark', '76 Palm Street', '555-2109', '54879632', 2),
('100000015', 'Amelia Lewis', '88 Sycamore Lane', '555-6543', '65789412', 1),
('100000016', 'Lucas Walker', '101 Chestnut Ave', '555-4320', '78945623', 3),
('100000017', 'Mia Hall', '33 Magnolia Drive', '555-6782', '45612378', 4),
('100000018', 'Ethan Allen', '74 Dogwood Lane', '555-8905', '12457896', 2),
('100000019', 'Harper Young', '29 Holly Road', '555-3452', '96587412', 3),
('100000020', 'Daniel King', '85 Fir Avenue', '555-7894', '47896521', 1),
('100000021', 'Evelyn Scott', '49 Juniper Street', '555-2340', '56879412', 4),
('100000022', 'Henry Green', '19 Willow Drive', '555-8908', '65478931', 2),
('100000023', 'Abigail Baker', '61 Aspen Blvd', '555-4567', '47896512', 3),
('100000024', 'Sebastian Carter', '37 Maplewood Avenue', '555-9010', '21436598', 1),
('100000025', 'Scarlett Perez', '82 Redwood Court', '555-6783', '12547839', 4),
('100000026', 'Jackson Adams', '53 Mulberry Street', '555-2105', '54876932', 2),
('100000027', 'Luna Gonzalez', '46 Cypress Lane', '555-7654', '65412387', 1),
('100000028', 'David Nelson', '66 Hickory Drive', '555-3421', '98754632', 3),
('100000029', 'Madison Hill', '99 Birchwood Road', '555-6781', '32147896', 4),
('100000030', 'Carter Rivera', '71 Rosewood Street', '555-2346', '21458796', 2),
('100000031', 'Chloe Roberts', '14 Maple Grove', '555-8907', '65412378', 1),
('100000032', 'Matthew Collins', '88 Ash Avenue', '555-7892', '78965432', 3),
('100000033', 'Victoria Stewart', '91 Cedar Grove', '555-1238', '45698712', 4),
('100000034', 'Joseph Sanchez', '11 Pinehurst Road', '555-4325', '69874521', 2),
('100000035', 'Penelope Morris', '77 Laurel Lane', '555-9014', '12569874', 1),
('100000036', 'Samuel Reed', '50 Palm Grove', '555-7651', '47896514', 3),
('100000037', 'Grace Murphy', '39 Dogwood Place', '555-3459', '98674523', 4),
('100000038', 'Andrew Cook', '73 Firwood Drive', '555-6786', '32169874', 2),
('100000039', 'Zoe Bell', '28 Juniper Court', '555-2347', '21459687', 1),
('100000040', 'Nathan Turner', '95 Willow Park', '555-8903', '65412897', 3),
('100000041', 'Stella Ward', '32 Aspen Grove', '555-4568', '78941236', 4),
('100000042', 'Gabriel Ross', '55 Redwood Terrace', '555-9015', '12546987', 2),
('100000043', 'Lillian Bailey', '60 Mulberry Path', '555-7659', '54879123', 1),
('100000044', 'Isaac Cooper', '17 Cypress Way', '555-3424', '65487912', 3),
('100000045', 'Aurora Howard', '35 Hickory Lane', '555-6785', '32154879', 4),
('100000046', 'Levi Ramirez', '42 Birchwood Terrace', '555-2349', '21457893', 2),
('100000047', 'Aria Bryant', '90 Rosewood Court', '555-8902', '65412389', 1),
('100000048', 'Hudson Foster', '31 Maplewood Grove', '555-4569', '78945623', 3),
('100000049', 'Sofia Alexander', '100 Pinewood Lane', '555-4323', '65478932', 4),
('100000050', 'Elijah Griffin', '26 Ashwood Drive', '555-9016', '47896541', 2),
('100000051', 'Hannah Hayes', '62 Laurel Grove', '555-7652', '98674512', 1),
('100000052', 'Wyatt Barnes', '78 Dogwood Way', '555-3458', '32198765', 3),
('100000053', 'Violet Jenkins', '21 Firwood Park', '555-6787', '21459876', 4),
('100000054', 'Dylan Long', '83 Juniper Lane', '555-2348', '65498721', 2),
('100000055', 'Addison Simmons', '15 Willow Grove', '555-8906', '78965412', 1);

select * from patients


SELECT patients.name AS Patient_Name, physician.name AS Doctor_Name, physician.position
FROM patients
JOIN physician ON patients.pcp = physician.employeeid


select patients.name FROM patients
JOIN physician ON patients.pcp = physician.employeeid 
WHERE physician.name = 'John Dorian'

SELECT COUNT(*) AS total_patients FROM patients;


