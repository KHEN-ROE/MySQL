-- 상품 테이블 작성
CREATE TABLE 상품 (상품코드 VARCHAR(6) NOT NULL PRIMARY KEY, 상품명 VARCHAR(30)  NOT NULL, 제조사 VARCHAR(30) NOT NULL, 소비자가격  INT, 재고수량  INT DEFAULT 0);

-- 입고 테이블 작성
CREATE TABLE 입고 (입고번호 INT PRIMARY KEY, 상품코드 VARCHAR(6) NOT NULL REFERENCES 상품(상품코드), 입고일자 DATE,입고수량 INT,입고단가 INT);

-- 판매 테이블 작성
CREATE TABLE 판매 (판매번호 INT  PRIMARY KEY,상품코드  VARCHAR(6) NOT NULL REFERENCES 상품(상품코드), 판매일자 DATE,판매수량 INT,판매단가 INT);

-- 상품 테이블에 자료 추가
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES ('AAAAAA', '디카', '삼싱', 100000);
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES ('BBBBBB', '컴퓨터', '엘디', 1500000);
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES ('CCCCCC', '모니터', '삼싱', 600000);
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES ('DDDDDD', '핸드폰', '다우', 500000);
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES ('EEEEEE', '프린터', '삼싱', 200000);

-- 상품이 입고되면 재고수량이 수정되는 트리거
delimiter //
create trigger wheninput
after insert on 입고 for each row
begin
	update 상품
    set 재고수량 = 재고수량 + new.입고수량
    where 상품코드 = new.상품코드;
end;
//
delimiter ;

insert into 입고(입고번호, 상품코드, 입고일자, 입고수량, 입고단가) values(1, 'AAAAAA', '2023-03-07', 1, 5000);
select * from 입고;
select * from 상품;

-- 상품이 판매되면 재고수량이 변경되는 트리거
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

-- 입고 테이블에 수량이 수정되면 상품 테이블에 상품의 재고수량이 수정되는 트리거
delimiter //
create trigger afterUpdate
after update on 입고 for each row
begin
	update 상품
    set 재고수량 = new.입고수량 
    where 상품코드 = new.상품코드;
end;
//
delimiter ;

update 입고 set 입고수량=30 where 입고번호=1;

-- 입고 테이블에서 삭제(취소)하면 상품 테이블에서 재고수량 수정하는 트리거 afterDelete
delimiter //
create trigger afterDelete
after Delete on 입고 for each row
begin
	update 상품
    set 재고수량 = 재고수량 - old.입고수량
	where 상품코드 = old.상품코드;
end;
//
delimiter ;

delete from 입고 where 입고번호='1'; -- 상품코드로는 지울 수가 없다. 중복될 수 있으므로
select * from 상품;

-- 밑에 두 문제는 평가 과제. 업로드 해야함
-- 판매 테이블에 자료가 추가되면 상품 테이블에 상품의 재고수량이 변경되는 트리거 beforeinsert 판매
delimiter //
create trigger beforeInsert
before insert on 판매 for each row
begin
	update 상품
	set 재고수량 = 재고수량 - new.판매수량
	where 상품코드 = new.상품코드;
end;
//
delimiter ;

-- 판매 테이블에 자료가 변경되면 상품 테이블에 상품의 재고수량이 변경되는 트리거 beforeupdate 판매
delimiter //
create trigger beforeUpdate1
before update on 판매 for each row
begin
	update 상품
	set 재고수량 = 재고수량 - new.판매수량
	where 상품코드 = new.상품코드;
end;
//
delimiter ;

insert into 판매(판매번호, 상품코드, 판매일자, 판매수량, 판매단가) values(1, 'AAAAAA', '2023-03-07', 1, 10000);
update 상품 set 재고수량 = 30 where 상품코드='AAAAAA';
update 판매 set 판매수량 =5 where 상품코드='AAAAAA';
select * from 판매;
delete from 판매;
select * from 상품;