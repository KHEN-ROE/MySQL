-- (5) 출판사별로 도서의 평균가보다 비싼 도서의 이름을 보이시오(예를 들어 A 출판사 도서의 평균가가 20,000원이라면 A 출판사 도서 중 20,000원 이상인 도서를 보이면 된다). 5,6,7 다시 할 것
drop procedure if exists hpbook;
delimiter //
create procedure hpbook(
	out mypublisher varchar(40)
)
begin
	select publisher, bookname, price
	from book
	where price > (select avg(price) from book);
end;
//
delimiter ;
call hpbook(@대한미디어);