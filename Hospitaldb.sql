/* create a database with name Hospital_Database */

create database Hospital_DB

/* create the tables */

/* DEPARTMENTS TABLE */
CREATE TABLE Departments (
DepartmentID INT PRIMARY KEY IDENTITY(1,1),
DepartmentName VARCHAR(100) NOT NULL,
Specialty VARCHAR(100) NOT NULL
);

/* DOCTORS TABLE */
CREATE TABLE Doctors (
DoctorID INT PRIMARY KEY IDENTITY(1,1),
FullName VARCHAR(100) NOT NULL,
DepartmentID INT NOT NULL,
FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

/* PATIENTS TABLE */
CREATE TABLE Patients (
 PatientID INT PRIMARY KEY IDENTITY(1,1),
 FullName VARCHAR(100) NOT NULL,
 Address VARCHAR(255) NOT NULL,
 DateOfBirth DATE NOT NULL,
 Insurance VARCHAR(100) NOT NULL,
 Username VARCHAR(50) NOT NULL,
 PasswordHash VARCHAR(100) NOT NULL,
 Email VARCHAR(100),
 Telephone VARCHAR(20),
 LeaveDate DATE,
 CONSTRAINT CHK_LeaveDate CHECK (LeaveDate IS NULL OR LeaveDate >= GETDATE()));


/* APPOINTMENT TABLE */
CREATE TABLE Appointments (
AppointmentID INT PRIMARY KEY IDENTITY(1,1),
PatientID INT NOT NULL,
DoctorID INT NOT NULL,
DepartmentID INT NOT NULL,
AppointmentDate DATE NOT NULL,
AppointmentTime TIME NOT NULL,
Status VARCHAR(20) NOT NULL CHECK (Status IN ('Pending', 'Cancelled', 'Completed')),
CONSTRAINT FK_Patient_Appointments FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
CONSTRAINT FK_Doctor_Appointments FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID),
CONSTRAINT FK_Department_Appointments FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

/* MEDICAL REPORT TABLE */
CREATE TABLE MedicalRecords (
RecordID INT PRIMARY KEY IDENTITY(1,1),
PatientID INT NOT NULL,
DoctorID INT NOT NULL,
AppointmentID INT,
Diagnosis VARCHAR(255),
Medicine VARCHAR(255),
MedicinePrescribedDate DATE,
Allergies VARCHAR(255),
CONSTRAINT FK_Patient_MedicalRecords FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
CONSTRAINT FK_Doctor_MedicalRecords FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID),
CONSTRAINT FK_Appointment_MedicalRecords FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID)
);

-- TIME TO INSERT VALUES FOR THE CREATED TABLES 
--  THE VALUES SHOULD NOT BE >= 20 

/* INSERT DEPARTMENT VALUES */
INSERT INTO Departments (DepartmentName, Specialty) 
VALUES
('Cardiology', 'Cardiologist'), ('Neurology', 'Neurologist'), ('Oncology', 'Oncologist'), ('Pediatrics','Pediatrician'),
('Orthopedics','Orthopedist'), ('Dermatology', 'Dermatologist'), ('Ophthalmology', 'Ophthalmologist'), ('Psychiatry', 'Psychiatrist'),
('Gynecology','Gynecologist'), ('Radiology', 'Radiologist'), ('Anesthesiology', 'Anesthesiologist'), ('Endocrinology', 'Endocrinologist'),
('Gastroenterology', 'Gastroenterologist'), ('Hematology', 'Hematologist'), ('Nephrology', 'Nephrologist'), ('Pulmonology', 'Pulmonologist'),
('Rheumatology', 'Rheumatology'), ('Urology', 'Urologist'), ('Infectious Disease', 'Infectiologist'), ('General Surgery', 'General Surgeon'),
('Internal Medicine', 'Internist'), ('Emergency Medicine','ER Doctors'), ('Pathology', 'Pathologist'), ('Allergy and Immunology', 'Immunnologist'),
('Family Medicine', 'Family Physician'), ('Geriatrics', 'Geriatrist'), ('Nuclear Medicine', 'Nuclear Radiologist'), ('Plastic Surgery', 'Plastic Surgeon'),
('Sports Medicine', 'Sport Medicine Physician'), ('Occupational Medicine', 'Occuptional Health Physician');

select * From Departments;

/*  INSERT DOCTOR VALUES */
INSERT INTO Doctors (FullName, DepartmentID) 
VALUES
('Dr. Chike Okafor', 1), ('Dr. Gbenga Adeyemo', 2), ('Dr. Adekunle Olayemi', 3), ('Dr. Mohammed Musa', 4),
('Dr. Chioma Agu', 5), ('Dr. Elizabeth Chiadi', 6), ('Dr. Raymond Fela', 7), ('Dr. Oluebube Nkemdili', 8),
('Dr. Ijeoma Atuchukwu', 9), ('Dr. Ifeyinwa Uzochukwu', 10), ('Dr. Sanusi Iyabo', 11), ('Dr. Patricia Bright', 12),
('Dr. Ibrahim Ishimla', 13), ('Dr. Emmannuel Otubeulu', 14), ('Dr. Mary Nwafor', 15), ('Dr. Nkem Hafia', 16),
('Dr. Nancy Isime', 17), ('Dr. Tacha Obi', 18), ('Dr. John Davidson', 19), ('Dr. Emeka Igwe', 20),
('Dr. Tayo Aina', 21), ('Dr.Jackie Adegboye', 22), ('Dr. Alero Onwa', 23), ('Dr. Susan Peter', 24),
('Dr. Sandra Okpala', 25), ('Dr. Innocent Nwaolisa', 26), ('Dr. Kevin Anam', 27), ('Dr. Chinonye Ifechukwu', 28),
('Dr. Ikenna Chidubem', 29), ('Dr. Augustina Akamdiocha', 30);

Select *  from Doctors;

/* INSERT PATIENT VALUES */
INSERT INTO Patients (FullName, Address, DateOfBirth, Insurance, Username, PasswordHash, Email, Telephone, LeaveDate)
VALUES
('Olaedo Okonkwo', '123 Maitama St', '1980-01-01', 'ABC_123', 'alicej', 'hashedpassword1', 'olaedook@example.com', '0708-555-1234', '2024-06-18'),
('Raheenah Mohammed', '456 Okitipupa St', '1975-02-02', 'XYZ45_6', 'bobs', 'hashedpassword2', 'ramo@example.com', '0803-555-5678', '2024-06-16'),
('Jessica Obong', '789 Dutse St', '1990-03-03', 'DEF789', 'charlie_b', 'hashedpassword3', 'jeng@example.com', '0901-555-9012', '2024-06-16'),
('Ebenezer Okoro', '321 Wuse St', '1985-04-04', 'GHI101', 'davidw8u', 'hashedpassword4', 'konne@example.com', '0803-555-3456','2024-06-17' ),
('Raluchukwu Obinagu', '654 Kwame Nkrumah St', '1970-05-05', 'JKL20_2', 'eved', 'hashedpassword5', 'rabi@example.com', '0815-555-7890', '2024-06-19'),
('Obianuju Nwokolo', '987 Osu St', '1965-06-26', 'MNO303', 'fran/km', 'hashedpassword6', 'obikolo@example.com', '0807-555-1234', '2024-06-19'),
('Temi Tayo', '111 Lugbe St', '1995-07-07', 'PQR404', 'gra!cel', 'hashedpassword7', 'teyo@example.com', '0906-555-5678', '2024-06-19'),
('Femi Awolowo', '222 Suleja St', '1988-08-08', 'STU505', 'henryw!', 'hashedpassword8', 'miwo@example.com', '0813-555-9012', '2024-06-17'),
('Rose Okoro', '333 Colorado St', '1983-09-09', 'VWX606', 'ivy90-g', 'hashedpassword9', 'roro@example.com', '0906-555-3456', '2024-06-19'),
('jackson Okpala', '444 Luke St', '1992-10-10', 'YZA707', 'jac_okb', 'hashedpassword10', 'jala@example.com', '0809-555-7890', '2024-06-19'),
('Yetunde Fisayo', '555 Mekus St', '2005-11-11', 'BCD808', 'kare459nb', 'hashedpassword11', 'yefi@example.com', '0701-555-1234', '2024-06-18'),
('Mustapha Hasana ', '666 Awolowo St', '1972-12-12', 'EFG909', 'le(ow', 'hashedpassword12', 'mustapha@example.com', '0907-555-5678', '2024-06-12'),
('Shannon Maidaki', '777Cubana St', '2012-01-13', 'HIJ010', 'miaa', 'hashedpassword13', 'shaki@example.com', '0806-555-9012', '2024-06-13'),
('Aisha Sambala ', '888 Ufuma St', '1979-02-14', 'KLM111', 'nathanh', 'hashedpassword14', 'aishas@example.com', '0817-555-3456', '2024-06-14'),
('Rukayyatu Baba', '999 Obi St', '1991-03-15', 'NOP212', 'oliviac', 'hashedpassword15', 'rubaba@example.com', '0809-555-7890', '2024-06-15'),
('Fadimatu Delu', '101 Sokoto St', '1984-04-16', 'QRS313', 'paull', 'hashedpassword16', 'fadelu@example.com', '0706-555-1234', '2024-06-16'),
('Uwa Gwaggo', '202 Nsugbe St', '1977-05-17', 'TUV414', 'quincyy', 'hashedpassword17', 'uwago@example.com', '0803-555-5678', '2024-06-17'),
('Tasalla Ta-Allah', '303 Akwa St', '1975-06-18', 'WXY515', 'rachelh', 'hashedpassword18', 'tata@example.com', '0803-555-9012', '2024-06-18'),
('Binta Asabe', '404 Onitsha St', '1978-07-19', 'ZAB616', 'stevek', 'hashedpassword19', 'binta@example.com', '0908-555-3456', '2024-06-19'),
('Jummai Altine', '505 Aba St', '1987-08-20', 'CDE717', 'tinaw', 'hashedpassword20', 'juin@example.com', '0912-555-7890', '2024-06-20'),
('Cynthia Ona', '606 Upper Iweka St', '1989-09-21', 'FGH818', 'umas', 'hashedpassword21', 'cynhiaona@example.com', '0913-555-1234', '2024-06-21'),
('Adaeze Udemba', '707 Otubelu St', '1989-10-22', 'IJK919', 'victorg', 'hashedpassword22', 'adaude@example.com', '0803-555-5678', '2024-06-22'),
('Chinasa Wilson', '808 Ochanga St', '1990-11-23', 'LMN020', 'wendya', 'hashedpassword23', 'chison@example.com', '0806-555-9012','2024-06-23' ),
('Ayodele Mohammed', '909 GRA St', '1992-12-24', 'OPQ121', 'xanderb', 'hashedpassword24', 'ayomo@example.com', '0809-555-3456', '2024-06-24'),
('Peace Aziagba', '110 Osuma St', '1995-01-25', 'RST222', 'yarag', 'hashedpassword25', 'peace@example.com', '0909-555-7890','2024-06-25' ),
('Peace Aziagba', '110 Osuma St', '1995-01-25', 'RST222', 'yarag', 'hashedpassword25', 'peace@example.com', '0909-555-7890', '2024-06-26' ),
('Sandra Elumelu', '220 Abakiliki St', '1967-02-26', 'UVW323', 'zanen', 'hashedpassword26', 'sanlu@example.com', '0709-555-1234', '2024-06-27' ),
('Tony Owu', '330 Enugu St', '1980-03-27', 'XYZ424', 'amyc', 'hashedpassword27', 'tonyowu@example.com', '0703-555-5678', '2024-06-28'),
('Uchenna Obi', '440 Asaba St', '2000-04-28', 'ABC525', 'brianm', 'hashedpassword28', 'ucheobi@example.com', '0813-555-9012', '2024-06-29'),
('Kenechukwu Anaayo', '550 Woliwo St', '1994-05-29', 'DEF626', 'chloer', 'hashedpassword29', 'kene@example.com', '0907-555-3456', '2024-06-30'),
('Ginika Umeh', '660 Agustine St', '1993-06-30', 'GHI727', 'dylanp', 'hashedpassword30', 'ginikaumeh@example.com', '0817-555-7890', '2024-06-30');

Select * from Patients;

/* INSERT APPOINTMENT VALUES */
INSERT INTO Appointments (PatientID, DoctorID, DepartmentID, AppointmentDate, AppointmentTime, Status) 
VALUES
(11, 1, 1, '2024-06-11', '19:00', 'Pending'),
(12, 2, 2, '2024-06-11', '22:00', 'Cancelled'),
(13, 3, 3, '2024-06-11', '20:00', 'Completed'),
(14, 4, 4, '2024-06-11', '20:00', 'Pending'),
(15, 5, 5, '2024-06-11', '19:00', 'Cancelled'),
(16, 6, 6, '2024-06-11', '19:00', 'Completed'),
(17, 7, 7, '2024-06-11', '19:00', 'Pending'),
(18, 8, 8, '2024-06-11', '19:00', 'Cancelled'),
(19, 9, 9, '2024-06-12', '17:00', 'Completed'),
(20, 10, 10, '2024-06-11', '18:00', 'Pending'),
(21, 11, 11, '2024-06-11', '20:00', 'Cancelled'),
(22, 12, 12, '2024-06-12', '20:00', 'Completed'),
(23, 13, 13, '2024-06-13', '19:00', 'Pending'),
(24, 14, 14, '2024-06-14', '19:00', 'Cancelled'),
(25, 15, 15, '2024-06-15', '19:00', 'Completed'),
(26, 16, 16, '2024-06-16', '16:00', 'Pending'),
(27, 17, 17, '2024-06-17', '16:00', 'Cancelled'),
(28, 18, 18, '2024-06-18', '16:00', 'Completed'),
(29, 19, 19, '2024-06-19', '17:00', 'Pending'),
(30, 20, 20, '2024-06-20', '18:00', 'Cancelled'),
(31, 21, 21, '2024-06-21', '19:00', 'Completed'),
(32, 22, 22, '2024-06-22', '19:00', 'Pending'),
(33, 23, 23, '2024-06-23', '19:00', 'Cancelled'),
(34, 24,24, '2024-06-24', '19:00', 'Completed'),
(35, 25, 25, '2024-06-25', '19:00', 'Pending'),
(36, 26, 26, '2024-06-26', '19:00', 'Cancelled'),
(37, 27, 27, '2024-06-27', '19:00', 'Completed'),
(38, 28, 28, '2024-06-28', '19:00', 'Pending'),
(39, 29, 29, '2024-06-29', '18:00', 'Cancelled'),
(40, 30, 30, '2024-06-30', '18:00', 'Completed'); 

-- Update the first appointment for PatientID 11, DoctorID 1, DepartmentID 1
UPDATE Appointments
SET AppointmentDate = CAST(GETDATE() AS DATE)
WHERE PatientID = 11 AND DoctorID = 1 AND DepartmentID = 1 AND AppointmentDate = '2024-06-11' AND AppointmentTime = '19:00';

-- Update the second appointment for PatientID 12, DoctorID 2, DepartmentID 2
UPDATE Appointments
SET AppointmentDate = CAST(GETDATE() AS DATE)
WHERE PatientID = 12 AND DoctorID = 2 AND DepartmentID = 2 AND AppointmentDate = '2024-06-11' AND AppointmentTime = '22:00';

-- Verify the update
SELECT * FROM Appointments
WHERE (PatientID = 11 AND DoctorID = 1 AND DepartmentID = 1)
   OR (PatientID = 12 AND DoctorID = 2 AND DepartmentID = 2);


Alter table appoint
drop table Appointments;


SELECT * FROM Appointments

/* INSERT MEDICAL RECORDS  VALUES */
INSERT INTO MedicalRecords (RecordID, PatientID, DoctorID, AppointmentID, Diagnosis, Medicine, MedicinePrescribedDate, Allergies) 
VALUES
(1, 11, 1, 7, 'Cancer', ' Morphine Sulphate 10mg/5mL oral solution 10mg hourly', '2024-06-01', 'Tetracycline'),
(2, 12, 2, 8, 'Cancer B', 'Lisinopril 10 mg 1 tab PO daily', '2024-06-02', 'Choloroquine'),
(3, 13, 3, 9, 'Cancer', 'Amoxicillin 500 mg Capsules 1 cap PO TID for 10 days', '2024-06-03', 'Penicillin'),
(4, 14, 4, 10, 'Typhoid', ' Ciprofloxacin 500 mg Tablets 1 tablet PO BID for 10 days', '2024-06-04', 'Peanut'),
(5, 15, 5, 11, 'cancer', 'Imatinib Mesylate 400 mg Tablets 1 tablet PO daily with a meal and a large glass of water', '2024-06-05', 'Aspirin'),
(6, 16, 6, 12, 'Arthritis', 'Ibuprofen 800 mg Tablets 1 tablet PO TID with food', '2024-06-06', 'ibuprofen'),
(7, 17, 7, 13, 'Astigmatism', 'OD (Right Eye): +1.00/ -1.25 x 90 OS (Left Eye): +1.25/ -0.75 x180', '2024-06-07', 'Peanut'),
(8, 18, 8, 14, 'Malaria', 'Doxycycline 100 mg Tablets  Take 1 tablet orally once daily, starting 1-2 days before travel to the malaria-endemic area and continuing for 4 weeks after leaving the area', '2024-06-08', 'Septra'),
(9, 19, 9, 15, 'Contact Dermitis', ' Hydrocortisone Cream 1%  Topical Cream Apply a thin layer to affected area(s) twice daily for up to 2 weeks, one tube', '2024-06-09', 'Sulfamethoxazole-trimethoprim'),
(10, 20, 10, 16, 'Appendicitis', 'Ceftriaxone 1 g  Intravenous (IV) solution Administer Ceftriaxone 1 g IV every 24 hours and Metronidazole 500 mg IV every 8 hours', '2024-06-10', 'Pediazole'),
(11, 21, 11, 17, 'Lipoma', 'Acetaminophen 500 mg Tablets take 1-2 tablets by mouth every 4-6 hours as needed for pain', '2024-06-11', 'Ibuprofen'),
(12, 22, 12, 18, 'cancer', 'Docetaxel  75 mg/m² Intravenous infusion Administer every 3 weeks for a total of 6 cycles', '2024-06-12', 'Pollen'),
(13, 23, 13, 19, 'Dental Caries', 'Acetaminophen 500 mg Tablets take 1-2 tablets by mouth every 4-6 hours as needed for pain', '2024-06-13', 'Cetirizine'),
(14, 24, 14, 20, 'Cancer', 'Taxotere 75 mg/m² Intravenous infusion Administer every 3 weeks for a total of 6 cycles', '2024-06-14', 'Cephalosporins'),
(15, 25, 15, 21, 'Malignant Hyperthermia', 'Dantrolene Sodium 20 mg/vial Powder for reconstitution Administer dantrolene sodium 2.5 mg/kg intravenously as soon as possible, followed by additional doses as needed to control hypermetabolism.', '2024-06-15', 'Shellfish'),
(16, 26, 16, 22, 'Crohn Disease', 'Adalimumab 40 mg Subcutaneous injection Administer 40 mg subcutaneously every other week', '2024-06-16', 'Peanut'),
(17, 27, 17, 23, 'Vasculitis', 'MOmeprazole 20 mg Oral capsules Take 20 mg orally once daily before breakfast', '2024-06-17', 'Histamine'),
(18, 28, 18, 24, 'High Blood Pressue', 'Amlodipine besylate 5 mg Oral tablets  Take 5 mg orally once daily', '2024-06-18', 'Penicillin'),
(19, 29, 19, 25, 'High Cholesterol', 'Atorvastatin 20 mg Oral tablets, Take 20 mg orally once daily', '2024-06-19', 'Pollen'),
(20, 30, 20, 26, 'Fracture', 'Ibuprofen 400 mg Oral tablets, Take 400 mg orally every 6 hours as needed for pain', '2024-06-20', 'Tetracycline'),
(21, 31, 21, 27, 'Hematuria', 'Ciprofloxacin  500 mg Oral tablets, Take 500 mg orally twice daily for 7 days ', '2024-06-21', 'Ibuprofen'),
(22, 32, 22, 28, 'Fibroid', 'Levonorgestrel-releasing intrauterine device (IUD) (Mirena)  52 mg Intrauterine device,  Insert one IUD into the uterine cavity', '2024-06-22', 'Insullin'),
(23, 33, 23, 29, 'Diabetes', 'Metformin 500 mg  Oral tablets, Take 500 mg orally twice daily with meals', '2024-06-23', 'Sulfa Drug'),
(24, 34, 24, 30, 'Occupation Asthma', 'Fluticasone propionate 110 mcg per inhalation Inhaler, Inhale 2 puffs twice daily.', '2024-06-24', 'Iodine'),
(25, 35, 25, 31, 'Thyroid Disease', 'Levothyroxine 50 mcg  Oral tablets Take 50 mcg orally once daily on an empty stomach, at least 30 minutes before breakfast', '2024-06-25', 'Cetirizine'),
(26, 36, 26, 32, 'Flynn-Arid Syndrome', 'Refresh Tears Eye drops, Instill 1 drop into each eye as needed for dryness', '2024-06-26', 'Treenut'),
(27, 37, 27, 33, 'Migraine', 'Ibuprofen 400 mg Oral tablets, Take 2 tablets by mouth every 4-6 hours as needed for headache. Do not exceed 3200 mg/day.', '2024-06-27', 'Pineapple'),
(28, 38, 28, 34, 'AIDS', ' Dolutegravir 50 mg Oral tablets, Take 1 tablet daily.', '2024-06-28', 'Pollen'),
(29, 39, 29, 35, 'Bronchitis', 'Dextromethorphan 15 mg per 5 mL Oral syrup, Take 10 mL orally every 4-6 hours as needed for cough', '2024-06-29', 'Pediazole'),
(30, 40, 30, 36, 'Buttock Lift', 'Acetaminophen (Tylenol): 500 mg Oral tablets, Take 2 tablets (1000 mg) orally every 6 hours as needed for pain or fever', '2024-06-30', 'Amoxicillin');

Select * From MedicalRecords;

-- SET IDENTITY_INSERT MedicalRecords ON;
-- ALTER Table to add feedback 
ALTER TABLE Appointments
ADD Feedback VARCHAR(255) ;

/* Step 2: Insert values into the Feedback column for 30 appointments */
-- Insert feedback values for AppointmentID ranging from 31 to 89
UPDATE Appointments SET Feedback = 'Excellent service' WHERE AppointmentID = 7;
UPDATE Appointments SET Feedback = 'Satisfactory experience' WHERE AppointmentID = 8;
UPDATE Appointments SET Feedback = 'Needs improvement' WHERE AppointmentID = 9;
UPDATE Appointments SET Feedback = 'Great consultation' WHERE AppointmentID = 10;
UPDATE Appointments SET Feedback = 'Very professional' WHERE AppointmentID = 11;
UPDATE Appointments SET Feedback = 'Friendly staff' WHERE AppointmentID = 12;
UPDATE Appointments SET Feedback = 'Quick and efficient' WHERE AppointmentID = 13;
UPDATE Appointments SET Feedback = 'Highly recommend' WHERE AppointmentID = 14;
UPDATE Appointments SET Feedback = 'Clean and organized' WHERE AppointmentID = 15;
UPDATE Appointments SET Feedback = 'Great experience' WHERE AppointmentID = 16;
UPDATE Appointments SET Feedback = 'Very satisfied' WHERE AppointmentID = 17;
UPDATE Appointments SET Feedback = 'Doctor was very helpful' WHERE AppointmentID = 18;
UPDATE Appointments SET Feedback = 'Pleasant visit' WHERE AppointmentID = 19;
UPDATE Appointments SET Feedback = 'Knowledgeable staff' WHERE AppointmentID = 20;
UPDATE Appointments SET Feedback = 'Will come again' WHERE AppointmentID = 21;
UPDATE Appointments SET Feedback = 'Exceptional care' WHERE AppointmentID = 22;
UPDATE Appointments SET Feedback = 'Doctor was late' WHERE AppointmentID = 23;
UPDATE Appointments SET Feedback = 'Very thorough examination' WHERE AppointmentID = 24;
UPDATE Appointments SET Feedback = 'Good follow-up' WHERE AppointmentID = 25;
UPDATE Appointments SET Feedback = 'Impressed with the service' WHERE AppointmentID = 26;
UPDATE Appointments SET Feedback = 'Long wait time' WHERE AppointmentID = 27;
UPDATE Appointments SET Feedback = 'Excellent diagnosis' WHERE AppointmentID = 28;
UPDATE Appointments SET Feedback = 'Friendly atmosphere' WHERE AppointmentID = 29;
UPDATE Appointments SET Feedback = 'Highly professional' WHERE AppointmentID = 30;
UPDATE Appointments SET Feedback = 'Not satisfied' WHERE AppointmentID = 31;
UPDATE Appointments SET Feedback = 'Could be better' WHERE AppointmentID = 32;
UPDATE Appointments SET Feedback = 'Quick appointment' WHERE AppointmentID = 33;
UPDATE Appointments SET Feedback = 'Great medical advice' WHERE AppointmentID = 34;
UPDATE Appointments SET Feedback = 'Doctor was very kind' WHERE AppointmentID = 35;
UPDATE Appointments SET Feedback = 'Efficient process' WHERE AppointmentID = 37;
UPDATE Appointments SET Feedback = 'Very caring' WHERE AppointmentID = 38;
UPDATE Appointments SET Feedback = 'Professional and courteous' WHERE AppointmentID = 39;
UPDATE Appointments SET Feedback = 'Wonderful experience' WHERE AppointmentID = 40;
UPDATE Appointments SET Feedback = 'Staff was rude' WHERE AppointmentID = 41;
UPDATE Appointments SET Feedback = 'Doctor was rushed' WHERE AppointmentID = 42;
UPDATE Appointments SET Feedback = 'Pleasant atmosphere' WHERE AppointmentID = 43;
UPDATE Appointments SET Feedback = 'Doctor was very knowledgeable' WHERE AppointmentID = 44;
UPDATE Appointments SET Feedback = 'Wait time was too long' WHERE AppointmentID = 45;
UPDATE Appointments SET Feedback = 'Very organized process' WHERE AppointmentID = 46;
UPDATE Appointments SET Feedback = 'Good overall experience' WHERE AppointmentID = 47;
UPDATE Appointments SET Feedback = 'Excellent service' WHERE AppointmentID = 48;
UPDATE Appointments SET Feedback = 'Satisfactory experience' WHERE AppointmentID = 49;
UPDATE Appointments SET Feedback = 'Needs improvement' WHERE AppointmentID = 50;
UPDATE Appointments SET Feedback = 'Great consultation' WHERE AppointmentID = 51;
UPDATE Appointments SET Feedback = 'Very professional' WHERE AppointmentID = 52;
UPDATE Appointments SET Feedback = 'Friendly staff' WHERE AppointmentID = 53;
UPDATE Appointments SET Feedback = 'Quick and efficient' WHERE AppointmentID = 54;
UPDATE Appointments SET Feedback = 'Highly recommend' WHERE AppointmentID = 55;
UPDATE Appointments SET Feedback = 'Clean and organized' WHERE AppointmentID = 56;
UPDATE Appointments SET Feedback = 'Great experience' WHERE AppointmentID = 57;
UPDATE Appointments SET Feedback = 'Very satisfied' WHERE AppointmentID = 58;
UPDATE Appointments SET Feedback = 'Doctor was very helpful' WHERE AppointmentID = 59;
UPDATE Appointments SET Feedback = 'Pleasant visit' WHERE AppointmentID = 60;
UPDATE Appointments SET Feedback = 'Knowledgeable staff' WHERE AppointmentID = 61;
UPDATE Appointments SET Feedback = 'Will come again' WHERE AppointmentID = 62;
UPDATE Appointments SET Feedback = 'Exceptional care' WHERE AppointmentID = 63;
UPDATE Appointments SET Feedback = 'Doctor was late' WHERE AppointmentID = 64;
UPDATE Appointments SET Feedback = 'Very thorough examination' WHERE AppointmentID = 65;
UPDATE Appointments SET Feedback = 'Good follow-up' WHERE AppointmentID = 67;

/* Confirming the appointment ID */
SELECT * FROM Appointments;

ALTER TABLE Appointments
DROP COLUMN Feedback;

/* Add the constraint to check that the appointment date is not in the past */
ALTER TABLE Appointments
ADD CONSTRAINT CHK_AppointmentDate CHECK (AppointmentDate >= CAST(GETDATE() AS DATE));

SELECT * FROM Patients;

/*  Create trigger to update status in Appointments table after appointment completion */
CREATE TRIGGER trg_AppointmentStatusUpdate
ON MedicalRecords
AFTER INSERT
AS
BEGIN
    UPDATE Appointments
    SET Status = 'Completed'
    FROM Appointments a
    JOIN inserted i ON a.AppointmentID = i.AppointmentID;
END;

-- List all the patients with older than 40 and have Cancer in diagnosis.--

SELECT P.FullName,P.Address,M.PatientID,M.Diagnosis,M.Medicine
FROM Patients P
JOIN MedicalRecords M
ON P.PatientID = M.PatientID
 WHERE DATEDIFF(YEAR,DateOfBirth,GETDATE()) >= '40' 
 AND Diagnosis = 'cancer';

-- 4a,Search the database of the hospital for matching character strings by name of medicine. 
-- Results should be sorted with the most recent medicine prescribed date first --

CREATE PROCEDURE SearchMedicineByName
    @MedicineName NVARCHAR(100)
AS
BEGIN
    SELECT Medicine, MedicinePrescribedDate
    FROM MedicalRecords
    WHERE Medicine LIKE '%' + @MedicineName + '%'
    ORDER BY MedicinePrescribedDate DESC;
END;

EXEC SearchMedicineByName @MedicineName = 'Ciprofloxacin';

-- created another procedure to accomodate search all (*) --
CREATE PROCEDURE SearchMedicineeByName
    @MedicineName NVARCHAR(100)
AS
BEGIN
    SELECT *
    FROM MedicalRecords
    WHERE Medicine LIKE '%' + @MedicineName + '%'
    ORDER BY MedicinePrescribedDate DESC;
END;

EXEC SearchMedicineeByName @MedicineName = 'Ciprofloxacin';

--b,Return a full list of diagnosis and allergies for a specific patient who has an
--appointment today (i.e., the system date when the query is run)

CREATE PROCEDURE GetPatientDiagnosisAndAllergies
    @PatientID INT
AS
BEGIN
    -- Ensure the patient has an appointment today
    IF EXISTS (
        SELECT 1
        FROM Appointments
        WHERE PatientID = @PatientID
          AND AppointmentDate = CAST(GETDATE() AS DATE)
    )
    BEGIN
        -- Select Diagnoses and Allergies for the patient
        SELECT 
            MR.Diagnosis,
            MR.Allergies
        FROM 
            MedicalRecords MR
        WHERE 
            MR.PatientID = @PatientID;
    END
    ELSE
    BEGIN
        PRINT 'No appointment found for the specified patient today.';
    END
END;

EXEC GetPatientDiagnosisAndAllergies @PatientID = 12;

-- c,c) Update the details for an existing doctor--

UPDATE Doctors
SET FullName = 'Dr. Oyese Ayodele'
WHERE FullName = 'Dr. Chike Okafor';

CREATE PROCEDURE UpdateDoctorDetails
    @DoctorID INT,
    @NEWFullName NVARCHAR(100),
    @NewSpecialty NVARCHAR(100),
    @NewPhoneNumber NVARCHAR(15)
AS
BEGIN
    UPDATE Doctors
    SET 
        FullName = @NEWFullName,
        Specialty = @NewSpecialty,
        PhoneNumber = @NewPhoneNumber
    WHERE 
        DoctorID = @DoctorID;
END;

/*Execute UpdateDoctorDetails */
EXEC UpdateDoctorDetails @DoctorID = 1, @FullName = 'Dr. Tacha Obi', @Specialty = 'Cardiology',
@Email = 'tachaobi@yahoo.com', @PhoneNumber = '0803-456-7890';

-- d) Delete the appointment who status is already completed.
CREATE PROCEDURE DeleteCompletedAppointments
AS
BEGIN
    DELETE FROM Appointments
    WHERE Status = 'Completed';
END;

EXEC DeleteCompletedAppointments;

-- Drop the existing foreign key constraint
ALTER TABLE MedicalRecords
DROP CONSTRAINT FK_Appointment_MedicalRecords;

-- Add a new foreign key constraint with ON DELETE CASCADE
ALTER TABLE MedicalRecords
ADD CONSTRAINT FK_Appointment_MedicalRecords
FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID)
ON DELETE CASCADE;

/*5. The hospitals wants to view the appointment date and time, showing all previous
and current appointments for all doctors, and including details of the department
(the doctor is associated with), doctor’s specialty and any associate review/feedback
given for a doctor. You should create a view containing all the required information.*/

CREATE VIEW HospitalAppointmentsView AS
SELECT 
    A.AppointmentDate,
   A. AppointmentTime,
    D.FullName,
    D.Department,
    D.Specialty,
    A.Feedback
FROM 
    Appointments
JOIN 
    Doctors ON Appointments.DoctorID = Doctors.DoctorID
JOIN 
    Departments ON Doctors.DepartmentID = Departments.DepartmentID
LEFT JOIN 
    Feedback ON Appointments.AppointmentID = Feedback.AppointmentID;

/* Query the doctor appointment view */
SELECT * FROM DoctorAppointmentsView;

-- 6. Create a trigger so that the current state of an appointment can be changed to
-- available when it is cancelled.

CREATE TRIGGER UpdateAppointmentStatus
ON Appointments
AFTER UPDATE
AS
BEGIN
    IF UPDATE(Status)
    BEGIN
        UPDATE Appointments
        SET Status = 'Available'
        FROM Appointments AS A
        INNER JOIN inserted AS I ON A.AppointmentID = I.AppointmentID
        WHERE I.Status = 'Cancelled'
            AND A.Status = 'Booked';
    END
END;

-- 7. Write a select query which allows the hospital to identify the number of
--completed appointments with the specialty of doctors as ‘Gastroenterologists’.

SELECT COUNT(*) AS CompletedAppointments
FROM Appointments A
INNER JOIN Doctors D ON A.DoctorID = D.DoctorID
WHERE D.DoctorID IN (
    SELECT DoctorID
    FROM Doctors
    WHERE Specialty = 'Gastroenterologist'
)
AND A.Status = 'Completed';

