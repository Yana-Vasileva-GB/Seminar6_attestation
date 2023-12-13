DROP DATABASE IF EXISTS attestation;
CREATE DATABASE IF NOT EXISTS attestation;
USE attestation;

-- Итоговая аттестация
/* Задание 1. 
Создайте процедуру, которая принимает кол-во сек и формат их в кол-во дней часов. 
Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '
*/
DROP PROCEDURE time1;
DELIMITER //
CREATE PROCEDURE time1(sec INT)
BEGIN
	DECLARE days DECIMAL(6,0);
    DECLARE hours DECIMAL(6,0);
	DECLARE minutes DECIMAL(6,0);
    DECLARE seconds DECIMAL(6,0);
	DECLARE result DECIMAL(6,0);
    SET days = TRUNCATE(sec/86400,0);
    SET hours = TRUNCATE(((sec - days*86400)/3600),0);
    SET minutes = TRUNCATE(((sec - days*86400 - hours*3600)/60),0);
    SET seconds = TRUNCATE((sec - days*86400 - hours*3600 - minutes*60),0);
    SELECT sec, CONCAT(days," days ", hours," hours ", minutes, " minutes ", seconds," seconds ") AS days;
END //
DELIMITER ;

CALL time1(123456);

/* Задание 2. 
Создайте функцию, которая выводит только четные числа от 1 до 10. 
Пример: 2,4,6,8,10 
*/

DROP FUNCTION even;
DELIMITER //
CREATE FUNCTION even(a INT)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
	DECLARE num1 INT DEFAULT 0;
    -- DECLARE num2 INT DEFAULT 0;
    DECLARE result VARCHAR(100) DEFAULT " ";
    IF a = 1 THEN
		RETURN CONCAT("Чётных чисел нет");
	ELSEIF (a > 10 OR a < 1) THEN
		RETURN CONCAT("Укажите число от 1 до 10");
	ELSE
        WHILE num1 < a DO
			SET num1 = num1 + 2;
			SET result = CONCAT(result, " ", num1, " ");			
		END WHILE;
		RETURN result;
	END IF;
END //
DELIMITER ;

SELECT EVEN(10);
