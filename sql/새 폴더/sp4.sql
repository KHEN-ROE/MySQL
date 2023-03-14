-- (4) 출판사별로 출판사 이름과 도서의 판매 총액을 보이시오(판매 총액은 Orders 테이블에 있다).
drop procedure if exists publisherRevenue;
delimiter //
CREATE PROCEDURE publisherRevenue(
	out mypublisher varchar(40)
 )
 begin
	select publisher, sum(salesprice)
    from book
    join orders where book.bookid = orders.bookid
    group by publisher;
 end;
 //
 delimiter ;
 
 call publisherRevenue(@굿스포츠);



