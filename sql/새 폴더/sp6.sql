-- (6) 고객별로 도서를 몇 권 구입했는지와 총 구매액을 보이시오
drop procedure if exists phinfo;
delimiter //
create procedure phinfo(
	out pname varchar(40)
)
begin
	select name, count(orders.custid) as '구매도서 수', sum(salesprice) as '총 구매액'
    from orders
    join customer on orders.custid = customer.custid
    group by name;
end;
//
delimiter ;

call phinfo(@박지성);