create database CareClinic;
use CareClinic;

create table patients(
  patient_id INT PRIMARY KEY AUTO_INCREMENT,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  gender ENUM('Male', 'Female', 'Other') NOT NULL,
  date_of_birth DATE NOT NULL,
  phone_number VARCHAR(15) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  adress VARCHAR(255) NOT NULL
);

create table medications(
  medication_id INT PRIMARY KEY AUTO_INCREMENT,
  medication_name VARCHAR(50) NOT NULL,
  dosage VARCHAR(50) NOT NULL
);

create table departements(
  departement_id INT PRIMARY KEY AUTO_INCREMENT,
  departement_name VARCHAR(50) NOT NULL,
  location VARCHAR(50) NOT NULL
);

create table rooms(
  room_id INT PRIMARY KEY AUTO_INCREMENT,
  room_number VARCHAR(50) NOT NULL,
  room_type ENUM('General', 'Private', 'ICU') NOT NULL, 
  availability tinyint(1) 
);

create table staff(
  staff_id INT PRIMARY KEY AUTO_INCREMENT,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  job_title VARCHAR(50) NOT NULL,
  phone_number VARCHAR(15) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  departement_id INT,
  FOREIGN KEY (departement_id) REFERENCES departements(departement_id)
);

create table doctors(
  doctor_id INT PRIMARY KEY AUTO_INCREMENT,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  specialization VARCHAR(50) NOT NULL,
  phone_number VARCHAR(15) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  departement_id INT,
  FOREIGN KEY (departement_id) REFERENCES departements(departement_id)
);

create table admissions(
  admission_id INT PRIMARY KEY AUTO_INCREMENT,
  admission_date DATE NOT NULL,
  discharge_date DATE NOT NULL,
  patient_id INT,
  room_id INT,
  FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
  FOREIGN KEY (room_id) REFERENCES rooms(room_id)
);

create table appointements(
  appointement_id INT PRIMARY KEY AUTO_INCREMENT,
  appointement_date DATE NOT NULL,
  appointement_time DATE NOT NULL,
  reason VARCHAR(50) NOT NULL,
  patient_id INT,
  doctor_id INT,
  FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
  FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

create table prescriptions(
  prescription_id INT PRIMARY KEY AUTO_INCREMENT,
  prescription_date DATE NOT NULL,
  dosage_instruction VARCHAR(50) NOT NULL,
  patient_id INT,
  doctor_id INT,
  medication_id INT,
  FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
  FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id),
  FOREIGN KEY (medication_id) REFERENCES medications(medication_id)
);

