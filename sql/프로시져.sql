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

	in my학과번호 char(2), -- 매개변수임. 매개변수명은 컬럼명과 다르게 작성해야함
    in my학과명 char(20),
    in my전화번호  char(20)

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

use db0221;
delimiter //
CREATE PROCEDURE `학과_입력_수정` (
	in my학과번호 char(2),
    in my학과명 char(20),
    in my전화번호  char(20)
)
BEGIN
	-- 입력 시 학과가 있는 경우는 업데이트로 하고 없는 경우에 입력이 되도록
    declare cnt int; -- 지역 변수 선언 
    select count(*) into cnt from 학과 where 학과번호=my학과번호; -- 조건절 의미? 학과번호와 파라미터로 전달할 my학과번호가 일치하는 데이터 대상으로 count(*)수행
    if (cnt=0) then
		insert into 학과 values(학과번호, 학과명, 전화번호);
     else
		update 학과 set 학과명=my학과명, 전화번호=my전화번호 where 학과번호=my학과번호;
    end if;
    
END;
//
delimiter ;

-- 프로시저 테스트
CALL 새학과('08','컴퓨터보안학과','022-200-7000'); -- 프로시저 호출하고 매개변수 전달
SELECT * FROM 학과;

call 학과_입력_수정('08','빅데이터보안학과','022-111-1111');
call 학과_입력_수정('06','사물인터넷학과','022-333-3333'); -- 삽입 왜 안되지 나중에 다시

-- "수강신청" 데이터베이스의 총 학생 수, 교수 수, 과목 수를 계산하는 "통계“ stored procedure를 만드시오.
use db0221;
delimiter //
CREATE PROCEDURE `통계` (
	out countSt Int,
    out countPr Int,
    out countSb Int
)
BEGIN
	select count(*) into countSt from 학생; -- countSt 변수가 count(*) 수행한다고 생각
    select count(*) into countPr from 교수;
    select count(*) into countSb from 수강신청내역;
    
END;
//
delimiter ;
-- 프로시저 테스트
CALL 통계(@countSt, @countPr, @countSb); -- 프로시저 호출하고 매개변수 전달
SELECT @countSt as 학생수, @countPr as 교수수, @countSb as 과목수;

-- 수강신청내역 테이블에서 과목별로 수강자 수를 반환하는 저장 프로시저를 작성
use db0221;
delimiter //
CREATE PROCEDURE `과목수강자수` (
    in p과목번호 char(6),
	out 수강자수 Int
)
BEGIN
	select count(과목번호)
    into 수강자수
    from 수강신청내역
    where 과목번호=p과목번호; -- 이해 잘 안되는데... 다시 생각해볼것. 수강자수 변수가 count(과목번호) 연산 수행하는데, where 조건에 한 하여 수행. 조건 의미는 p과목번호(파라미터로 줄 값)이 과목번호랑 일치는 것에 대하여 count하는 것임
END;
//
delimiter ;

-- 프로시저 테스트
CALL 과목수강자수('k20002', @수강자수); -- 프로시저 호출하고 매개변수 전달
SELECT @수강자수 as 수강자수;

use db0221;
delimiter //
CREATE PROCEDURE `새수강신청` (
    in p학번 char(7), -- 파라미터
	out p수강신청번호 Int
)
BEGIN
	select max(수강신청번호) into p수강신청번호 from 수강신청;
	set p수강신청번호=p.수강신청번호 + 1;
	insert into 수강신청(수강신청번호, 학번, 날짜, 연도, 학기) values(p,수강신청번호, p학번); -- 날짜연도학기 미완성
END;
//
delimiter ;

-- 커서 프로시저 
delimiter //
CREATE PROCEDURE Interest()
BEGIN
DECLARE myInterest INTEGER DEFAULT 0.0; 
DECLARE Price INTEGER; 
DECLARE endOfRow BOOLEAN DEFAULT FALSE; 
DECLARE InterestCursor CURSOR FOR SELECT salesprice FROM Orders; 
DECLARE CONTINUE handler FOR NOT FOUND SET endOfRow=TRUE; 
OPEN InterestCursor; 
cursor_loop: LOOP FETCH InterestCursor INTO Price; 
IF endOfRow THEN LEAVE cursor_loop; 
END IF; 
IF Price >= 30000 THEN SET myInterest = myInterest + Price * 0.1; 
ELSE SET myInterest = myInterest + Price * 0.05; END IF; 
END LOOP cursor_loop; 
CLOSE InterestCursor; 
SELECT CONCAT(' 전체 이익 금액 = ', myInterest); END; 
// delimiter ;
/* Interest 프로시저를 실행하여 판매된 도서에 대한 이익금을 계산 */ 
CALL Interest();


-- 트리거
CREATE TABLE Book_log(
bookid_l INTEGER,
bookname_l VARCHAR(40),
publisher_l VARCHAR(40),
price_l INTEGER);

delimiter //
CREATE TRIGGER AfterInsertBook
AFTER INSERT ON Book FOR EACH ROW
BEGIN
DECLARE average INTEGER;
INSERT INTO Book_log
VALUES(new.bookid, new.bookname, new.publisher, new.price);
END;
// delimiter ;

/* 삽입한 내용을 기록하는 트리거 확인 */
 INSERT INTO Book VALUES(16, '스포츠 과학 1', '이상미디어', 25000);
 
 SELECT *
 FROM Book 
 WHERE BOOKID=16; 
 
 SELECT *
 FROM Book_log 
 WHERE BOOKID_L='16'; -- 결과 확인. 삽입할 때마다 book_log 테이블에 해당내용 삽입





    