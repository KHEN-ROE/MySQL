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
