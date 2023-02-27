alter table orders drop primary key;

show index from orders;

alter table orders add primary key(ordersid);

show index from orders;

SELECT *
from orders;

-- 평균 금액 구하기
select custid '고객번호', round(sum(salesprice)/count(*),-2) '평균금액'
from orders
group by custid;

-- 야구를 농구로 바꾸기
select bookid, replace(bookname, '야구','농구') bookname, publisher, price
from book;

-- length : 글자의 수를 세어주는 함수(단위가 바이트가 아닌 문자 단위
-- 굿스포츠에서 출판한 도서의 제목과 제목의 글자 수를 확인
select bookname '제목', char_length(bookname) '문자수', length(bookname) '바이트 수'
from book
where publisher='굿스포츠';

-- 같은 성을 가진 사람 수 구하기
select substr(name, 1, 1) '성', count(*)'인원'
from customer
group by substr(name, 1, 1);

-- 예제 4-7 마당서점은 주문일로부터 10일 후 매출을 확정한다. 각 주문의 확정일자를 구하라
select ordersid '주문번호', orderdate '주문일', adddate(orderdate, interval 10 day) '확정'
from orders;

-- str_to_date : 문자형 날짜를 날짜형으로 변환
-- date_format : 날짜형을 문자형으로 변환
-- 예제 4-8. 2014년 7월 7일에 주문받은 도서의 주문번호, 주문일, 고객번호, 도서번호 모두 출력 주문일은 %Y-%m-%d 로 표현
select ordersid'주문번호',str_to_date(orderdate, '%Y-%m-%d')'주문일', custid'고객번호',bookid'도서번호'
from orders
where orderdate=date_format('20140707', '%Y%m%d');

-- sysdate : mysql의 현재 날짜와 시간 반환
-- dbms 서버에 설정된 현재 날짜와 시간, 요일 출력
select sysdate(), date_format(sysdate(), '%Y/%m/%d %M % h:%s')'sysdate_1';

-- 예제4-10 : 이름, 전화번호가 포함된 고객목록 출력. 단 전화번호가 없는 고객은 연락처없음으로 표시
select name'이름',ifnull(phone, '연락처없음')'전화번호'
from customer;

-- 예제 4-11
set @seq:=0;
select (@seq:=@seq+1) '순번' ,custid, name, phone
from customer
where @seq <2; -- 답 안나오는데 나중에 다시

-- 스칼라 부속질의
select custid, (select name from customer cs where cs.custid=od.custid), sum(salesprice)
from orders od
group by custid;
-- 이걸 조인쿼리로 바꾸면?
select (select name from customer cs where cs.custid=od.custid) name, sum(salesprice)
from orders od
group by od.custid;
-- 조인쿼리
select name, sum(salesprice) total
from customer cs, orders od
where cs.custid = od.custid
group by od.custid;

-- 예제4-14
select cs.name, sum(od.salesprice) 'total'
from (select custid, name from customer where custid <= 2) cs, orders od
where cs.custid=od.custid
group by cs.name;

-- 예제4-15
-- 평균 주문금액 이하의 주문에 대해서 주문번호와 금액 출력
select ordersid, salesprice
from orders
where salesprice <= (select avg(salesprice) from orders);

-- 예제4-16
-- 각 고객의 평균 주문금액보다 큰 금액의 주문 내역에 대해 주문번호, 고객번호, 금액 출력
select ordersid, custid, salesprice
from orders od
where salesprice > (select avg(salesprice) from orders so where od.custid=so.custid);

--  예제4-17
-- 대한민국에 거주하는 고객에게  판매한 도서의 총판매액
select sum(salesprice) 'total'
from orders
where custid in (select custid from customer where address like '%대한민국%');
-- 서브쿼리만 보면 
select custid from customer where address like '%대한민국%'; -- custid 2,3,5가 대한민국 데이터를 가지고 있다

-- 3번 고객이 주문한 도서의 최고 금액보다 더 비싼 도서를 구입한 주문의 주문번호와 금액 출력
select ordersid, salesprice
from orders
where salesprice > all (select salesprice from orders where custid='3');
-- 서브쿼리만 보면
select salesprice from orders where custid='3';
-- 모든 판매가격
select salesprice from orders;

-- 예제 4-19
-- exists 연산자로 대한민국에 거주하는 고객에게  판매한 도서의 총 판매액을 구하라
select sum(salesprice) 'total'
from orders od
where exists (select * from customer cs where address like '%대한민국%' and cs.custid = od.custid);
-- 서브쿼리만 보면
select * from customer, orders where address like '%대한민국%' and customer.custid = orders.custid;

-- book 릴레이션에서 축구만 보여주는 view. view는 필요한 것만(자주쓰는) 골라서 보여준다.
create view vw_Book
as select  *
from book
where bookname like '%축구%';

-- 예제4-21 orders Orders 테이블에 고객이름과 도서이름을 바로 확인할 수 있는 뷰를 생성한 후, ‘김연아’ 고객이 구입한 도서의 주문번호, 도서이름, 주문액을 보이시오.
-- 명령어가 너무 길고 다시 만들기 번거로우니 view 로 만든다.
create view vw_orders (orderid, custid, name, bookid, bookname, salesprice, orderdate)
as select od.ordersid, od.custid, cs.name, od.bookid, bk.bookname, od.salesprice, od.orderdate
FROM Orders od, Customer cs, Book bk
WHERE od.custid =cs.custid AND od.bookid =bk.bookid;
-- 결과확인
select *
from vw_orders;

CREATE VIEW vw_Customer
AS SELECT *
FROM Customer
WHERE address LIKE '%대한민국%';
-- 질의 4-22 [질의 4-20]에서 생성한 뷰 vw_Customer는 주소가 대한민국인 고객을 보여준다. 이 뷰를 영국을 주소로 가진 고객으로 변경하시오. phone 속성은 필요 없으므로 포함시키지 마시오.
create or replace view vw_custormer(custid, name, address)
as select custid, name, address
from customer
where address like '%영국%';



