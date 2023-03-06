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

create table deal_log( -- 필요 없는듯
l상품코드 varchar(6),
l상품명 varchar(30),
l제조사 varchar(30),
l소비자가격 int,
l재고수량 int
);

delimiter //
create trigger AfterInsert
After insert on 입고 for each row
begin

insert into deal_log values(new.상품코드, new.상품명, new.제조사, new.소비자가격);

end;
//
delimiter ;

