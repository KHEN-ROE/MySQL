Select *
From book
Where publisher in('굿스포츠','대한미디어');

Select *
From book
Where publisher not in('굿스포츠', '대한미디어'); 

select bookname, publisher
from book
where bookname like '축구의 역사'; 

select bookname, publisher
from book
where bookname = '축구의 역사';

select bookname, publisher
from book
where bookname in ('축구의 역사');

select bookname, publisher
from book
where bookname like '%축구%';

select *
from book
where bookname like '%구%';

select *
from book
where bookname like '_구%';

select *
from book
where publisher = '굿스포츠' or publisher= '대한미디어';

select *
from book
where bookname like '%축구%' and price >= 20000;

-- 도서를 이름순으로 검색
select *
from book
order by bookname;

-- 도서를 가격순으로 검색, 가격 같으면 이름순으로 검색
select *
from book
order by price, bookname; 

-- 도서를 갸격의 내림차순으로 검색. 만약 가격 같다면 출판사의 오름차순으로 검색
select *
from book
order by price desc, publisher asc; 

-- 집게 함수
-- 고객이 주문한 도서의 총 판매액을 구하라
select sum(salesprice) as revenue
from orders;

-- 2번 김연아 고객이 주문한 도서의 총 판매액
select sum(salesprice) as 김연아구매액
from orders
where custid = 2; 

-- 고객이 주문한 도서의 총 판매액, 평균값, 최저가, 최고가 구하기
select sum(salesprice) as total, round(avg(salesprice), 0) as average, min(salesprice) as minimum, max(salesprice) as maximum
from orders ;

-- 마당서점의 도서 판매 건수 구하기
select count(*)
from orders;

-- 고객별로 주문한 도서의 총 수량과 총 판매액 구하기 + 소계(roll up)
select custid, count(*) as 도서수량, sum(salesprice) as 총판매액
from orders
group by custid with rollup;

-- 가격이 8,000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총수량을 구하라(단, 두권 이상 구매한 고객만 구함)
select custid, count(*) as 구매수량
from orders
where salesprice >= 8000
group by custid
having count(*) >= 2;

-- 조인 : 고객과 고객의 주문에 관한 데이터를 모두 보여라. 일반적인 조인 - 같은 것 끼리만 합침
-- 조인할 때  select 명에 필드명 적을 때 테이블명.필드명 이렇게 써야함. 중복을 구분하기 위함임. 안써도 실행은 됨
select *
from customer, orders
where customer.custid = orders.custid
order by customer.custid;

-- 고객의 이름과 고객이 주문한 도서의 판매가격을 검색
select name, sum(salesprice)
from customer, orders
where customer.custid = orders.custid
group by customer.name
order by customer.name; 

-- 고객의 이름과 고객이 주문한 도서의 이름 구하기
select customer.name, book.bookname
from customer, orders, book
where customer.custid = orders.custid and orders.bookid = book.bookid; -- 일단 다 연결해놓고 select에 있는거 두개만 끄집어내라

-- 가격이 20,000원인 도서를 구문한 고객의 이름과 도서의 이름 구하기
select customer.name, book.bookname
from customer, orders, book
where customer.custid = orders.custid and orders.bookid = book.bookid and book.price = 20000; -- 조인의 조건?

-- 도서를 구매하지 않은 고객을 포함하여 고객의 이름과 고객이 주문한 도서의 판매가격 구하기
select customer.name, salesprice
from customer left outer join orders on customer.custid = orders.custid; -- customer 쪽은 다 뿌림. left에서 일치안하는 것도 뿌려야함. 그래서 박세리는 null로 나옴

-- 도서를 한번도 주문하지 않은 고객 구하기
select customer.name, salesprice
from customer left outer join orders on customer.custid = orders.custid
where salesprice is null;

-- 부속질의(서브쿼리 - 쿼리 안에 쿼리)
-- 가장 비싼 도서의 이름을 보이시오
select bookname
from book
where price = (select max(price) from book); -- 우변이 쿼리 1, 좌변이 쿼리 2. 우변을 연산해서 좌변에 대입

-- 도서를 구매한 적이 있는 고객의 이름 검색
select name
from customer
where custid in(select custid from orders);
-- 이걸 조인으로 바꾸면? 중복제거할것
select name
from customer left outer join orders on customer.custid = orders.custid
where salesprice is not null;


-- 대한미디어에서 출판한 도서를 구매한 고객의 이름 검색
select name
from customer
where custid in(select custid from orders where bookid in(select bookid from book where publisher='대한미디어'));
-- 이걸 조인으로 바꾸면?
select customer.name
from customer, orders, book
where customer.custid = orders.custid and orders.bookid = book.bookid and publisher = '대한미디어';

-- 합집합 union, 차집합 minus, 교집합 intersect
-- 대한민국에서 거주하는 고객의 이름과 도서를 주문한 고객의 이름 검색
select name
from customer
where address like '대한민국%'
union
select name
from customer
where custid in (select custid from orders);

-- MySQL에서는 minus, intersect 연산자가 없으므로 다음과 같이 표현
-- 대한민국에서 거주하는 고객의 이름에서 도서를 주문한 고객의 이름 빼고 검색 - not in 연산자 사용
select name
from customer
where address like'대한민국%' and name not in(select name from customer where custid in(select custid from orders));

-- 대한민국에서 거주하는 고객 중 도서를 주문한 고객 이름 검색
select name
from customer
where address like '대한민국%' and name in (select name from customer where custid in(select custid from orders));