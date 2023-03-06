-- 상품 테이블 작성
CREATE TABLE 상품 (
   상품코드 VARCHAR(6) NOT NULL PRIMARY KEY,
   상품명 VARCHAR(30)  NOT NULL,
   제조사  VARCHAR(30)  NOT NULL,
   소비자가격  integer,
   재고수량     integer DEFAULT 0
);

-- 입고 테이블 작성
CREATE TABLE 입고 (
   입고번호      integer PRIMARY KEY,
   상품코드      VARCHAR(6) NOT NULL,
   입고일자      DATE,
   입고수량      integer,
   입고단가      integer
);

-- 판매 테이블 작성
CREATE TABLE 판매 (
   판매번호      integer  PRIMARY KEY
  ,상품코드      VARCHAR(6) NOT NULL
  ,판매일자      DATE
  ,판매수량      integer
  ,판매단가      integer
);

-- 상품 테이블에 자료 추가
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES
        ('AAAAAA', '디카', '삼싱', 100000);
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES
        ('BBBBBB', '컴퓨터', '엘디', 1500000);
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES
        ('CCCCCC', '모니터', '삼싱', 600000);
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES
        ('DDDDDD', '핸드폰', '다우', 500000);
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES
         ('EEEEEE', '프린터', '삼싱', 200000);
COMMIT;
SELECT * FROM 상품;
-- 삽입 삭제 와 재고를 연동시킨다. 입고수량이 변화하면 상품정보의 재고수량에 반영.
-- 판매되면 판매수량 만큼 재고의 변화생겨야함


delimiter //
create trigger wheninput
After insert on 입고 for each row
begin
	update 상품
    set 재고수량 = 재고수량 + new.입고수량
    where 상품코드 = new.상품코드;
end;
//
delimiter ;

insert into 입고(입고번호, 상품코드, 입고일자, 입고수량, 입고단가) values(5, 'CCCCCC', '2023-03-06', 1, 5000);
select *
from 입고;

select *
from 상품;

delimiter //
create trigger whenoutput
after insert on 판매 for each row
begin
	update 상품
	set 재고수량 = 재고수량 - new.판매수량
	where 상품코드 = new.상품코드;
end;
//
delimiter ;

insert into 판매(판매번호, 상품코드, 판매일자, 판매수량, 판매단가) values(2, 'CCCCCC', '2023-03-06', 1, 10000);
select * from 판매;
select * from 상품;

-- 방금한거 안보고 다시 쳐보기
delimiter //
create trigger input1
after insert on 입고 for each row
begin
	update 상품
    set 재고수량 = 재고수량 + new.입고수량
    where 상품코드 = new.상품코드;
end;
// 
delimiter ;

delimiter //
create trigger output1
after insert on 판매 for each row
begin
	update 상품 -- 상품 테이블을 업데이트 할껀데
	set 재고수량 = 재고수량 - new.판매수량 -- 상품테이블의 재고수량 필드를 이렇게 바꾸겠다.
    where 상품코드 = new.상품코드; -- 어떤 조건일 때? 테이블의 상품코드와 새로 삽입된 상품코드가 같으면
end;
//
delimiter ;

