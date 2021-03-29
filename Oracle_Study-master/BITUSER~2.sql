--------------------------------2021-03-08수업----------------------------------
alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';

select * from emp;
select * from dept;
select * from salgrade;

-- view 객체 ( 가상 테이블 )
-- 오라클.PDF ( 192page )

-- view 객체 ( create )
-- create view 뷰이름 as [ select 구문 ]
-- view 는 테이블 처럼 사용 가능한 ( 가상 테이블 ) : 데이터를 가지고 있지 않다
-- view 메모리상에만 존재하는 가상테이블
-- ( subquery -> in line view -> from ( select deptno avg(sal) from ... )

-- view 가상 테이블
-- 사용법 : 일반 테이블과 사용법 동일 ( select , where ...
-- 단, view 볼 수 있는 데이터에 한해서만 사용가능.
-- DML ( insert, update, delete ) -> view 를 통해서 원본테이블에 대한 DML 가능  

-- bituser 권한 문제 ( SYSTEM 계정을 통해서 권환 부여 )
-- SYSTEM >> GRANT CREATE ANY VIEW TO "BITUSER" WITH ADMIN OPTION; 실행

create view v_001
as select empno, ename from emp;

select * from v_001; -- view가 가지고 있는 sql 문장이 실행

-- VIEW 사용 목적 
-- 1. 개발자의 편리성 : JOIN, SUBQUERY >> view 사용시 편하게 사용가능 >> 성능 떨어지지만 편리해진다.
-- 2. 쿼리의 단순화 ( 편리성 ) : 복잡한 쿼리를 미리 만들어두고 사용 가능
-- 3. 관리자 보안성 >> 특정 컬럼만 노출 

-- 편리성
create view v_002
as 
    select e.empno, e.ename, e.deptno, d.dname 
    from emp e join dept d
    on e.deptno = d.deptno;

select * from v_002;
select * from v_002 where deptno = 20;

-- 뷰 가상테이블 (자존심) 나도 테이블인데 (컬럼명이 존재)

create view v_003
as 
    select deptno, avg(sal) as avg -- 컬럼명 별칭 띄어쓰기 아니면 "" 안붙이는게 편하다.
    from emp 
    group by deptno;


select deptno, avg from v_003;

/*
CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW view_name [(alias[,alias,...])]
AS Subquery
[WITH CHECK OPTION [CONSTRAINT constraint ]]
[WITH READ ONLY]

OR REPLACE                          이미 존재한다면 다시 생성한다.
FORCE Base Table                    유무에 관계없이 VIEW 을 만든다.
NOFORCE                             기본 테이블이 존재할 경우에만 VIEW 를 생성한다.
view_name VIEW 의 이름
Alias Subquery 를 통해 선택된 값에 대한 Column 명이 된다.
Subquery SELECT 문장을 기술한다.
WITH CHECK OPTION VIEW        에 의해 액세스 될 수 있는 행만이 입력,갱신될 수 있다.
Constraint CHECK OPTON        제약 조건에 대해 지정된 이름이다.
WITH READ ONLY 이 VIEW        에서 DML 이 수행될 수 없게 한다.
*/
create or replace view v_004 -- 없으면 만들고 있으면 덮어써라
as 
    select avg(sal) as avgsal from emp;
    

select * from v_004;    
    
create or replace view v_004 
as 
    select round(avg(sal),0) as avgsal from emp;
    
select * from v_004;

-- view 가상 테이블 DML 작업 가능 ( insert, update, delete )
-- 단, view 통해서 볼 수 있는 데이터만 DML 가능 ... 단순 테이블만 가능
-- 단순 view ( 테이블 1개 ) >> DML 가능 >> 될 수 있으면 하지말기
-- 복합 view ( 테이블 1개 이상 ) >> join, subquery >> DML 불가

select * from v_001;

-- 30번 부서 사원들의 직위, 이름, 월급을 담는 view 를 만드는데
-- 각각의 컬럼명을 직위, 사원이름, 월급으로 alias를 주고 월급이
-- 300보다 많은 사원들만 추출하도록 하라.

create or replace view v_emp
as
    select  job as 직위, ename as 사원이름, sal as 월급
    from emp
    where sal >= 300 and deptno = 30;

select * from v_emp;

-- 부서별 평균월급을 담는 view 를 만들되, 평균월급이 2000이상인
-- 부서만 출력하도록 하라
-- from 조건 -> where
-- group by 조건 -> having

create view v_emp2
as
    select deptno as 부서번호, avg(sal) as 평균월급
    from emp
    group by deptno
    having avg(sal) >= 2000;

select * from v_emp2;



-- 퀴즈
select v."부서번호", v."평균월급", d.dname
from v_emp2 v join dept d
on v."부서번호" = d.deptno;

-------------------------------------------------------------------------------
-- 개발자 관점에서 SQL 
-- 11장 SEQUENCE (오라클.pdf 185 page )
-- 순번 추출하기 ( 채번하기 )

/*
sequence_name SEQUENCE 의 이름입니다.
INCREMENT BY n 정수 값인 n 으로 SEQUENCE 번호 사이의 간격을 지정.
이 절이 생략되면 SEQUENCE 는 1 씩 증가.

START WITH n 생성하기 위해 첫번째 SEQUENCE 를 지정.
이 절이 생략되면 SEQUENCE 는 1 로 시작.

MAXVALUE n SEQUENCE 를 생성할 수 있는 최대 값을 지정.
NOMAXVALUE 오름차순용 10^27 최대값과 내림차순용-1 의 최소값을 지정.
MINVALUE n 최소 SEQUENCE 값을 지정.
NOMINVALUE 오름차순용 1 과 내림차순용-(10^26)의 최소값을 지정.
CYCLE | NOCYCLE 최대 또는 최소값에 도달한 후에 계속 값을 생성할 지의 여부를
지정. NOCYCLE 이 디폴트.
CACHE | NOCACHE 얼마나 많은 값이 메모리에 오라클 서버가 미리 할당하고 유지
하는가를 지정. 디폴트로 오라클 서버는 20 을 CACHE
*/

-- WHY " WEB SITE : 게시판 >> key ( 식별값 ) >> 순번 ( 1, 2, 3 ... )

drop table board;

create table board(
    boardid number constraint pk_board_boardid primary key,
    title nvarchar2(50)
    );

select * from board;
-- boardid (pk : not null, unique , 내부적으로 index 자동 생성 )
-- 게시판에 글을 쓰면
-- insert into board(boardid,title) values();
-- boardid 컬럼의 데이터는 처음 글을 쓰면 1 이라는 값이 insert 
-- 그 다음 글부터는 2, 3, 4 ... 순차적인 데이터가 insert 되는 규칙
/*
insert into board(boardid, title)
values(number, '처음글') -- 1;

insert into board(boardid, title)
values( , '두번째') -- 2;
*/
select count(boardid + 1) from board;

insert into board(boardid,title) values((select count(boardid + 1) from board),'처음글');

insert into board(boardid,title) values((select count(boardid + 1) from board),'두번째글');

select * from board;
commit;

-- 문제점 : DML 문제발생

-- 다른 방법 
insert into board(boardid,title) values((select nvl(max(boardid + 1),0) from board),'처음글');

insert into board(boardid,title) values((select nvl(max(boardid + 1),0) from board),'두번째');

insert into board(boardid,title) values((select nvl(max(boardid + 1),0) from board),'세번째');

commit;

delete from board where boardid = 1;

insert into board(boardid,title) values((select nvl(max(boardid + 1),0) from board),'네번째');

select * from board;
commit;

-------------------------------------------------------------------------------
-- sequence 번호 추출 : 중복값이 없고 순차적인 값을 제공 ( 공유 객체 )
------------------------------------------------------------------------------
create sequence board_num;

select * from user_sequences;

/*
 NEXTVAL 과 CURRVAL 의사열
 - 특징 -
 1) NEXTVAL 는 다음 사용 가능한 SEQUENCE 값을 반환 한다.
 2) SEQUENCE 가 참조될 때 마다, 다른 사용자에게 조차도 유일한 값을 반환한다.
 3) CURRVAL 은 현재 SEQUENCE 값을 얻는다.
 4) CURRVAL 이 참조되기 전에 NEXTVAL 이 사용되어야 한다.
*/

-- 번호 추출
select board_num.NEXTVAL from dual; -- 채번

-- 현재까지 채번한 번호 확인
select board_num.CURRVAL from dual; -- 

-- 게시판
-- 게시판 사용되는 채번기
create table kboard(
    num number constraint pk_kboard_num primary key,
    title nvarchar2(50)
    );

create sequence kboard_num;

insert into kboard values(kboard_num.NEXTVAL, '처음이당');

insert into kboard values(kboard_num.NEXTVAL, '둘이당');

insert into kboard values(kboard_num.NEXTVAL, '셋이당');

commit;

select kboard_num.currval from dual;

delete from kboard where num = 1;
commit;

insert into kboard values(kboard_num.NEXTVAL, '넷이당');

select * from kboard;
commit;

---------------------------------------------------------------------------
-- 1. sequence 객체는 테이블에 종속되지 않는다 ( 하나의 시퀀스를 여러개의 테이블에서 사용가능 )
-- sequence 생성 >> A 테이블, B 테이블에서 사용 가능 

-- 웹 사이트 ( 게시판 10개 )
-- 상품게시판, 관리자 게시판, 회원 게시판 ....
-- 요구사항
-- sequence 10개 만들어서 각각 사용
-- or  sequence 1개만 만들어서 10개테이블에서 사용가능


-- TIP)
-- MS-SQL : create table board(boardid int identity(1,1), title varchar(20));
-- insert into board(title) values('방가') >> boardid 자동 1 > 2 > 3 ....
-- 테이블 종속 ....
-- MS-SQL : 2012 버전 ( sequence ) 

-- MY-SQL : create table board(boardid int auto_increment, title varchar2(20);

-- MYsql 만든 사람들이 뭉쳐서 open source 개념 >> mariadb ( 같은 엔진 )
-- https://mariadb.com/kb/en/create-sequence/  >>  sequencce객체 존재

------------------------------------------------------------------------------
-- 옵션
create sequence seq_num
start with 10  -- 시작 값 
increment by 2; -- 증가 하는 수

select seq_num.NEXTVAL from dual;

select seq_num.currval from dual;

-- 게시판 글 100개

/*
num,   title,   content
1
2
3
...
100
*/
-- 일반적으로 게시판 최신글 ( 가장 나중에 쓴 글이 ) 화면에 가장 상단
select * from kboard order by num desc; -- 일반게시판 첫 쿼리
------------------------------------------------------------------------------- 
-- 개발자 
-- rownum 의사 컬럼 : 실제 물리적으로 존재하는 컬럼이 아니고 논리적인 존재
-- rownum : 실제로 테이블 컬럼에 존재하지 않지만 내부적으로 행 번호를 부여할 수 있는 컬럼

select * from emp;
select rownum as 순번, empno, ename from emp;
-- select 한 결과에 순번을 부여

-- Top-n ( 정렬된 기준으로 위에서 몇개 추출 )
-- 테이블에서 조건에 맞는 상위(TOP) 레코드 n 개 ( row ) n개 추출
-- TIP
-- MS_SQL ( top 키워드 ) 
-- select top 10, * from emp order by sal desc;

-- oracle top n (x)
-- rownum : 순번을 부여 특정 조건을 사용해서 top 쿼리 실행

-- 1. 정렬의 기준을 정의 ( 선행 )
-- 2. 정렬된 데이터를 기준으로 rownum 설정하고 조건을 걸어서 데이터 추출

-- 1단계
select  *
from (      select *
            from emp
            order by sal desc
      ) e;

-- 2단계

select  rownum as num , e.*
from (      select *
            from emp
            order by sal desc
      ) e;

-- 3단계 ( 급여를 많이 받는 사원 5명 ) top n 
select *
from (
        select  rownum as num , e.*
        from (      select *
                    from emp
                    order by sal desc
              ) e
     ) n 
     where num <= 5;
---------------------------------------------------------------------------
-- top n ( 게시판 페이징 처리 )
-- 1000 건
-- 웹 화면에 100건 데이터 한번에 출력하지 않아요
-- 10건씩 한 화면에 

-- pagesize = 10 ( 한 화면에  ( 페이지 ) 보여줄 수 있는 row 건수 
-- page 개수 >> 10개

-- 1page , 2page ..... 10 page ( 1page 클릭 >> select 1 ~ 10 java 전달 )
--                             ( 2page 클릭 >> select 11 ~ 20 java 전달 )

-- <a href = ' page.jsp?'>10</a> 10page ( 91 ~ 100 )
----------------------------------------------------------------------------
-- HR 계정 --
-- 사번이 낮은 순으로 정렬(기준)
select * from employees; -- 107 건

-- 1단계 ( 기준 데이터 만들기 )
select * from employees order by employee_id asc;

-- 2단계 ( 기준 데이터에 순번 부여하기
select rownum as num, e.*
from (
    select * from employees order by employee_id asc
     ) e 
where rownum <= 50; -- 내부적으로 생성된 rownum 사용

-- 3단계
select *
from (
            select rownum as num, e.*
            from (
                select * from employees order by employee_id asc
                 ) e 
            where rownum <= 50
      ) n 
where num >= 41;

-- 107건
-- pagesize = 10
-- [1] [2] [3] [4] [5] [6] [7] [8] [9] [10] [11]
-- [1] >> 1~ 10
-- [2] >> 11~ 20
-- ....
-- [5] >> 41 ~ 50 데이터를 보여주는 쿼리

-- 1번 페이지 클릭 ( 1 ~ 10 )
select *
from (
            select rownum as num, e.*
            from (
                select * from employees order by employee_id asc
                 ) e 
            where rownum <= 10
      ) n 
where num >= 1;

-- between A and B   >> where rownum 1 and 10
-- servlet & jsp 수업 다시

select rownum as num, e.*
from (
    select * from employees order by employee_id asc
) e
where rownum between 1 and 10;
---------------------------------SQL END---------------------------------------
