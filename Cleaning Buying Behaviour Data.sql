-- creating a database titled Buying Behavior of nigerians with data gotten from public data collectiion using google forms 

create database Buying_Behaviour;

-- creating and adjusting the tables gotten from the questionnaire 
create table Buying_Behaviour
				(
                ID varchar(10) primary key,
                Gender varchar(7),
                Age_Range varchar(10),
                Income_level varchar(29),	
                Location varchar(26),
                Shopping_Frequency int,
                Monthly_Spending varchar(30),
                Preferred_Shoping_option varchar(25),
                Preferred_Payment_option varchar(63),
                Influence_on_buying_Decision varchar(44),
                Occupation Varchar(14),
                Product_frequently_bought varchar(35)
                );
                
                
 -- creating a trigger that automatically generates IDs for the data 
 
 
 DELIMITER //
CREATE TRIGGER before_insert_on_buying_behaviour
BEFORE INSERT ON Buying_Behaviour
FOR EACH ROW
BEGIN 
    DECLARE next_id INT;
    SELECT IFNULL(MAX(CAST(SUBSTRING(ID, 3) AS UNSIGNED)), 0) + 1 
    INTO next_id 
    FROM Buying_Behaviour;
    
    SET NEW.ID = CONCAT('ID', LPAD(next_id, 3, '0'));
END//

DELIMITER ;

select * from buying_behaviour
 
 
-- Data cleaning 

-- standardzing the Age_range table converting the 'â€“' into '-'

UPDATE Buying_Behaviour
SET Age_Range = REPLACE(Age_Range, 'â€“', '-');

-- trim data set to remove white spaces 
UPDATE Buying_Behaviour
SET 
    ID = TRIM(ID),
    Gender = TRIM(Gender),
    Age_Range = TRIM(Age_Range),
    Income_level = TRIM(Income_level),
Location = TRIM(Location),
    Monthly_Spending = TRIM(Monthly_Spending),
    Preferred_Shoping_option = TRIM(Preferred_Shoping_option),
    Preferred_Payment_option = TRIM(Preferred_Payment_option),
    Influence_on_buying_Decision = TRIM(Influence_on_buying_Decision),
    Occupation = TRIM(Occupation),
    Product_frequently_bought = TRIM(Product_frequently_bought);

-- find and remove missing values 

SELECT *
FROM Buying_Behaviour
WHERE 
    Gender IS NULL OR Gender = '' OR
    Age_Range IS NULL OR Age_Range = '' OR
    Income_level IS NULL OR Income_level = '' OR
    Location IS NULL OR Location = '' OR
    Monthly_Spending IS NULL OR Monthly_Spending = '' OR
    Preferred_Shoping_option IS NULL OR Preferred_Shoping_option = '' OR
    Preferred_Payment_option IS NULL OR Preferred_Payment_option = '' OR
    Influence_on_buying_Decision IS NULL OR Influence_on_buying_Decision = '' OR
    Occupation IS NULL OR Occupation = '' OR
    Product_frequently_bought IS NULL OR Product_frequently_bought = '';


-- delete 

DELETE FROM Buying_Behaviour
WHERE 
    Gender IS NULL OR Gender = '' OR
    Age_Range IS NULL OR Age_Range = '' OR
    Income_level IS NULL OR Income_level = '' OR
    Location IS NULL OR Location = '' OR
    Monthly_Spending IS NULL OR Monthly_Spending = '' OR
    Preferred_Shoping_option IS NULL OR Preferred_Shoping_option = '' OR
    Preferred_Payment_option IS NULL OR Preferred_Payment_option = '' OR
    Influence_on_buying_Decision IS NULL OR Influence_on_buying_Decision = '' OR
    Occupation IS NULL OR Occupation = '' OR
    Product_frequently_bought IS NULL OR Product_frequently_bought = '';


-- Standardize location column
-- find the distinct locations 
SELECT 
DISTINCT(Location) FROM buying_behaviour
 
 standardize them 
 
 UPDATE Buying_Behaviour
SET Location = CASE
    -- Federal Capital Territory / Abuja
    WHEN Location IN ('Federal Capital Territory', 'Abuja/Ilorin', 'Abuja') THEN 'Abuja'
    -- Lagos variations
    WHEN Location IN ('Lagos State', 'Lagos stats', 'Egbeda Lagos State', 'Lagos') THEN 'Lagos'
    -- Kwara variations (Ilorin is in Kwara)
    WHEN Location IN ('Kwara state', 'Kwara', 'Ilorin, kwara state', 'Ilorin','Kwarea') THEN 'Kwara'
    -- Oyo variations (Ibadan and Egbeda are in Oyo)
    WHEN Location IN ('Oyo', 'Ibadan') THEN 'Oyo'
    -- Osun variations
    WHEN Location IN ('Osun State', 'Osun') THEN 'Osun'
    -- Ogun variations
    WHEN Location IN ('Ogun state', 'Ogun') THEN 'Ogun'
    -- Kogi variations
    WHEN Location IN ('Kogi state', 'Kogi') THEN 'Kogi'
    -- Plateau variations
    WHEN Location IN ('Plateau state') THEN 'Plateau'
    -- Kano
    WHEN Location = 'Kano' THEN 'Kano'
    -- Kaduna variations
    WHEN Location IN ('Kaduna State', 'Kaduna') THEN 'Kaduna'
    -- Delta
    WHEN Location = 'Delta' THEN 'Delta'
    -- Ekiti
    WHEN Location = 'Ekiti' THEN 'Ekiti'
    -- Borno
    WHEN Location = 'Borno' THEN 'Borno'
    -- Bauchi
    WHEN Location = 'Bauchi' THEN 'Bauchi'
    -- Default (if no match)
    ELSE Location
END;
 
 


 