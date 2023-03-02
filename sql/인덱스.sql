-- 테이블의 인덱스 정보 확인
show index from dept_emp;

-- 테이블과 관련된 정보 조회
show table status like 'dept_emp'; 
-- index_length 열은 기본키를 제외한 색인을 저장하는 페이지 수에 페이지 크기를 곱한 결과로 바이트 수이다

-- dept_emp 테이블에 설정된 색인을 삭제
-- 외래키 설정과 dept_emp 열에 설정된 색인만 삭제
alter table dept_emp drop foreign key dept_emp_ibfk_1;
alter table dept_emp drop foreign key dept_emp_ibfk_2;
drop index dept_no on dept_emp;

analyze table dept_emp;
show index from dept_emp;

alter table dept_emp drop primary key;

-- 테이블에서 첫번째 행의 데이터 조회
select * from dept_emp order by emp_no asc limit 1;

-- 테이블에서 마지막 행의 데이터 조회
select * from dept_emp order by emp_no desc limit 1; 

-- 첫 번째 행과 마지막 행의 실행계획 결과? full scan. 첫번째, 마지막 거 어느 것 검색해도 다 검색
select count(*) from dept_emp;
explain select * from dept_emp where emp_no = 10010;
explain select * from dept_emp where emp_no = 499999;

-- 모두 삭제한 색인 중 기본키 다시 설정
alter table dept_emp add primary key (emp_no,dept_no);
explain select * from dept_emp where emp_no = 10010;
explain select * from dept_emp where emp_no = 499999; -- row값이 1만 나온다. 효율성이 좋아짐. 결국 인덱스를 만드는 이유는 효율성 때문에.

select count(*) from dept_emp where dept_no = 'd006';
explain select * from dept_emp where dept_no = 'd006';

-- 인덱스 생성
create index dept_emp on dept_emp(dept_no);
explain select * from dept_emp where dept_no = 'd006';

-- 하나의 테이블에 많은 인덱스를 생성하면 insert, update 및 delete 하는 시간이 많이 소요됨
-- 검색 조건과 색인 생성을 조화롭게 해야함


select * from dept_emp where dept_no = 'd006' and from_date = '1996-11-24';
explain select * from dept_emp where dept_no = 'd006'and from_date = '1996-11-24';

-- 색인 컬럼으로 다시 지정
create index from_date on dept_emp(from_date);
explain select * from dept_emp where dept_no = 'd006'and from_date = '1996-11-24'; -- rows 수가 확연히 줄어든다


-- dept_emp 테이블과 employees 테이블을 조인하는 경우
-- 색인 설정 여부에 따라 실행 계획의 차이를 확인하기 위해 다음의 쿼리문을 실행
-- 두 개의 테이블에 설정된 모든 색인 삭제
-- 삭제 후 analyze해서 재구성
alter table dept_emp drop primary key;
alter table dept_emp drop index dept_emp;
alter table dept_emp drop index from_date;
analyze table dept_emp;

alter table dept_manager drop foreign key dept_manager_ibfk_1;
alter table titles drop foreign key titles_ibfk_1;
alter table employees drop primary key;
analyze table employees, dept_emp;

explain select a.emp_no, b.first_name, b.last_name
from dept_emp a inner join employees b
on a.emp_no = b.emp_no
where a.emp_no = 10001;

alter table employees add primary key (emp_no);
alter table dept_emp add primary key (emp_no, dept_no);

-- 삽입 삭제 업뎃 빈번하면 색인 안 넣는게 나을 수도
