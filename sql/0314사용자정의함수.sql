SET GLOBAL log_bin_trust_function_creators = 1; //ON -- 함수 생성 안 되면 이 문장 실행 

delimiter //
CREATE FUNCTION fnc_Interest(Price INTEGER) 
RETURNS INT
BEGIN
DECLARE myInterest INTEGER;
-- 가격이 30,000원 이상이면 10%, 30,000원 미만이면 5%
IF Price >= 30000 THEN SET myInterest = Price * 0.1;
ELSE SET myInterest := Price * 0.05;
END IF; 
RETURN myInterest;
END; 
// 
delimiter ;

/* Orders 테이블에서 각 주문에 대한 이익을 출력 */ 
SELECT custid, ordersid, salesprice, fnc_Interest(salesprice) interest 
FROM Orders;

-- (8) 고객의 주문 총액을 계산하여 20,000원 이상이면 '우수', 20,000원 미만이면 '보통'을 반환하는 함수 Grade()를 작성하시오. Grade()를 호출하여 고객의 이름과 등급을 보이는 SQL 문도 작성하시오.
delimiter //
create function grade(custid int)
returns varchar(10)
begin
declare total_amount varchar(10);
select sum(salesprice) into total_amount
from orders, customer
where orders.custid = customer.custid;
if total_amount >= 20000 then
	return '우수';
else
	return '보통';
end if;
end;
//
delimiter ;

select name, grade(customer.custid) as grade
from customer;

select * from orders;
