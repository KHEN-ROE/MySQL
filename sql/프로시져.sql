-- 예제 5-1 Book 테이블에 한 개의 투플을 삽입하는 프로시저
use db0220;
delimiter //
create procedure insertbook(
	in mybookid integer, -- in 생략가능
    in mybookname varchar(40),
    in mypublisher varchar(40),
    in myprice integer)
    begin
		insert into book(bookid, bookname, publisher, price)
			values(mybookid, mybookname, mypublisher, myprice);
end;
//
delimiter ;

/*프로시저 insertbook을 테스트하는 부분*/
call insertbook(13, '스포츠과학', '마당과학서적', 25000); -- ()안에 파라미터 전달해서 튜플 삽입
call insertbook(14, '야구과학', '마당과학서적', 5000);
select * from book;

-- 예제 5-2 동일한 도서가 있는지 점검한 후 삽입하는 프로시저
use db0220;
delimiter //
create procedure bookinsertorupdate(
mybookid integer,
mybookname varchar(40),
mypublisher varchar(40),
myprice int
)
begin
declare mycount integer;
select count(*) into mycount from book
where bookname like mybookname;
if mycount!=0 then
set sql_safe_updates=0; /*delete, update 연산에 필요한 설정문*/
update book set price = myprice
 where bookname like mybookname;
 else
 insert into book(bookid,bookname,publisher, price)
 values(mybookid,mybookname,mypublisher,myprice);
 end if;
 end;
 //
 delimiter ;

-- BookInsertOrUpdate 프로시저를 실행하여 테스트하는 부분
CALL BookInsertOrUpdate(15, '스포츠 즐거움', '마당과학서적', 25000);
SELECT * FROM Book; -- 15번 투플 삽입 결과 확인
-- BookInsertOrUpdate 프로시저를 실행하여 테스트하는 부분
CALL BookInsertOrUpdate(15, '스포츠 즐거움', '마당과학서적', 20000);
SELECT * FROM Book; -- 15번 투플 가격 변경 확인

-- <학과> 테이블에 새로운 레코드를 삽입하고 삽입한 레코드를 보여주는 '새학과'
-- stored procedure를 만드시오. 아래 실행 결과는 이 프로시저를 이용하여 출력한예이다.
use db0221;
delimiter //
create procedure 새학과(
	in 새학과번호 char(2),
    in 새학과명 char(20),
    in 새전화번호  char(20)
)
begin
	insert into 학과(학과번호, 학과명, 전화번호)
	values(새학과번호, 새학과명, 새전화번호);
end;
//
delimiter ;

-- 프로시저 테스트
CALL 새학과('08','컴퓨터보안학과','022-200-7000');
SELECT * FROM 학과;

