-- 1.<학생> 테이블에 저장되어 있는 모든 학생의 이름을 가져오는 SQL문을 작성하시오.
select *
from 학생;

-- 2.<교수> 테이블에 저장되어 있는 모든 교수의 이름과 전화번호를 가져오는 SQL문을 작성하시오.
select 이름, 전화번호
from 교수;

-- 3.<수강신청> 테이블의 모든 내용을 가져오는 SQL문을 작성하시오.
select *
from 수강신청;

-- 4.<학생> 테이블에 저장되어 있는 학생 중 2018학년 1학기에 수강신청을 하지 않은 학생의 이름을 찾으시오 
select distinct(이름)
from 학생, 수강신청
where 학생.학번 != 수강신청.학번 and 수강신청.연도 = 2018 and 수강신청.학기=1;

-- or (교수님 코드)
select 이름
from 학생
where 이름 not in(select 학생.이름 from 학생 inner join 수강신청 on 학생.학번=수강신청.학번 where 연도='2018' and 학기='1'); -- 학생.학번=수강신청.학번이 동일 한 학생들은 2018년 1학기에 신청을 했다는 뜻. 그래서 이들을 제외(not in) 

--  5.이름이 ‘김민준’인 학생이 2018학년도 1학기에 수강 신청한 과목명을 검색하시오
select distinct(과목명)
from 학생, 과목, 수강신청, 수강신청내역
where 학생.학번 = 수강신청.학번 and 수강신청.수강신청번호 = 수강신청내역.수강신청번호 and 학생.학번 = 1801001 and 수강신청.연도 = 2018 and 수강신청.학기 = 1;

-- or (교수님 코드)
select 과목명
from 학생, 수강신청, 수강신청내역, 과목
where 학생.학번=수강신청.학번 and 수강신청.수강신청번호 = 수강신청내역.수강신청번호 and 수강신청내역.과목번호 = 과목.과목번호 and 학생.이름='김민준' and 수강신청.연도 = 2018 and 수강신청.학기 = 1; -- 여기서 학생.이름 대신 학생.학번해도 됨

-- 6.<학생> 테이블의 ‘이름’ 필드를 오름차순으로 정렬하여 출력하는 SQL문을 작성하시오.
select 이름
from 학생
order by 이름 asc;

-- 7.<학생> 테이블의 ‘시도’ 와 ‘이름’ 필드의 데이터를 가져와서 ‘시도’, ‘이름’ 순서로 오름차순으로 정렬하는 SQL문을 작성하시오
select 시도, 이름
from 학생
order by 시도 asc, 이름 asc;

-- 8.<학생> 테이블의 ‘시도’ 는 내림차순으로 ‘이름’ 은 오름차순으로 정렬하는 SQL문을 작성하시오
select 시도, 이름
from 학생
order by 시도 desc, 이름 asc;

-- 9.<학생> 테이블의 ‘시도’ 와 ‘이름’ 필드의 데이터를 가져와서 ‘시도’, ‘이름’ 순서로 내림차순으로 정렬하는 SQL문을 작성하시오
select 시도, 이름
from 학생
order by 시도 desc, 이름 desc;

-- 10.<수강신청> 테이블에서 '학번' 필드가 '1801001'인 레코드의 '수강신청번호', '학번', '날짜'를 읽어오는 SQL문을 작성하시오
select 수강신청번호, 수강신청.학번, 날짜
from 학생, 수강신청
where 학생.학번 = 수강신청.학번 and 학생.학번 = 1801001;

-- 11.<수강신청> 테이블에서 '날짜'가 '2018-01-01’ 이전에 수강 신청한 레코드의 '수강신청번호', 학번', '날짜'를 읽어오는 SQL문을 작성하시오.
select 수강신청번호, 학번, 날짜
from 수강신청
where 연도 < 2018;

-- 12 <과목> 테이블에서 '시수'가 1, 2, 3인 레코드의 '과목번호', '과목', '시수'를 읽어오는 SQL문을 작성하시오.
select 과목번호, 과목명, 시수
from 과목
where 시수=1 or 시수=2 or 시수=3;

-- 13 <교수> 테이블에서 '전화번호' 필드(열)의 값이 없는 레코드의 '이름'과 '학과'을 읽어오는 SQL문을 작성하시오.
select 이름, 학과
from 교수
where 전화번호 is null;

-- 14 <수강신청> 테이블에서 날짜가 ‘2018-01-01’와 ‘2018-07-31’ 사이 수강신청한 레코드의 ‘학번’, ‘날짜’를 읽어오는 SQL문을 작성하시오.
select 학번, 날짜
from 수강신청
where 날짜 >= '2018-01-01' AND 날짜 < '2018-07-31';

-- 15 <교수> 테이블에서 '전화번호'가 있는 교수의 '이름'과 ‘전자우편', ‘전화번호’를 읽어오는 SQL문을 작성하시오.
select 이름, 전자우편, 전화번호
from 교수
where 전화번호 is not null;

-- 16 <수강신청> 테이블에서 '학번'이 1601001'이고 '연도'가 2016'인 데이터를 가져오는 SQL문을 작성하시오.
select 수강신청번호, 학번, 날짜, 연도, 학기
from 수강신청
where 학번 = 1601001 and 연도 = 2016;

-- 17 <수강신청> 테이블에서 '학번'이 1601002'번과 1801002번인 학생의 수강신청 데이터를 가져오는 SQL문을 작성하시오.
select 수강신청번호, 학번, 날짜, 연도, 학기
from 수강신청
where 학번 = 1601002 or 학번 = 1801002;

-- 18 <수강신청 > 테이블에서 '1601001'와 '1601002' 번인 학생의 '2016' 년도 수강신청 데이터를 가져오는 SQL문을 작성하시오.
select 수강신청번호, 학번, 날짜, 연도, 학기
from 수강신청
where 학번 = 1601001 and 연도 = 2016 or 학번 = 1601002 and 연도 = 2016;

-- 19 <수강신청> 테이블에서 '1601001'와 '1601002' 번인 학생의 수강신청 데이터를 가져오는 SQL문을 IN 연산자를 이용하여 작성하시오
select 수강신청번호, 학번, 날짜, 연도, 학기
from 수강신청
where 학번 in (1601001,1601002);

-- 20 <수강신청> 테이블에서 '1601001' 학생을 제외한 모든 학생의 수강신청 데이터를 가져오는 SQL문을 작성하시오
select 수강신청번호, 학번, 날짜, 연도, 학기
from 수강신청
where 학번 not in (1601001);

-- 21 <교수> 테이블에서 '김'씨 성을 가진 교수의 자료를 검색하는 SQL문을 작성하시오.
select *
from 교수
where 이름 like '김%';

-- 22 <학과> 테이블에서 학과 이름에 '공학'이 포함되어 있는 학과의 정보를 검색하는 SQL문을 작성하시오.
select *
from 학과
where 학과명 like '%공학%';

-- 23 <과목> 테이블에서 과목의 영문 이름이 'C'로 시작하여 ‘e’입으로 끝나는 과목의 '과목번호', '과목명', '영문명'을 가져오는 SQL문을 작성하시오.
select *
from 과목
where 영문명 like 'C%e';

-- 24 <학생> 테이블에서 학생 이름이 '○○준'과 같은 이름을 가진 학생의 자료를 가져오는 SQL문을 작성하시오.
select *
from 학생
where 이름 like '%준';

-- 25 <수강신청내역> 테이블에서 '과목번호'가 'K20045'이거나 'K20056'이고 평점'이 3인 레코드의 '수강신청번호', '과목번호', '평점'을 가져오는 SQL문을 작성하시오.
select 수강신청번호, 과목번호, 평점
from 수강신청내역
where 과목번호 = ('K20045' or 과목번호 = 'K20056') and 평점 =3;

-- 26 <수강신청내역> 테이블에서 '과목번호'가 'K20045’, ‘K20056’, ‘Y00132' 인 과목의 '수강신청번호', '과목번호', '평점'을 가져오는 SQL문을 IN 연산자를 이용하여 작성하시오. '과목번호' 필드를 기준으로 오름차순으로 정렬하시오.
select 수강신청번호, 과목번호, 평점
from 수강신청내역
where 과목번호 in ('k20045','k20056','y00132')
order by 과목번호;

-- 27 <수강신청내역> 테이블에서 '평점'이 -1이 아닌 레코드의 자료를 가져오는 SQL문을 작성하시오.
select *
from 수강신청내역 
where 평점 != -1;

-- 28 <학생> 테이블에서 18학번 학생들의 '학번', '이름', '시도'을 가져오는 SQL문을 작성하시오.
select 학번, 이름, 시도
from 학생
where 학번 like '18%';

-- 29 〈학생〉 테이블에서 주소 중에 시군구' 필드가 '구'로 끝나는 학생들의 ‘학번’, '이름', '시도', 시군구'를 가져오는 SQL문을 작성하시오.
select 학번, 이름, 시도, 시군구
from 학생
where 시군구 like '%구%';

-- 30 <과목> 테이블에서 '영문명'이 'I'로 시작하여 'n'으로 끝나는 과목의 '과목번호, ’과목명', '영문명'을 가져오는 SQL문을 작성하시오
select 과목번호, 과목명, 영문명
from 과목
where 영문명 like 'I%n';

-- 31 <과목> 테이블에서 '과목명'이 ‘컴퓨터ㅇㅇ'와 같은 이름을 가진 과목의 '과목번호', '과목', '영문명'을 가져오는 SQL문을 작성하시오
select 과목번호, 과목명, 영문명
from 과목
where 과목명 like '컴퓨터__';

-- 32 <학생> 테이블에서 학생의 이름에 '서'자가 들어가는 학생의 '학번', '학과'. '이름’, ‘시도'를 가져오는 SQL문을 작성하시오.
select 학번, 학과, 이름, 시도
from 학생
where 이름 like '%서%';

-- 33 <학생> 테이블에서 '이름', '주소’, ‘시군구', '시도', '우편번호의 정보를 묶어서 아래와 같이 하나의 필드처럼 보이도록 가져오는 SQL문을 작성하시오. (묶은 필드의 이름은 '학생정보'로 출력한다. '이름'으로 정렬하시오.)
select concat(이름, '(', 주소, 시군구, 시도,')') as 학생정보
from 학생
order by 이름;

-- 34 <과목> 테이블에서 '과목명', '담당교수' 필드를 가져와서 '담당교수' 필드의 별명을 담당교수사번'으로 바꾸어 출력하는 SQL문을 작성하시오. 
select 과목명, 담당교수 as 담당교수사번
from 과목;

-- 35 <수강신청> 테이블에서 아래와 같이 '학번'이 '1801001'인 학생의 수강신청 자료를 출력하도록 SQL문을 작성하시오. 
select 수강신청번호, concat(연도, '학년도', 학기,'학기') as 신청학년도
from 수강신청
where 학번 = 1801001;

-- 36 〈학생〉 테이블에서 '학번'과 '이름', 그리고 이름 중 성씨만 가져오는 SQL문을 작성하시오. 
select 학번, 이름, left(이름,1) as 성
from 학생;

-- 37 〈학생〉 테이블에서 16학번인 학생의 학번과 이름, 학년을 가져오는 SQL문을 작성하시오. 
select 학번, 이름, 학년
from 학생
where 학번 like '16%';

-- 38 <수강신청> 테이블에서 컴퓨터정보학과가 아닌 학생의 '수강신청번호', '학번','날짜'를 가져오는 SQL문을 작성하시오. 
select 수강신청번호, 수강신청.학번, 날짜
from 수강신청, 학생
where 학생.학번 = 수강신청.학번 and 학생.학과 not in (학과='01'); -- 조인 

-- 39 <수강신청> 테이블에서 2018년 3월에 수강 신청한 레코드의 '수강신청번호', 학번', '날짜'를 가져오는 SQL문을 작성하시오. 
select 수강신청번호, 학번, 날짜
from 수강신청
where 날짜 like '2018-03%';

-- 40 <수강신청내역> 테이블에서 평점이 입력되어 있는(평점'이 -1이 아닌) 레코드중 '수강신청번호', '과목번호', '평점'과 평점이 0이면 '미취득' 아니면 '취득'으로 출력하는 SQL문을 작성하시오. 
select 수강신청번호, 과목번호, case when 평점=0 then '미취득' else '취득' end as '평점'
from 수강신청내역
where 평점 != -1;

-- 41 〈학생〉 테이블에서 이름'과 시도'를 하나로 묶어 필드명을 '이름'으로 읽어오는 SQL문을 작성하시오. 
select concat(이름,'(',시도,')') as 이름
from 학생;

-- 42 <과목> 테이블에서 ‘담당교수'와 '과목명'을 국문과 영문으로 읽어오는 SQL문을작성하시오. 
select 담당교수, concat(과목명, '(',영문명,')') as 과목명
from 과목;

-- 43 <과목> 테이블에서 '과목명'과 학점', 그리고 한 학기를 15주라 가정했을 때 한 학기 총 수업 시간 수를 읽어오는 SQL문을 작성하시오. 
select 과목명, 학점, 시수*15 as 총시간수
from 과목;

-- 44 <학생> 테이블에서 '학번'과 이름에서 성씨(last name)를 뺀 이름(first name)을 출력하는 SQL문을 작성하시오. 
 select 학번, right(이름,2) as 이름
 from 학생;
 
 -- 45 <수강신청> 테이블에서 3월 1일 수강 신청한 데이터의 '학번'과 '날짜'를 출력하는 SQL문을 작성하시오 
 select 학번, 날짜
 from 수강신청
 where 날짜 like '%03-01%';
 
 -- 46 <학생> 테이블에서 아래 그림과 같이 '학번', '이름', 학과'와 컴퓨터정보학과인지 다른 학과인지를 출력하는 SQL문을 작성하시오. 
 select 학생.학번, 이름, 학과, case when 학과='01' then '컴퓨터정보학과' else '타과' end as 비고
 from 학생, 수강신청;
 
 -- 47 〈수강신청내역〉 테이블에서 전체 행의 수(레코드의 수)를 계산하는 SQL문을 작성하시오 
 select count(*) as 신청수
 from 수강신청내역;
 
 -- 48 〈수강신청내역〉 테이블에서 '수강신청번호'가 '1810002'인 수강신청 레코드의 수를 계산하는 SQL문을 작성하시오. 
 select count(*) as 과목수
 from 수강신청내역
 where 수강신청번호 = 1810002;
 
 -- 49 <교수> 테이블에서 '전화번호'가 저장되어 있는 교수의 수를 계산하는 SQL문을 작성하시오. 
 select count(*) as 교수수
 from 교수
 where 전화번호 is not null;
 
 -- 50 <과목> 테이블에서 과목을 담당하고 있는 교수가 몇 명인지 출력하시오. 
 select count(distinct 담당교수) as 담당교수수
 from 과목; 
 
 -- 51 <과목> 테이블에서 전체 과목의 학점의 평균과 합을 구하는 SQL문을 작성하시오.
 select avg(학점) as 평균학점, sum(학점) as 총학점
 from 과목;

-- 52 <과목> 테이블의 과목 중에 최대 학점과 최소 학점을 구하는 SQL문을 작성하시오
select max(학점) as 최대학점, min(학점) as 최소학점
from 과목;

-- 53 <과목> 테이블에서 교수별로 담당하고 있는 과목 수와 학점 합계를 출력하시오. 
select 담당교수, count(과목명) as 과목수, sum(학점) as 학점수
from 과목
group by 담당교수;
 
-- 54 〈수강신청내역> 테이블에서 수강 신청한 서로 다른 과목의 수가 몇 과목인지를 구하는 SQL문을 작성하시오. 
select count(distinct 과목번호) as 과목수
from 수강신청내역;

-- 55 <수강신청> 테이블에서 수강 신청한 학생이 몇 명인지를 구하는 SQL문을 작성하시오
select count(distinct 학번) as 학생수
from 수강신청;

-- 56 〈수강신청내역> 테이블에서 '수강신청번호' '1810001'의 신청 과목 수와 평균 평점을 구하는 SQL문을 작성하시오
select count(과목번호) as 과목수, avg(평점) as 평균평점
from 수강신청내역
where 수강신청번호=1810001;
 
--  57 <수강신청내역> 테이블에서 아래와 같이 과목별로 수강자 수를 읽어오는(과목번호, 수강자 수) SQL문을 작성하시오. 
select 과목번호, count(과목번호) as 수강자수
from 수강신청내역
group by 과목번호;

-- 58 위의 문제에서 '평점'이 - 1인 과목은 제외하고 출력하도록 필터링하시오 
select 과목번호, count(과목번호) as 수강자수
from 수강신청내역
where 평점 not in (평점 =1)
group by 과목번호;

-- 59 위의 문제에서 과목별 평균 평점을 출력하시오. 
select 과목번호, count(과목번호) as 수강자수, avg(평점) as 평균평점
from 수강신청내역
where 평점 >=0
group by 과목번호;

-- 60 위의 문제에서 수강자 수가 4 명 이상인 과목만을 출력하도록 필터링하시오. 
select 과목번호, count(과목번호) as 수강자수, avg(평점) as 평균평점
from 수강신청내역
where 평점 >=0
group by 과목번호
having count(과목번호) >=4;

-- 61 위의 문제에서 평균평점을 기준으로 오름차순으로 정렬하시오. 
select 과목번호, count(과목번호) as 수강자수, avg(평점) as 평균평점
from 수강신청내역
where 평점 >=0
group by 과목번호
having count(과목번호) >=4
order by avg(평점);

-- 62 <수강신청내역> 테이블에서 아래와 같이 '수강신청번호별로 수강과목 수와 평균평점을 출력하시오. (단, 수강과목 수가 3 이상인 것만 출력하고 평균평점에 대하여 내림차순으로 정렬하시오). 
select 수강신청번호, count(수강신청번호) as 수강과목수, avg(평점) as 평균평점
from 수강신청내역
where 평점 >=0
group by 수강신청번호
having count(수강신청번호) >=3
order by avg(평점) desc;

-- 63 모든 학생에 대하여 학번, 학과번호, 이름, 소속 학과 이름을 출력하는 SQL 문을 작성하시오. 
select 학번, 학과, 이름, 학과명
from 학과, 학생
where 학과.학과번호 = 학생.학과; -- 이거 없으면 중복돼서 나옴

-- 64 <수강신청내역> 테이블에서 수강신청번호 '1810001'와 '1610001'에 대하여 수강신청번호와 수강 과목번호, 수강 과목명 출력하는 SQL 문을 작성하시오
select 수강신청번호, 수강신청내역.과목번호, 과목명
from 수강신청내역,과목 
where 과목.과목번호=수강신청내역.과목번호 and 수강신청번호 = 1810001 or 수강신청번호 = 1610001 ;

-- 65 <수강신청> 테이블에서 2018 년도 수강신청에 대하여 수강신청번호, 신청자 학번, 신청자 이름을 출력하는 SQL 문을 작성하시오
select 수강신청번호, 수강신청.학번, 이름
FROM 수강신청,학생
WHERE 수강신청.학번=학생.학번 and 연도=2018; 

-- 66 학번이 1801001'인 학생이 수강 신청한 수강신청번호, 과목번호, 과목명을 출력하는 SQL 문을 작성하시오.
select 수강신청내역.수강신청번호, 수강신청내역.과목번호, 과목명
from  수강신청내역, 수강신청, 과목, 학생
where 학생.학번 = 수강신청.학번 and 수강신청.수강신청번호 = 수강신청내역.수강신청번호 and 과목.과목번호 = 수강신청내역.과목번호 and 학생.학번 = 1801001;

-- 67 학번이 1801001'인 학생이 수강 신청한 수강신청번호, 과목번호, 과목명을 출력하는 SQL 문을 작성하시오 .... 중복

--  68 학번이 '1801001'인 학생이 수강 신청한 과목 수와 평점 합계를 출력하는 SQL 문을 작성하시오.
select count(수강신청내역.수강신청번호) as 과목수, sum(평점) as 평점
from 수강신청내역, 수강신청, 학생
where 학생.학번 = 수강신청.학번 and 수강신청.수강신청번호 = 수강신청내역.수강신청번호 and 학생.학번 = 1801001;

-- 69 수강신청 별로 신청 학생의 학번, 이름, 평균 평점(평점합계/과목수)를 출력하는 SQL 문을 작성하시오. (단, 학점이 부여된 수강신청만 출력한다
select 수강신청.수강신청번호, 학생.학번, 이름, avg(평점) as 평균평점
from 수강신청-- 다시 공부
join 학생 on 학생.학번=수강신청.학번
join 수강신청내역 on 수강신청.수강신청번호 = 수강신청내역.수강신청번호
where 평점 >-1
group by 수강신청번호;

-- 70 모든 학생에 대하여 학번, 학과번호, 이름, 소속 학과 이름을 출력하는 SOL 문을 작성하시오
select 학번, 학과, 이름, 학과, 학과명
from 학과, 학생
where 학생.학과 = 학과.학과번호;

-- 71 <수강신청내역> 테이블에서 수강신청번호 '1810001'와 '1610001'에 대하여 수강신청번호와 수강 과목번호, 수강 과목명을 출력하는 SQL 문을 작성하시오 -- 64번과 중복
select 수강신청번호, 과목.과목번호, 과목.과목명
from 수강신청내역, 과목
where 수강신청내역.과목번호 = 과목.과목번호 and 수강신청번호 in ('1810001', '1610001');

-- 72 <수강신청> 테이블에서 2018 년도 수강신청에 대하여 수강신청번호, 신청자 학번, 신청자 이름을 출력하는 SQL 문을 작성하시오. -- 65번 중복

-- 73 학번이 '1801001'인 학생이 수강 신청한 수강신청번호, 과목번호, 과목명을 출력하는 SQL 문을 작성하시오
select 수강신청.수강신청번호, 과목.과목번호, 과목명
from 학생, 과목, 수강신청,수강신청내역
where 학생.학번 = 수강신청.학번 and 수강신청.수강신청번호 = 수강신청내역.수강신청번호 and 과목.과목번호 = 수강신청내역.과목번호 and 학생.학번=1801001;

-- 74 사번이 '1000004'인 교수와 같은 학과에 소속되어 있는 교수의 사번, 학과, 이름을 출력하시오 -- 다시 공부 
SELECT 사번, 학과, 이름
FROM 교수
WHERE 학과 = ( -- 이 학과에서 사번, 학과, 이름 컬럼을 가져온다
    SELECT 학과
    FROM 교수
    WHERE 사번 = '1000004'
);

-- 75 학생별로 학번, 이름, 수강 신청한 과목 수, 평균 평점을 출력하시오. (단, 학점이 부여된 수강 신청만 출력한다 -- 다시 공부
SELECT 학생.학번, 학생.이름, COUNT(수강신청내역.과목번호) AS '과목 수', AVG(수강신청내역.평점) AS '평균 평점'
FROM 학생
JOIN 수강신청 ON 학생.학번 = 수강신청.학번
JOIN 수강신청내역 ON 수강신청.수강신청번호 = 수강신청내역.수강신청번호
WHERE 수강신청내역.평점 > 0
GROUP BY 학생.학번;


-- 76 과목별로 수강한 인원, 부여된 평점의 평균을 출력하시오. (단, 1 학기 과목만 출력) -- 다시 공부
SELECT 과목.과목번호, 과목.과목명, COUNT(*) AS 수강인원, AVG(수강신청내역.평점) AS 평균평점
FROM 수강신청내역
JOIN 과목 ON 수강신청내역.과목번호 = 과목.과목번호
where 학기=1
GROUP BY 과목.과목번호, 과목.과목명;

