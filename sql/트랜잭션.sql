-- 트랜잭션
commit;
rollback; -- 원상복귀
select @@autocommit; -- @는 at이라는 의미
set autocommit = 1;
set autocommit = 0; -- 오토커밋 값 변경
select @@autocommit; -- @1이면 활성 상태, 0이면 비활성 / 활성 상태면 바로바로 반영, 비활성이면 수동으로 반영해야함


create table book1 (select * from book);
create table book2 (select * from book);

delete from book1;
rollback; -- 오토커밋이 1이면 롤백해도 삭제된 데이터 복구 안됨. 하지만 0일 때는 롤백 가능. 즉 0이면 commit하기 전까지 롤백가능
commit;
select * from book1;
select * from book2;

-- 커밋과 롤백을 하면 하나의 단위 작업이 끝난다는 의미

-- 오토커밋 1인 상태에서 트랜잭션 실행
start transaction;
delete from book1;
delete from book2;
rollback;

