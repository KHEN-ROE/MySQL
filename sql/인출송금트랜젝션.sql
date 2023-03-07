
create table account (
	accNum char(10) primary key,
    amount int not null default 0
    );
    
    insert into account values ('A', 45000);
    insert into account values ('B', 100000);
    
    select * from account;
    
    -- A 계좌에서 4만원 빼서 B 계좌로 넣으려면?
    start transaction;
    update account
    set amount = amount - 40000
    where accNum = 'A';
    
    update account
    set amount = amount + 40000
    where accNum = 'B';
    rollback;
    commit;
    
    -- 프로시저, 트랜잭션, 트리거까지 한번에 만드는 예제 -- 집가서 다시 해볼 것
    -- 트리거 작성. 인출 금액보다 잔액이 적으면 인출이 안되는 트리거. beforeUpdate
    delimiter //
    create trigger beforeUpdate
    before Update on account for each row
    begin
		if (new.amount<0) then -- new, old 가 의미하는 게 뭔지 다시 공부할 것...  좌변이 new.amount, 우변이 old.amount. 그래서 new.amount 가 0 보다 작으면 예외처리
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '잔액부족.';
       end if;
    end;
    //
    delimiter ;
    DROP TRIGGER IF EXISTS beforeUpdate;
    
  select * from account;
  
  update account
  set amount = amount - 40000 -- 좌변이 new.amount, 우변이 old.amount.
  where accNum = 'A';
    
    
    delimiter //
    create procedure account_transaction (
    in sender char(15), -- 파라미터
    in recip char(15),
    in _amount int
    )
    begin
		declare exit handler for sqlexception rollback; -- 트리거에 의해 예외 발생시 롤백 됨
        start transaction;
        update account
        set amount = amount - _amount
        where accNum = sender;
        
        update account
        set amount = amount + _amount
        where accNum = recip;
        commit;
    end;
    //
 delimiter ;
 
 -- 호출해볼 것
call account_transaction('A', 'B', 3000); -- amount가 0이 되면 트리거에 의해 예외처리되고, 프로시저로 와서 롤백됨  
select * from account;