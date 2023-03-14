-- (1) InsertBook() 프로시저를 수정하여 고객을 새로 등록하는 InsertCustomer() 프로시저를 작성하시오.
use db0220;
drop procedure if exists insertCustomer;
delimiter //
create procedure insertCustomer(
	in mycustid integer, -- in 생략가능
    in myname varchar(40),
    in myaddress varchar(40),
    in myphone integer
    )
    begin
		insert into customer(custid, name, address, phone)
			values(mycustid, myname, myaddress, myphone);
end;
//
delimiter ;

/* 프로시저 InsertBook을 테스트하는 부분 */
CALL InsertCustomer(6, '손흥민', '런던', 010-1234-1234);
SELECT * FROM customer;

-- (2) BookInsertOrUpdate() 프로시저를 수정하여 삽입 작업을 수행하는 프로시저를 작성하시오. 삽입하려는 도서와
-- 동일한 도서가 있으면 삽입하려는 도서의 가격이 높을 때만 새로운 값으로 변경한다. use madang
drop procedure if exists BookInsertOrUpdate;
delimiter //
CREATE PROCEDURE BookInsertOrUpdate(
 myBookID INTEGER,
 myBookName VARCHAR(40),
 myPublisher VARCHAR(40),
 myPrice INT
 )
BEGIN
 DECLARE mycount INTEGER;
 SELECT count(*) INTO mycount FROM Book
 WHERE bookname LIKE myBookName;
 IF mycount != price THEN
 SET SQL_SAFE_UPDATES=0; /* DELETE, UPDATE 연산에 필요한 설정 문 */
 UPDATE Book SET price = myPrice
 WHERE price < myprice;
 ELSE
 INSERT INTO Book(bookid, bookname, publisher, price)
 VALUES(myBookID, myBookName, myPublisher, myPrice);
 END IF;
END;
//
delimiter ;

CALL BookInsertOrUpdate(15, '스포츠 즐거움', '마당과학서적', 25000); -- 이거 안 됨... 다시
call BookInsertorUpdate(15, '스포츠 즐거움', '마당과학서적', 30000);
call BookInsertorUpdate(15, '스포츠 즐거움', '마당과학서적', 20000);
select * from book;




-- (3) 출판사가 '이상미디어'인 도서의 이름과 가격을 보여주는 프로시저를 작성하시오. -- 커서 이용. 커서 안쓰고 작성 해볼 것
drop procedure if exists db0220.cursor_pro3;
delimiter //
create procedure cursor_pro3(
)
begin
	declare myname varchar(40);
    declare myprice int;
    declare endOfRow Boolean default false;
    declare bookcursor cursor for select bookname, price from book where publisher="이상미디어";
	declare continue handler for not found set endOfRow = true;
    open bookcursor;
    cursor_loop : loop
		fetch bookcursor into myname, myprice;
        if endOfRow then leave cursor_loop;
        end if;
        select myname, myprice;
	end loop cursor_loop;
    close bookcursor;
end;
//
delimiter ;

-- (3) 출판사가 '이상미디어'인 도서의 이름과 가격을 보여주는 프로시저를 작성하시오. -- 커서 안 쓰고
drop procedure if exists bkidname;
delimiter //
create procedure bkidname(
	out Ppublisher varchar(40)
)
begin
	select bookname, price
    from book
    where publisher = "이상미디어";
end;
//
delimiter ;

call bkidname(@Ppublisher);

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

-- (7) 주문이 있는 고객의 이름과 주문 총액을 출력하고, 주문이 없는 고객은 이름만 출력하는 프로시저를 작성하시오 -- 커서 이용. 혼자 해볼 것
drop procedure if exists test_proc7;
delimiter //
create procedure test_proc7()
begin
	declare done boolean default false;
    declare v_sum int;
    declare v_id int;
    declare v_name varchar(20);
    -- select한 결과를 cursor1로 정의
    declare cursor1 cursor for select custid, name from customer;
    declare continue handler for not found set done = true;
    open cursor1;
    my_loop: Loop
    -- loop 하며 cursor1의 데이터를 불러와 변수에 넣는다.
    fetch cursor1 into v_id, v_name;
		select sum(salesprice) into v_sum from orders where custid=v_id ;
        if done then
			leave my_loop;
		end if;
        select v_name, v_sum;
        end loop my_loop;
	close cursor1;
end;
//
delimiter ;

call test_proc7();