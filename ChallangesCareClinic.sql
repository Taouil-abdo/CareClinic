-- Insert patients 
INSERT INTO patients (first_name,last_name,gender,date_of_birth,phone_number,email,adress) 
VALUES("Alex","Johnson","Male","2000-03-12","1234567890","Alex@gmail.com","youssoufia"),
("Alex","John","Male","2005-03-12","12367890","John@gmail.com","marrakech"),
("simo","Json","Male","2006-02-12","12345670","simo@gmail.com","safi"),
("youness","Joson","Male","2001-03-02","12567890","youness@gmail.com","casa"),
("youssef","Joon","Male","2002-07-10","34567890","youssef@gmail.com","rabat"),
("hamza","Jn","Male","2000-04-6","12345890","hamza@gmail.com","fes"),
("saad","hson","Male","2000-03-12","12345678","saad@gmail.com","tangier")

-- Insert data into staff 
INSERT INTO medications (medication_name, dosage) VALUES
('Paracetamol', '500mg twice a day'),
('Ibuprofen', '200mg every 8 hours');

-- Insert data into medications 
INSERT INTO departements (departement_name, location) VALUES
('Cardiology', 'Building A'),
('Neurology', 'Building B');

-- Insert data into rooms 
INSERT INTO rooms (room_number, room_type, availability) VALUES
('101', 'General', 1),
('102', 'Private', 0),
('201', 'ICU', 1);

-- Insert data into staff 
INSERT INTO staff (first_name, last_name, job_title, phone_number, email, departement_id) VALUES
('Alice', 'Brown', 'Nurse', '1122334455', 'alicebrown@example.com', 1),
('Bob', 'White', 'Technician', '2233445566', 'bobwhite@example.com', 2);

-- Insert data into doctors 
INSERT INTO doctors (first_name, last_name, specialization, phone_number, email, departement_id) VALUES
('Dr. Sarah', 'Lee', 'Cardiologist', '3344556677', 'sarahlee@example.com', 1),
('Dr. James', 'Taylor', 'Neurologist', '4455667788', 'jamestaylor@example.com', 2);

-- Insert data into admissions 
INSERT INTO admissions (admission_date, discharge_date, patient_id, room_id) VALUES
('2024-12-01', '2024-12-05', 1, 1),
('2024-12-02', '2024-12-06', 2, 3);

-- Insert data into appointements 
INSERT INTO appointements (appointement_date, appointement_time, reason, patient_id, doctor_id) VALUES
('2024-12-10', '10:00:00', 'Routine Checkup', 1, 1),
('2024-12-11', '11:00:00', 'Consultation', 2, 2);

-- Insert data into prescriptions 
INSERT INTO prescriptions (prescription_date, dosage_instruction, patient_id, doctor_id, medication_id) VALUES
('2024-12-03', 'Take after meals', 1, 1, 1),
('2024-12-04', 'Take with water', 2, 2, 2);


-- 1. CRUD Operations : Insérer un nouveau patient:
-- Insérez un nouveau patient nommé "Alex Johnson", né le 15 juillet 1990, de sexe masculin, avec le numéro de téléphone "1234567890".

INSERT INTO patients (first_name,last_name,gender,date_of_birth,phone_number,email,adress) 
VALUES("Alex","Johnson","Male","2000-03-12","1234567890","Alex@gmail.com","youssoufia"),

-- 2. SELECT Statement : Récupérer tous les départements:

-- Récupérez tous les départements avec leurs emplacements.

SELECT * from departements

-- 3. ORDER BY Clause : Trier les patients par date de naissance Listez tous les patients, triés par date de naissance dans l'ordre croissant.

SELECT * from patients ORDER BY date_of_birth ASC
-- 4. Filtrer les patients uniques par sexe (DISTINCT) Récupérez tous les sexes des patients enregistrés, sans doublons.

SELECT DISTINCT gender FROM patients;

-- 5. LIMIT Clause : Obtenir les 3 premiers médecins Récupérez les trois premiers médecins dans la table doctors.

select * from doctors limit 3

-- 6. WHERE Clause : Patients nés après 2000 Récupérez les informations des patients nés après l'année 2000.

select * from patients where date_of_birth > '2001-00-00';

-- 7. Logical Operators : Médecins dans des départements spécifiques Récupérez les médecins des départements "Cardiology" et "Neurology".

select * from doctors where specialization like "Cardiologist" or "Neurologist";

-- 8. Special Operators : Vérifier des plages de dates Listez les admissions entre le 1er décembre et le 7 décembre 2024.

SELECT * FROM admissions WHERE admission_date BETWEEN '2024-12-01' AND '2024-12-07';

-- 9. Conditional Expressions : Nommer les catégories d'âge des patients Ajoutez une colonne catégorisant les patients en "Enfant", "Adulte", ou "Senior" selon leur âge.

SELECT first_name, last_name, date_of_birth , CASE WHEN TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) < 18 THEN 'Child'
           WHEN TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) BETWEEN 18 AND 64 THEN 'Adult'
           ELSE 'Senior' END AS age_category FROM patients;

-- 10. Aggregate Functions : Nombre total de rendez-vous Comptez le nombre total de rendez-vous enregistrés. 

SELECT COUNT(*) AS total_appointments FROM appointements;

-- 11. COUNT avec GROUP BY : Nombre de médecins par département Comptez le nombre de médecins dans chaque département.

SELECT d.departement_name, COUNT(*) AS number_of_doctors FROM doctors d JOIN departements dp ON d.departement_id = dp.id GROUP BY d.departement_id;

-- 12. AVG : Âge moyen des patients Calculez l'âge moyen des patients.

SELECT AVG(TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE())) AS average_age FROM patients;

-- 13. MAX : Dernier rendez-vous Trouvez la date et l'heure du dernier rendez-vous enregistré.

SELECT MAX(appointement_date) AS latest_appointment_date FROM appointements;

-- 14. SUM : Total des admissions par chambre Calculez le total des admissions pour chaque chambre.

SELECT room_id, COUNT(*) AS total_admissions FROM admissions GROUP BY room_id;

-- 15. Constraints : Vérifier les patients sans e-mail Récupérez tous les patients dont le champ email est vide.

SELECT * FROM patients WHERE email IS NULL ;

-- 16. Jointure : Liste des rendez-vous avec noms des médecins et patients Récupérez les rendez-vous avec les noms des médecins et des patients.

SELECT a.appointement_date, a.appointement_time, a.reason,p.first_name AS patient_first_name, p.last_name AS patient_last_name,d.first_name AS doctor_first_name, d.last_name AS doctor_last_name
FROM appointements a JOIN patients p ON a.patient_id = p.id JOIN doctors d ON a.doctor_id = d.id;

-- 17. DELETE : Supprimer les rendez-vous avant 2024 Supprimez tous les rendez-vous programmés avant 2024.

DELETE FROM appointements WHERE appointement_date < '2024-01-01';

-- 18. UPDATE : Modifier un département Changez le nom du département "Oncology" en "Cancer Treatment".

UPDATE departements SET departement_name = 'Cancer Treatment' WHERE departement_name = 'Oncology';

-- 19. HAVING Clause : Patients par sexe avec au moins 2 entrées Listez les genres ayant au moins deux patients.

SELECT gender, COUNT(*) AS number_of_patients FROM patients GROUP BY gender HAVING COUNT(*) >= 2;

-- 20. Créer une vue : Admissions actives Créez une vue listant toutes les admissions en cours.

CREATE VIEW active_admissions AS
SELECT * FROM admissions WHERE discharge_date IS NULL OR discharge_date > CURDATE();
