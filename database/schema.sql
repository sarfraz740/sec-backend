CREATE DATABASE `shareecare_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;

CREATE TABLE `sec_configurations` (
  `config_id` int NOT NULL PRIMARY KEY,
  `configurations` JSON DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `sec_roles` (
  `role_ID` int NOT NULL PRIMARY KEY,
  `role_name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `sec_review_types` (
  `review_id` int NOT NULL PRIMARY KEY,
  `review_name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `sec_countries` (
  `country_id` int NOT NULL PRIMARY KEY,
  `country_code` int NOT NULL,
  `country_name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `sec_states` (
  `state_id` int NOT NULL PRIMARY KEY,
  `country_id` int NOT NULL,
  CONSTRAINT `states_country_id` 
    FOREIGN KEY (`country_id`) 
    REFERENCES `sec_countries` (`country_id`) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `sec_cities` (
  `city_id` int NOT NULL PRIMARY KEY,
  `state_id` int NOT NULL,
  CONSTRAINT `cities_state_id` 
    FOREIGN KEY (`state_id`) 
    REFERENCES `sec_states` (`state_id`) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `sec_hcf_categories` (
  `hcf_category_id` int NOT NULL PRIMARY KEY,
  `hcf_category` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `sec_departments` (
  `department_id` int NOT NULL PRIMARY KEY,
  `department_name` varchar(50) DEFAULT NULL,
  `added_by` int DEFAULT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT `department_added_by` 
    FOREIGN KEY (`department_added_by`) 
    REFERENCES `sec_users` (`suid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `sec_hcf_exam` (
  `exam_id` int NOT NULL PRIMARY KEY,
  `exam_name` varchar(255) DEFAULT NULL,
  `hcf_id` int DEFAULT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT `hcf_exam_created_by` 
    FOREIGN KEY (`hcf_id`) 
    REFERENCES `sec_users` (`suid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `sec_hcf_sub_exam` (
  `sub_exam_id` int NOT NULL PRIMARY KEY,
  `exam_id` int NOT NULL,
  `sub_exam_name` varchar(255) DEFAULT NULL,
  `hcf_id` int DEFAULT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT `hcf_sub_exam_created_by` 
    FOREIGN KEY (`hcf_id`) 
    REFERENCES `sec_users` (`suid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `sec_users` (
  `suid` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `role_id` int NOT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `middle_name` varchar(100) DEFAULT NULL,
  `can_login` tinyint(1) DEFAULT 1,
  `is_active` tinyint(1) DEFAULT 1,
  `is_approved` tinyint(1) DEFAULT 1,
  `approved_by` INT DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `dialing_code` int DEFAULT NULL,
  `contact_no_primary` varchar(20) NOT NULL,
  `contact_no_secondary` varchar(20) DEFAULT NULL,
  `added_by` varchar(250) DEFAULT NULL,
  `gender` varchar(12) DEFAULT NULL,
  `DOB` varchar(30) DEFAULT NULL,
  `country_id` int DEFAULT NULL,
  `state_id` int DEFAULT NULL,
  `city_id` int DEFAULT NULL,
  `street_address1` varchar(150) DEFAULT NULL,
  `street_address2` varchar(150) DEFAULT NULL,
  `zip_code` varchar(15) DEFAULT NULL,
  `home_no` varchar(20) DEFAULT NULL,
  `location` TEXT DEFAULT NULL,
  `profile_picture` longtext DEFAULT NULL,
  `access_token` varchar(255) DEFAULT NULL,
  `access_token_generated_on` DATETIME DEFAULT NULL,
  `access_token_expires_on` DATETIME DEFAULT NULL,
  `registration_type` varchar(10) DEFAULT NULL,
  `registered_via` varchar(10) DEFAULT NULL,
  `last_login` DATETIME DEFAULT NULL,
  `last_active` DATETIME DEFAULT NULL,
  `force_logout` tinyint(1) DEFAULT 1
  `tokens` longtext DEFAULT NULL
  `registered_device` varchar(5) DEFAULT "web"
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `contact_no_primary_UNIQUE` (`contact_no_primary`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  KEY `role_id_idx` (`role_id`),
  CONSTRAINT `role_id` 
    FOREIGN KEY (`role_id`) 
    REFERENCES `sec_roles` (`role_ID`) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `sec_user_codes` (
  `code_id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `user_id` int DEFAULT NULL,
  `otp_code` varchar(15) DEFAULT NULL,
  `otp_code_generated_on` DATETIME DEFAULT NULL,
  `activation_code` varchar(15) DEFAULT NULL,
  `activation_code_generated_on` DATETIME DEFAULT NULL,
  `no_of_tries` INT NOT NULL DEFAULT 1,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT `user_code_user_id` 
    FOREIGN KEY (`user_id`) 
    REFERENCES `sec_users` (`suid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `sec_doctors_details` (
  `doctor_details_id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `qualification` varchar(45) DEFAULT NULL,
  `description` TEXT DEFAULT NULL,
  `qualified_year` int DEFAULT NULL,
  `reg_date` DATETIME NOT NULL DEFAULT NULL,
  `speciality_id` int DEFAULT NULL,
  `state_med_council_id` varchar(45) DEFAULT NULL,
  `state_reg_number` varchar(45) DEFAULT NULL,
  `country_reg_number` varchar(45) DEFAULT NULL,
  `university_name` varchar(45) DEFAULT NULL,
  `doctor_id` int DEFAULT NULL,
  `approved` tinyint(1) DEFAULT NULL,
  UNIQUE KEY `state_regnumber_UNIQUE` (`state_regnumber`),
  KEY `doctor_id_idx` (`doctor_id`),
  CONSTRAINT `doctor_id` 
    FOREIGN KEY (`doctor_id`) 
    REFERENCES `sec_users` (`suid`)
  CONSTRAINT `state_med_council_id` 
    FOREIGN KEY (`state_med_council_id`) 
    REFERENCES `sec_states` (`state_id`)
  CONSTRAINT `doctor_speciality_id` 
    FOREIGN KEY (`speciality_id`) 
    REFERENCES `sec_departments` (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `sec_hcf_details` (
  `hcf_details_id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `category_id` int NOT NULL,
  `hcf_name` varchar(255) DEFAULT NULL,
  `working_hours` varchar(50) DEFAULT NULL,
  `doing_business` TEXT DEFAULT NULL,
  `facilities` TEXT DEFAULT NULL,
  `reg_date` DATETIME NOT NULL DEFAULT NULL,
  `license_no` varchar(45) DEFAULT NULL,
  `fax_no` varchar(45) DEFAULT NULL,
  `office_no` varchar(45) DEFAULT NULL,
  `terms_and_condition` varchar(50) DEFAULT NULL,
  `university_name` varchar(45) DEFAULT NULL,
  `hcf_id` int DEFAULT NULL,
  `approved` tinyint(1) DEFAULT NULL,
  UNIQUE KEY `state_regnumber_UNIQUE` (`state_regnumber`),
  KEY `hcf_id_idx` (`hcf_id`),
  CONSTRAINT `hcf_id` 
    FOREIGN KEY (`hcf_id`) 
    REFERENCES `sec_users` (`suid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `sec_user_devices` (
  `user_id` int NOT NULL,
  `device_type` varchar(20) DEFAULT NULL,
  `device_id` varchar(255) DEFAULT NULL,
  `allow_notification` tinyint(1) DEFAULT 1,
  `device_data` varchar(100) DEFAULT NULL,
  `activated_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `device_id_UNIQUE` (`device_id`),
  KEY `user_id_idx` (`user_id`),
  CONSTRAINT `user_id` 
    FOREIGN KEY (`user_id`) 
    REFERENCES `sec_users` (`suid`)
    ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `sec_banking_details` (
  `bank_details_id,` int NOT NULL AUTO_INCREMENT,
  `account_number` int DEFAULT NULL,
  `bank_name` varchar(45) DEFAULT NULL,
  `ifsc_code` varchar(45) DEFAULT NULL,
  `branch` varchar(45) DEFAULT NULL,
  `branch_city_id` int DEFAULT NULL,
  `branch_state_id` int DEFAULT NULL,
  `branch_email` varchar(45) DEFAULT NULL,
  `branch_phone` varchar(45) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`bank_details_id,`),
  UNIQUE KEY `account_number_UNIQUE` (`bank_name`,`account_number`) /*!80000 INVISIBLE */,
  KEY `bank_uid_idx` (`user_id`),
  CONSTRAINT `bank_uid` 
    FOREIGN KEY (`user_id`) 
    REFERENCES `sec_users` (`suid`)
    ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- CREATE TABLE `sec_card_details` (
--   `card_details_id` int NOT NULL AUTO_INCREMENT,
--   `card_no` varchar(45) DEFAULT NULL,
--   `bank_name` varchar(45) DEFAULT NULL,
--   `exp_month` varchar(10) DEFAULT NULL,
--   `exp_year` int DEFAULT NULL,
--   `user_id` int DEFAULT NULL,
--   `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
--   `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
--   PRIMARY KEY (`card_details_id`),
--   KEY `card_user_id_idx` (`user_id`),
--   CONSTRAINT `card_user_id` 
--     FOREIGN KEY (`user_id`) 
--     REFERENCES `sec_users` (`suid`)
--     ON DELETE CASCADE
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `sec_docter_fee_plans` (
  `doctor_fee_plan_id` int NOT NULL AUTO_INCREMENT,
  `doctor_id` int NOT NULL,
  `plan_description` varchar(500) NOT NULL,
  `plan_fee` int DEFAULT 0,
  `plan_name` varchar(45) DEFAULT NULL,
  `plan_duration` varchar(45) DEFAULT NULL,
  `start_date` varchar(45) DEFAULT NULL,
  `end_date` varchar(45) DEFAULT NULL,
  `is_active` tinyint DEFAULT 0,
  `is_trial` tinyint(1) DEFAULT 1,
  `no_of_reviews` tinyint(1) DEFAULT 1,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`doctor_fee_plan_id`),
  UNIQUE KEY `doctor_id_UNIQUE` (`doctor_id`),
  UNIQUE KEY `plan_name_UNIQUE` (`plan_name`),
  KEY `doctor_id_plan_idx` (`doctor_id`),
  CONSTRAINT `doctor_id_plan` 
    FOREIGN KEY (`doctor_id`) 
    REFERENCES `sec_users` (`suid`)
    ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `sec_transactions` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `doctor_fee_plan_id` int NOT NULL,
  `amount` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `description` TEXT DEFAULT NULL,
  `status` ENUM('created', 'authorized', 'processed', 'failed') NOT NULL DEFAULT 'created',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  CONSTRAINT `doctor_fee_plan_id` 
    FOREIGN KEY (`doctor_fee_plan_id`) 
    REFERENCES `sec_docter_fee_plans` (`doctor_fee_plan_id`)
    ON DELETE CASCADE,
  CONSTRAINT `transaction_user_id` 
    FOREIGN KEY (`user_id`)
    REFERENCES `sec_users` (`suid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `sec_patient_plans` (
  `plan_id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `patient_id` int NOT NULL,
  `doctor_fee_plan_id` int NOT NULL,
  `plan_description` varchar(500) DEFAULT NULL,
  `plan_fee` int DEFAULT NULL,
  `plan_name` varchar(45) DEFAULT NULL,
  `plan_duration` varchar(45) DEFAULT NULL,
  `start_date` varchar(45) DEFAULT NULL,
  `end_date` varchar(45) DEFAULT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `plan_name_UNIQUE` (`plan_name`),
  CONSTRAINT `fk_doctor_fee_plan_id` 
    FOREIGN KEY (`doctor_fee_plan_id`) 
    REFERENCES `sec_docter_fee_plans` (`doctor_fee_plan_id`)
    ON DELETE CASCADE,
  CONSTRAINT `fee_plan_patient_id` 
    FOREIGN KEY (`patient_id`) 
    REFERENCES `sec_users` (`suid`)
    ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `sec_patient_doctor_conversation` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `conversation_id` int NOT NULL,
  `conversation_name` varchar(200) DEFAULT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `conversation_id_UNIQUE` (`conversation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `sec_conversation_members` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `conversation_id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT `member_user_id` 
    FOREIGN KEY (`user_id`) 
    REFERENCES `sec_users` (`suid`)
    ON DELETE CASCADE,
  CONSTRAINT `member_conversation_id` 
    FOREIGN KEY (`conversation_id`) 
    REFERENCES `sec_patient_doctor_conversation` (`conversation_id`)
    ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `sec_conversation_messages` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `conversation_id` int NOT NULL,
  `sender_id` int NOT NULL,
  `receiver_id` int NOT NULL,
  `content` TEXT DEFAULT NULL,
  `sent_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `read_at` DATETIME,
  `delivered_at` DATETIME,
  `status` ENUM('sent', 'delivered', 'read') NOT NULL DEFAULT 'sent',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT `message_sender_id` 
    FOREIGN KEY (`sender_id`) 
    REFERENCES `sec_users` (`suid`)
    ON DELETE CASCADE,
  CONSTRAINT `message_receiver_id` 
    FOREIGN KEY (`receiver_id`) 
    REFERENCES `sec_users` (`suid`)
    ON DELETE CASCADE,
  CONSTRAINT `message_conversation_id` 
    FOREIGN KEY (`conversation_id`) 
    REFERENCES `sec_patient_doctor_conversation` (`conversation_id`)
    ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `sec_connections` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `user_id` int NOT NULL,
  `connection_id` VARCHAR(100) DEFAULT NULL,
  `role_id` int DEFAULT NULL,
  `domain_name` VARCHAR(20) NOT NULL,
  `api_gateway_domain` VARCHAR(50) NOT NULL,
  `connect_source` VARCHAR(10) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT `connection_user_id` 
    FOREIGN KEY (`user_id`) 
    REFERENCES `sec_users` (`suid`)
    ON DELETE CASCADE,
  CONSTRAINT `connection_role_id` 
    FOREIGN KEY (`role_id`) 
    REFERENCES `sec_roles` (`role_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `sec_appointments` (
  `appointment_id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `appointment_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `patient_id` INT NOT NULL,
  `doctor_id` INT NOT NULL,
  `symptoms` TEXT DEFAULT NULL,
  `attachments` TEXT DEFAULT NULL,
  `status` ENUM("booked", "in_progress", "completed", "next_review", "canceled")
  `next_review_date` DATETIME DEFAULT NULL,
  `action_done_by` INT NOT NULL
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT `appointment_patient_id` 
    FOREIGN KEY (`patient_id`) 
    REFERENCES `sec_users`(`suid`),
  CONSTRAINT `appointment_doctor_id` 
    FOREIGN KEY (`doctor_id`) 
    REFERENCES `sec_users`(`suid`),
  CONSTRAINT `appointment_action_done_by` 
    FOREIGN KEY (`action_done_by`) 
    REFERENCES `sec_users`(`suid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `sec_doctor_notes` (
    `notes_id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `patient_id` INT NOT NULL,
    `doctor_id` INT NOT NULL,
    `description` TEXT DEFAULT NULL,
    `appointment_id` INT DEFAULT NULL,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    CONSTRAINT `notes_patient_id` 
        FOREIGN KEY (`patient_id`) 
        REFERENCES `sec_users`(`suid`),
    CONSTRAINT `notes_doctor_id` 
        FOREIGN KEY (`doctor_id`) 
        REFERENCES `sec_users`(`suid`),
    CONSTRAINT `notes_appointment_id` 
        FOREIGN KEY (`appointment_id`) 
        REFERENCES `sec_appointments`(`appointment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `sec_reviews` (
    `user_review_id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `from_id` INT NOT NULL,
    `to_id` INT NOT NULL,
    `description` TEXT DEFAULT NULL,
    `review_type` INT DEFAULT 1,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT `review_id` 
        FOREIGN KEY (`review_id`) 
        REFERENCES `sec_reviews` (`review_id`),
    CONSTRAINT `reviews_from_id` 
        FOREIGN KEY (`from_id`) 
        REFERENCES `sec_users`(`suid`),
    CONSTRAINT `reviews_to_id` 
        FOREIGN KEY (`to_id`) 
        REFERENCES `sec_users`(`suid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `sec_tests` (
    `test_id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `patient_id` INT NOT NULL,
    `doctor_id` INT NOT NULL,
    `special_instructions` TEXT DEFAULT NULL,
    `test_files` VARCHAR(100) NOT NULL,
    `hcf_id` INT DEFAULT NULL,
    `exam_id` INT DEFAULT NULL,
    `sub_exam_id` INT DEFAULT NULL,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT `tests_patient_id` 
        FOREIGN KEY (`patient_id`) 
        REFERENCES `sec_users`(`suid`),
    CONSTRAINT `tests_doctor_id` 
        FOREIGN KEY (`doctor_id`) 
        REFERENCES `sec_users`(`suid`),
    CONSTRAINT `tests_hcf_id` 
        FOREIGN KEY (`hcf_id`) 
        REFERENCES `sec_users`(`suid`),
    CONSTRAINT `tests_exam_id` 
        FOREIGN KEY (`exam_id`) 
        REFERENCES `sec_exam`(`exam_id`),
    CONSTRAINT `tests_sub_exam_id` 
        FOREIGN KEY (`sub_exam_id`) 
        REFERENCES `sec_sub_exam`(`sub_exam_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `sec_reports` (
    `report_id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `test_id` INT NOT NULL,
    `report_path` VARCHAR(100) NOT NULL,
    `approved_by` INT DEFAULT NULL,
    `is_approved` ENUM(0, 1) DEFAULT 1,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT `reports_test_id` 
        FOREIGN KEY (`test_id`) 
        REFERENCES `sec_tests`(`test_id`),
    CONSTRAINT `reports_shared_with` 
        FOREIGN KEY (`shared_with`) 
        REFERENCES `sec_users`(`suid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `sec_reports_shared` (
    `report_shared_id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `test_id` INT NOT NULL,
    `report_id` INT NOT NULL,
    `shared_with` INT DEFAULT NULL,
    `shared_by` INT DEFAULT NULL,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT `reports_shared_report_id` 
        FOREIGN KEY (`report_id`) 
        REFERENCES `sec_reports`(`report_id`),
    CONSTRAINT `reports_shared_test_id` 
        FOREIGN KEY (`test_id`) 
        REFERENCES `sec_tests`(`test_id`),
    CONSTRAINT `reports_shared_shared_with` 
        FOREIGN KEY (`shared_with`) 
        REFERENCES `sec_users`(`suid`),
    CONSTRAINT `reports_shared_shared_by` 
        FOREIGN KEY (`shared_by`) 
        REFERENCES `sec_users`(`suid`),
    CONSTRAINT `reports_shared_approved_by` 
        FOREIGN KEY (`approved_by`) 
        REFERENCES `sec_users`(`suid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



