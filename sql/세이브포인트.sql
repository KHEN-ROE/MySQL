start transaction;
savepoint A;
delete from book1;
savepoint B;
delete from book2;
rollback to savepoint b; -- 세이브포인트 b까지만 롤백 
commit;

select * from book1;
select * from book2;
