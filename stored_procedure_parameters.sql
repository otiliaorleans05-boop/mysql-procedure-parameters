-- =======================================================
-- 1. Tham số loại IN (Parameter mode IN)
-- Lấy thông tin khách hàng theo customerNumber truyền vào
-- =======================================================
DELIMITER //

DROP PROCEDURE IF EXISTS getCusById //

CREATE PROCEDURE getCusById (
    IN cusNum INT(11)
)
BEGIN
    SELECT * FROM customers WHERE customerNumber = cusNum;
END //

DELIMITER ;

-- Gọi thực thi Stored Procedure có tham số IN:
CALL getCusById(175);


-- =======================================================
-- 2. Tham số loại OUT (Parameter mode OUT)
-- Đếm tổng số khách hàng theo thành phố và trả về qua biến OUT
-- =======================================================
DELIMITER //

DROP PROCEDURE IF EXISTS GetCustomersCountByCity //

CREATE PROCEDURE GetCustomersCountByCity (
    IN  in_city VARCHAR(50),
    OUT total INT
)
BEGIN
    SELECT COUNT(customerNumber)
    INTO total
    FROM customers
    WHERE city = in_city;
END //

DELIMITER ;

-- Gọi thực thi Stored Procedure có tham số OUT:
CALL GetCustomersCountByCity('Lyon', @total);
SELECT @total;


-- =======================================================
-- 3. Tham số loại INOUT (Parameter mode INOUT)
-- Nhận vào một biến, cộng dồn giá trị và trả lại chính biến đó
-- =======================================================
DELIMITER //

DROP PROCEDURE IF EXISTS SetCounter //

CREATE PROCEDURE SetCounter (
    INOUT counter INT,
    IN inc INT
)
BEGIN
    SET counter = counter + inc;
END //

DELIMITER ;

-- Khởi tạo biến và gọi thực thi Stored Procedure INOUT:
SET @counter = 1;
CALL SetCounter(@counter, 1); -- kết quả tăng lên 2
CALL SetCounter(@counter, 1); -- kết quả tăng lên 3
CALL SetCounter(@counter, 5); -- kết quả tăng lên 8
SELECT @counter;             -- Hiển thị: 8