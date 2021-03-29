/*
[1일차 수업]
1. 오라클 소프트웨어 다운로드
https://www.oracle.com/technetwork/database/enterprise-edition/downloads/index.html

2. Oracle Database 11g Release 2 Express Edition for Windows 64 (무료설치)

3. Oracle 설치(SYS, SYSTEM 계정의 대한 암호 : 1004)

4.Sqlplus 프로그램 제공(CMD) : GUI 환경 일반개발자 사용 불편

5.별도의 Tool 설치 무료(SqlDeveloper , https://dbeaver.io/)  ,
                 유료(토드 , 오렌지 , SqlGate) 프로젝트시 설치 활용 ^^

6. SqlDeveloper 툴을 통해서 Oracle Server 접속 ....
   >> HR 계정 : 암호 1004 , Unlock 2가지 사용가능 .... (사원관리 실습 테이블)
   >> 새로운 계정 : BITUSER

7. 현재 접속 계정 확인 : show user;   >> USER이(가) "BITUSER"입니다.


-- USER SQL
CREATE USER "BITUSER" IDENTIFIED BY "1004"  
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

-- QUOTAS

-- ROLES
GRANT "CONNECT" TO "BITUSER" WITH ADMIN OPTION;
GRANT "RESOURCE" TO "BITUSER" WITH ADMIN OPTION;
ALTER USER "BITUSER" DEFAULT ROLE "CONNECT","RESOURCE";

-- SYSTEM PRIVILEGES

*/

/*
실습코드

CREATE TABLE EMP
(EMPNO number not null,
ENAME VARCHAR2(10),
JOB VARCHAR2(9),
MGR number ,
HIREDATE date,
SAL number ,
COMM number ,
DEPTNO number );
--alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';

INSERT INTO EMP VALUES
(7369,'SMITH','CLERK',7902,'1980-12-17',800,null,20);
INSERT INTO EMP VALUES
(7499,'ALLEN','SALESMAN',7698,'1981-02-20',1600,300,30);
INSERT INTO EMP VALUES
(7521,'WARD','SALESMAN',7698,'1981-02-22',1250,200,30);
INSERT INTO EMP VALUES
(7566,'JONES','MANAGER',7839,'1981-04-02',2975,30,20);
INSERT INTO EMP VALUES
(7654,'MARTIN','SALESMAN',7698,'1981-09-28',1250,300,30);
INSERT INTO EMP VALUES
(7698,'BLAKE','MANAGER',7839,'1981-04-01',2850,null,30);
INSERT INTO EMP VALUES
(7782,'CLARK','MANAGER',7839,'1981-06-01',2450,null,10);
INSERT INTO EMP VALUES
(7788,'SCOTT','ANALYST',7566,'1982-10-09',3000,null,20);
INSERT INTO EMP VALUES
(7839,'KING','PRESIDENT',null,'1981-11-17',5000,3500,10);
INSERT INTO EMP VALUES
(7844,'TURNER','SALESMAN',7698,'1981-09-08',1500,0,30);
INSERT INTO EMP VALUES
(7876,'ADAMS','CLERK',7788,'1983-01-12',1100,null,20);
INSERT INTO EMP VALUES
(7900,'JAMES','CLERK',7698,'1981-10-03',950,null,30);
INSERT INTO EMP VALUES
(7902,'FORD','ANALYST',7566,'1981-10-3',3000,null,20);
INSERT INTO EMP VALUES
(7934,'MILLER','CLERK',7782,'1982-01-23',1300,null,10);

COMMIT;

CREATE TABLE DEPT
(DEPTNO number,
DNAME VARCHAR2(14),
LOC VARCHAR2(13) );

INSERT INTO DEPT VALUES (10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES (30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES (40,'OPERATIONS','BOSTON');

COMMIT;

CREATE TABLE SALGRADE
( GRADE number,
LOSAL number,
HISAL number );

INSERT INTO SALGRADE VALUES (1,700,1200);
INSERT INTO SALGRADE VALUES (2,1201,1400);
INSERT INTO SALGRADE VALUES (3,1401,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);
COMMIT;

*/
-- 1. 사원 테이블에서 모든 데이터를 출력하세요.
--[쿼리문]은 [대소문자] 구별(x) 
select * from emp;

SELECT * FROM EMP;

-- 2. 특정 컬럼 데이터 출력하기
select empno,ename,sal
from emp;

select ename from emp;

-- 3. 컬럼명 가명칭(alias) 별칭 부여하기
select empno 사번, ename 이름
from emp;

-- SQL 표준 (데이터를 다루는 수 많은 소프르웨어) >> 표준 >> ANSI 문법 
-- as "사     번"
-- Mysql, MS-SQL 아래 쿼리 동작
select empno as "사    번", ename as "이   름"
from emp;

--Oracle 데이터 : [문자열 데이터]는 엄격하게 [대소문자]를 구분
--   JAVA : 문자 'A', 문자열 "AAA"
-- Oracle : 문자열 'A', 'AAA'
-- Oracle : A, a >> 다른 문자
select empno, ename
from emp
where ename='king'; -- 조건절

select empno, ename
from emp
where ename='KING'; 

/*
select 절
from 절
where 절
*/

-- Oracle query (질의어) : 언어
-- 연산자 (결합연산자 ||, 산술연산자 + )
-- JAVA : + 숫자(산술연산)
--        + 문자열(결합)
-- Tip ) ms-Sql  + (결합 산술)

select '사원의 이름은' || ename || '입니다' as "사원정보"
from emp;

-- 테이블에는 컬럼 >> 타입
-- JAVA class Emp{private int empno}
-- Oracle create table emp (empno number)
-- 타입(컬럼) : 숫자, 문자열, 날짜
-- create table emp (ename varchar2(10));
-- 10byte >> 한글 1자 : 2byte, 영문자,특수문자,공백 : 1byte
-- 한글 5자, 영문자 10자

desc emp;

-- 형변환   내부적으로 자동 형변환 (숫자 -> 문자열) 결합
select empno || ename
from emp;

select empno + ename   -- 숫자 + 문자열 ORA-01722: invalid number 산술연산 불가
from emp;

-- 개발실
-- 사장님
-- 우리회사의 직종이 몇개나 있나 ?
select job from emp;
-- 중복 데이터 제거 : 키워드 - distinct
select DISTINCT job from emp;

-- distinct 원리 : grouping

select DISTINCT job, deptno
from emp
order by job; -- job group 그안에서 deptno group 1건씩(중복되지 않는 데이터)

select DISTINCT deptno,job
from emp
order by deptno;


-- Oracle Sql 언어(연산자)
-- java 거의 동일 ( + - * / ) 나머지 %
-- Oracle 동일  [ % 연산자를 쓰지않는다 ] >> 오라클은 함수로 따로 있다 Mod()

-- 사원테이블에서 사원의 급여를 100 달러 인상한 결과를 출력하세요.

select empno, ename, sal, sal + 100 as "인상급여"
from emp;

-- dual 임시 테이블 (가상)
-- syso
select 100 + 100 from dual; -- 데이터 테스트
select 100 || 100 from dual; --100100
select '100' + 100 from dual; -- 형변환 200 >> '100' 숫자형 문자데이터 (형을 변환하면 숫자가 가능한 데이터)
select 'A100' + 100 from dual;

-- 비교 연산자
--  <   >   <=
--주의
--java 같다 (==)  할당 (=)   javascript(==, ===) 같다
--Oracle 같다 (=) 같지 않다 (!=)

-- 논리 연산자
-- AND, OR, NOT

-- 조건절 (where) 원하는 row 값
select empno, ename, sal
from emp;

select empno, ename, sal
from emp
where sal >= 2000;

--사번이 7788번인 사원의 사번, 이름, 직종, 입사일을 출력
select empno, ename, job, hiredate
from emp
where empno = 7788;

-- 사원의 이름이 king 인 사원의 사번, 이름, 급여, 정보를 출력하세요
select empno,ename,sal
from emp
where ename = 'KING';

-- 급여가 2000달러 이상이면서 직종이 manager 인 사원의 모든 정보를 출력하세요
-- hint) AND, OR
select *
from emp
where sal >= 2000 AND job = 'MANAGER';

-- 급여가 2000달러 이상이거나 또는 직종이 manager 인 사원의 모든 정보를 출력하세요
select *
from emp
where sal >= 2000 OR job = 'MANAGER';

-- 오라클 날짜 ( DB 서버의 날짜)
-- 오라클 날짜 키워드(sysdate) 
select sysdate from dual; -- 21/03/02
-- 오라클이 설치된 PC의 시간 (서버의 시간)

-- 모든 시스템 날짜 필수 구성
-- 게시판
-- insert into board(writer, title, content, regdate)
-- values('홍길동','방가','졸립다',sysdate);
-- regdate 컬럼의 데이터는 서버의 시간
-- Tip) ms-sql : select getdate()

-- 오라클 서버(환경 설정 -> 날짜 )
select * from nls_session_parameters;

--NLS_DATE_FORMAT    >>  RR/MM/DD
--NLS_DATE_LANGUAGE	 >>  KOREAN
--NLS_TIME_FORMAT    >>  HH24:MI:SSXFF

-- 일반적으로 2021-03-02
-- 변경 정보는 현재 오라클에 접속한 사용자의 작업 환경만 설정
-- 그래서 접속을 끊었다가 재접속 하면 원래상태로 복원
-- 현재 session에만 반영
alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';
-- NLS_DATE_FORMAT	YYYY-MM-DD HH24:MI:SS
select sysdate from dual; -- 2021-03-02 14:10:21

select hiredate from emp;

select * 
from emp
where hiredate='1980-12-17';

select * 
from emp
where hiredate='1980/12/17';

select * 
from emp
where hiredate='1980.12.17';

select * 
from emp
where hiredate='80/12/17'; -- 현재 format (yyyy-MM-DD)

-- 사원의 급여가 2000이상이고 4000이하인 모든 사원의 정보를 출력하세요
select *
from emp
where sal >= 2000 and sal <= 4000;


-- 연산자 : 컬럼명 between A and B (= 포함)
select *
from emp
where sal between 2000 and 4000;

-- 부서번호가 10번 또는 20번 또는 30번인 사원의 사번, 이름, 급여, 부서번호를 출력하세요
select empno, ename, sal, deptno
from emp
where deptno between 10 and 30;
-- 연산자 ( IN 연산자 )
select *
from emp
where deptno in (10,20,30);

-- 부서번호가 10번 또는 20번이 아닌 사원의 사번, 이름, 급여, 부서번호를 출력하세요
select empno, ename, sal, deptno
from emp
where deptno!=10 and deptno!=20;
-- IN 부정연산자 ( NOT IN )
select empno,ename,sal,deptno
from emp
where deptno not in(10,20);

-- POINT : Oracle 값이 없다 ( 데이터 없다 ) >> null
-- 필 요약 (null)

create table member(
    userid VARCHAR2(20) not null, -- null 허용하지 않겠다. (필수 입력)
    name VARCHAR2(20) not null, -- 필수 입력
    hobby VARCHAR2(50) -- defalut null ( 기본적으로 null 허락) 선택입력
);
    
select * from member;
-- 회원가입 가정
insert into member(userid,hobby) values('hong','농구'); -- x
--ORA-01400: cannot insert NULL into ("BITUSER"."MEMBER"."NAME")
insert into member(userid,name) values('hong','홍길동');
-- hobby 컬럼의 데이터 : null 채워진다
select * from member;

-- point ( INSERT, UPDATE, DELETE )
-- 실제 반영을 위해서는 
-- 반드시 commit 을 해야한다. <-> ( rollback )
commit;



-- 데이터 삭제하고 다시 실습
delete from member;
commit;


-- 수당(comm) 을 받지 않는 모든 사원의 정보를 출력하세요
-- 0도 데이터(받는 조건)
select comm from emp;

select *
from emp
where comm = null; -- 이런 문법은 없다.
-- null 비교는 (is null, is not null) 암기

select *
from emp
where comm is null;

-- 수당(comm) 을 받는 모든 사원의 정보를 출력하세요
select *
from emp
where comm is not null;

-- 사원테이블에서 사번, 이름, 급여, 수당, 총급여를 출력하세요
-- 총급여(급여 + 수당)
select empno, ename, sal, comm, sal + comm as "총급여"
from emp;

-- POINT null 이란 녀석...
-- 1. null과의 모든 연산의 결과는 : null   ex) 100+null : null, 100-null : null
-- 2. 위 문제를 해결하기 위해서 함수를 만듬 >> nvl(), nvl2()
-- nvl(컬럼명, 대체값) >> 대체값으로 치환
-- Tip) MS-sql : null > convert()
--      my-sql : null > IFNULL()

select empno, ename, sal, comm, sal + nvl(comm,0) as "총급여"
from emp;

-- comm 컬럼에서 null 데이터를 만나면  0으로 치환해서 연산해라

select 1000 + null from dual;

select 1000 + nvl(null,100) from dual;

select comm, nvl(comm,111111) from emp;

-- 사원의 급여가 1000 이상이고 수당을 받지 않는 사원의 사번, 이름, 직종, 급여, 수당을 출력하세요
select empno, ename, job, sal, comm
from emp
where sal >= 1000 AND comm is null;

-- DQL ( data query language ) : select
-- DDL : 정의어 - create, alter, drop ( Table emp, dept) 객체
-- DML : 조작어 - insert, update , delete ( 반드시 작업 후 에는 
--      실 반영 : commit 
--    작업 취소 : rollback 명령어 반드시 실행

-- create table board (boardno number)
-- JAVA : class board (private int boardno)

create table Board(
    boardid number not null, -- 숫자, 필수 입력
    title varchar2(50) not null, -- 글제목(한글 25자, 영문자 50자 기준) 필수 입력
    content varchar2(2000) not null, -- 글내용(한글 1000자, 영문 2000자 기준) 필수 입력
    hp varchar2(20) -- default null   필수 입력 x (null 값 사용)
);

select * from USER_TAB_COLUMNS where table_name='BOARD';

-- create, alter, drop >> commit, rollback ( x )
-- commit, rollback ( insert, update, delete ) 작업 시에만 

select * from board;

insert into board(boardid, title,content)
values(100,'오라클','실수했네^^');

-- 데이터 잘못 넣었네 ....  취소 > rollback
rollback;

-- 데이터 반영 해야지
commit;

/*
-- Tip) MS-SQL : default - auto_commit 
insert into emp(empno) values(100); 자동 커밋

begin 
    insert into emp(empno) values(100);

rollback or commit 할때까지 대기.

Tip_ : Oracle은 개발자가 commit 또는 rollback을 실행하기 전에는 실 반영하지 않는다.
*/

select * from board;
commit;

insert into board(boardid,title,content)
values(200,'자바','그립다');

insert into board(boardid,title,content)
values(300,'자바','언젠가 보겠지');

select * from board;
-- rollback은 commit한 후의 값으로 되돌린다
rollback;

select boardid, title, content, nvl(hp,'EMPTY') as "HP"
from board; -- nvl함수 중요

-- 문자열 검색
-- 주소검색 : 검색어 - 역삼 -> 역삼 단어가 포함된 모든 주소가 다나온다 ( LIKE 패턴 검색 )
-- 문자열 패턴 검색( LIKE 연산자 )

-- like 연산자 ( 와일드 카드 문자 : 1. %(모든것), 2. _(한문자) 결합 패턴을 생성
-- 검색이 한정적 >> 상세한 검색을 위해 정규표현식 ( JAVA 정규표현식 오라클에 적용 )

select * 
from emp
where ename like '%A%'; -- ename 컬럼의 데이터가 A 를 포함하고 있는지 확인

select * 
from emp
where ename like '%a%'; -- 대소문자를 엄격하게 구분

select * 
from emp
where ename like 'A%'; -- 이름의 첫 글자가 A 인 모든 사원

select * 
from emp
where ename like '%E'; 

-- 역삼 단어가 들어있는 주소를 다 찾아라
-- selete * from zip where dong like '%역삼%';

-- selete * from member where name like '김%';

select * 
from emp
where ename like '%LL%';

select * 
from emp
where ename like '%A%A%';

select ename
from emp
where ename like '_A%'; -- 첫글자는 어떤것이 와도 상관없고, 두번째 글자는 A로 시작하는 모든 이름

select ename
from emp
where ename like '__A%';

-- 오라클 과제 (regexp_like) 상세검색
select * from emp where REGEXP_LIKE (ename,'[A-C]');
-- 오라클 사용할 수 있는 정규 표현 검색 5개 만들기 (EMP)

select *
from emp;

----------------------- 21-03-03 수업 -----------------------
-- 데이터 정렬하기
-- order by 컬럼명 : 문자, 숫자, 날짜정렬
-- 오름차순 : asc  - 낮은순 : default
-- 내림차순 : desc - 높은순

select *
from emp
order by sal; -- defalut asc

select *
from emp
order by sal asc;

-- 급여를 많이 받는 순으로 정렬
select *
from emp
order by sal desc;

-- 입사일이 가장 늦은 순으로 정렬해서 사번, 이름, 급여, 입사일을 출력하세요
select empno, ename, sal, hiredate
from emp
order by hiredate desc;

select empno, ename
from emp
order by ename asc; -- 문자열 정렬가능
/*
select 절       3순위
from 절         1순위
where 절        2순위
order by 절     4순위 ( select 한 결과를 정렬 )
*/

-- 해석
select empno, ename, sal, job, hiredate
from emp
where job='MANAGER'
order by hiredate desc;

--order by 컬럼명 asc, 컬럼명 desc, 컬럼명 asc
--POINT(답변형 게시판) 필수
select job, deptno
from emp
order by job asc, deptno desc; 
-- group핑
-- 직업을 기준으로 오름차순하고, 직업의 그룹을 가지고 직종으로 내림차순한다

-- 연산자
-- 합집합 ( union ) : 테이블과 테이블의 데이터를 합치는 것  ( 중복값은 배제 )
-- 합집합 ( union all ) : 중복값 허용

create table uta(name varchar2(20));

insert into uta(name) values('AAA');
insert into uta(name) values('BBB');
insert into uta(name) values('CCC');
insert into uta(name) values('DDD');
commit;

select * from uta;

create table ut(name varchar2(20));

insert into ut(name) values('AAA');
insert into ut(name) values('BBB');
insert into ut(name) values('CCC');
commit;

select * from ut;

select * from ut
union   -- 중복 데이터 배제
select * from uta;


select * from ut
union all 
select * from uta;

-- union
-- 1. 대응되는 컬럼의 타입이 동일
select empno, ename from emp  -- empno 숫자타입
union
select job, deptno from dept; -- job 문자열타입

-- 2. 대응되는 컬럼의 개수가 동일
select empno, ename, job, sal from emp  -- 컬럼 4개
union
select deptno, dname, loc from dept;   -- 컬럼 3개
-- 2-1. 대응되는 컬럼의 개수가 동일
--필요악 : null
select empno, ename, job, sal from emp  -- 컬럼 4개
union
select deptno, dname, loc, null from dept;   -- 컬럼 3개 
-- 컬럼을 맞추기위해 null로 대체
---------------------------------------------------------------
-- 초보 개발자가 의무적으로 해야하는 작업 ( 단일테이블 select )
---------------------------------------------------------------

-- Tip
--오라클 함수 ......
select * from SYS.NLS_DATABASE_PARAMETERS;
--NLS_CHARACTERSET  : 	AL32UTF8  한글 3byte 인식
--KO16KSC5601 2Byte (현재 변환하면 한글 다깨짐)
select * from nls_database_parameters where parameter like '%CHAR%';
------------------------------------------------------------------------------
create table test2(name varchar2(2));

insert into test2(name) values('a');
insert into test2(name) values('aa');
insert into test2(name) values('가'); --한글 1자 3byte 인지
-- value too large for column "BITUSER"."TEST2"."NAME" (actual: 3, maximum: 2)
-------------------------------------------------------------------------------
-- [2차시]
-- 오라클 함수 사용법
/*
단일 행 함수의 종류
1) 문자형 함수 : 문자를 입력 받고 문자와 숫자 값 모두를 RETURN 할 수 있다.
2) 숫자형 함수 : 숫자를 입력 받고 숫자를 RETURN 한다.
3) 날짜형 함수 : 날짜형에 대해 수행하고 숫자를 RETURN 하는 MONTHS_BETWEEN 함수를
제외하고 모두 날짜 데이터형의 값을 RETURN 한다.
4) 변환형 함수 : 어떤 데이터형의 값을 다른 데이터형으로 변환한다.
5) 일반적인 함수 : NVL, DECODE
*/

-- 문자열 함수
select initcap('the super man') from dual; -- initcap 단어 앞글자 대문자로 적용
select lower('AAA'), --  lower (대문자 -> 소문자) 
upper('aaa') from dual; -- upper ( 소문자 -> 대문자 )
select ename, lower(ename) as "ename" from emp;
select * from emp where lower(ename) = 'king';

select length('ABCD') from dual;   -- length ( 문자열 개수)
select length('홍길동') from dual;  -- 3개

select length('  홍 길 동 a') from dual; -- 9개 ( 공백포함 )

-- 결합 연산자 : ||
-- concat()
select 'a' || 'b' || 'c' as "data"
from dual; -- abc

--select concat('a','b','c') from dual; -- concat 은 파라미터값으로 2개 까지만 적용 가능
select concat('a','b') from dual;

select ename || '                ' || job from emp;
select concat(ename,job) from emp;

-- 부분 문자열 추출 
-- JAVA ( substring )
-- Oracle ( substr )
select substr('ABCDE',2,3) from dual; -- BCD
select substr('ABCDE',1,1) from dual; -- A
select substr('ABCDE',3,1) from dual; -- C

select substr('ABCDEsfasfsafsa',3) from dual; -- 3번 째부터 뒤에까지 전체 출력
select substr('ABCDE',-2,1) from dual; -- 뒤에서 부터 2번째 'D'
select substr('ABCDE',-2,2) from dual; -- DE

-- 사원테이블에서 ename 컬럼 데이터에 대해서 첫글자는 소문자로 나머지 글자는 대문자로 출력하되
-- 하나의 컬럼으로 만들어서 출력하세요
-- 컬럼의 별칭은 : fullname
-- 첫글자와 나머지 문자 사이에는 공백 하나를 넣으세요
-- SMITH >> s MITH 출력

select lower(substr(ename,1,1)) || ' ' || substr(ename,2) as "fullname"
FROM emp;

-- lpad, rpad ( 채우기 )
select lpad('ABC',10,'*') from dual; -- *******ABC
select rpad('ABC',10,'%') from dual; -- ABC%%%%%%%

-- 사용자의 비번 : hong1007
-- 화면 : ho******
-- 비번 : 1004 > 10**

select rpad(substr('hong1007',1,2),length('hong1007'),'*') as "pwd" from dual;   -- ho******

select rpad(substr('1004',1,2),length('1004'),'*') as "pwd" from dual; -- 10**

-- emp 테이블에서 ename 컬럼의 데이터를 출력하되 첫글자만 출력하고 나머지는 * 로 출력하세요
select rpad(substr(ename,1,1),length(ename),'*') as "ename" from emp;

-- rtrim 함수
-- (오른쪽 문자)를 지워라
select rtrim('MILLER', 'ER') from dual; -- MILL

-- ltrim 
-- (왼쪽 문자)를 지워라
select ltrim('MILLLLLLLLLLLER', 'MIL') from dual; -- ER

-- 공백 제거하는데 활용함
select '>' || rtrim('MILLER       ',' ') || '<' from dual;

-- 치환함수 ( replace )
select ename, replace(ename,'A','와우') from emp;
--------------------------------------------------------------------------------
-- [ 숫자 함수 ]

-- round() (반올림 함수)
--  -3  -2  -1  0(정수)  +1  +2  +3  +4  
select round(12.345,0) as "r" from dual;  -- 12 정수부분만 남겨라.
select round(12.567,0) as "r" from dual;  -- 13

select round(12.345,1) as "r" from dual;  -- 12.3
select round(12.567,1) as "r" from dual;  -- 12.6

select round(12.567,-1) as "r" from dual; -- 10
select round(15.345,-1) as "r" from dual; -- 20
select round(15.345,-2) as "r" from dual; -- 0

-- trunc() (절삭 함수)
--  -3  -2  -1  0(정수)  +1  +2  +3  +4  
select trunc(12.345,0) as "t" from dual; -- 12
select trunc(12.567,0) as "t" from dual; -- 12

select trunc(12.345,1) as "t" from dual; -- 12.3
select trunc(12.567,1) as "t" from dual; -- 12.5

select trunc(12.345,-1) as "t" from dual; -- 10
select trunc(15.567,-1) as "t" from dual; -- 10
select trunc(15.567,-2) as "t" from dual; -- 0

-- mod() (나머지 구하는 함수)
select 12/10 from dual;   -- 1.2
select mod(12,10) from dual; -- 나머지 2

select mod(0,0) from dual; -- 0
-----------------------------------------------------------------------
--[ 날짜 함수 ]
-- alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';
select sysdate from dual;

-- POINT (날짜 연산)
-- 1. Date + NUMBER >> Date
-- 2. Date - NUMBER >> Date
-- 3. Date - Date >> Number
select sysdate + 100 from dual; -- 2021-06-11 12:04:02
select sysdate + 1000 from dual; -- 2023-11-28 12:04:21

select hiredate from emp;
-- 함수 
select trunc(months_between('2018-02-27','2010-02-20'),0) from dual; -- 96개월

select months_between(sysdate,'2010-03-03') from dual; -- 132개월

select '2019-03-03' + 100 from dual;
--POINT to_date() 변환함수
select to_date('2019-03-03') + 100 from dual;

-- 사원 테이블에서 사원들의 입사일에서 현재날짜까지 근속월수를 구하세요 ( 사원이름, 입사일, 근속월수 )
-- 단 근속월수는 정수부분만 출력하세요 ( 반올림 하지 마세요 )
select ename, hiredate, trunc(months_between(sysdate,hiredate),0) as "근속월수"
from emp;

-- 2. 한달이 31일 이라는 기준에서 근속월수를 구하세요 ( 반올림 하지 마세요 ) ( 함수사용 x ) 날짜 - 날짜 >> 150일 소요
select trunc((sysdate - hiredate)/31,0) as "근속월수" from emp;
------------------------------------------------------------------------------
--[변환함수] TODAY POINT
-- Oracle 데이터 : 문자열, 숫자, 날짜
-- to_char() : 숫자 -> 문자 ( 1000 - > $100,000 )  출력형식
--             날짜 -> 문자 ( '2021-03-03' -> 2021년03월03일 )  출력형식

-- to_date() : 문자 -> 날짜 
select to_date('2019-03-03') + 100 from dual;

-- to_number() : 문자 -> 숫자 >> 자동 형변환이 있어서 자주 사용 안함
select '100' + 100 from dual; -- [숫자형 문자]는 자동 형변환 된다.
select to_number('100') + 100 from dual; --(정식적 표현) 굳이 하지 않는다.

-------------------------------------------------------------------------------
/*
create table 테이블명 (컬럼명 타입, 컬럼명 타입 ...)
create table member (age number); insert .... 1건 ~ 1000건
insert into member(age) values(100);
.... 100건 insert 

insert into member(age) values(100);
insert into member(age) values(200);
insert into member(age) values(300);
insert into member(age) values(400);
....


[Java] 라고 한다면
class member {private int age; }
1건 -> 객체 1개
member m = new member();
m.setAge(100);

100건
List<member> mlist = new ArrayList<member>();
mlist.add(new member(100));
mlist.add(new member(200));
mlist.add(new member(300));
mlist.add(new member(400));
.....

데이터 타입
문자열 타입
char(10)      >> 10byte >> 한글 5자, 영문자 특수문자 공백 10자,      char : 고정길이 문자열
varchar2(10)  >> 10byte >> 한글 5자, 영문자 특수문자 공백 10자,  varchar2 : 가변길이 문자열

char(10)     >> 'abc' >> 3byte >> [a] [b] [c] [] [] [] [] [] [] [] []   >> 공간의 변화가 없다
varchar2(10) >> 'abc' >> 3byte >> [a] [b] [c]  >> 데이터 크기 만큼만 공간 확보

-- 한글 1자 3byte ( 남, 여 )
create table member(gender char(3));
create table member(gender varchar2(3));
-- 성능(char) 


create table member(gender char(30));  >> 사람의 이름
create table member(gender varchar2(30));

약속 : 고정길이 데이터 ( 남,여 ... 대, 중, 소 ... 주민번호 ) char
       가변길이 데이터 ( 수시로 바뀌는 데이터 ( 사람이름 , 주소, 취미 ) varchar2 

char() varchar2 단점 : 한글, 영문자 특수문자 공백 혼합 사용하면 오류 발생
varchar2(10)

unicode ( 2byte ) : 한글, 영문자, 특수문자 , 공백 >> 2byte 

nchar(20) >> 20글자 >> 2 * 20 >> 40byte 
nvarchar2(20) >> 20글자 >> 2 * 20 >> 40byte

한글 문화권은 n (유니코드)를 많이 사용한다.
*/

create table test3(name nchar(2), ename nvarchar2(2));

insert into test3(name) values('a');
insert into test3(name) values('가');

insert into test3(name) values('ab');
insert into test3(name) values('가나');

insert into test3(name) values('abc'); -- 3글자  value too large for column
insert into test3(ename) values('가나다'); -- value too large for column
commit;

select * from test3;

-- 1. to_number() 문자 -> 숫자로 (자동 형변환)
select '1' + 1 from dual;
-- 원칙
select to_number('1') + 1 from dual;

-- 2. to_char() 숫자 -> 형식문자  , 날짜 -> 형식문자
select sysdate, to_char(sysdate,'YYYY') || '년' as "YYYY",
                to_char(sysdate,'YEAR'),  
                to_char(sysdate,'MM'),     
                to_char(sysdate,'DD'),
                to_char(sysdate,'DAY'),
                to_char(sysdate,'DY')
from dual;                    


-- 입사일이 12월인 사원의 사번, 이름, 입사일, 입사년도, 입사월을 출력하세요
select empno, ename, hiredate, to_char(hiredate,'MM') as "입사일", to_char(hiredate,'YYYY') as "입사년도"
from emp
where to_char(hiredate,'MM') = '12';


select to_char(hiredate, 'YYYY MM DD') from emp;
select to_char(hiredate, 'YYYY"년" MM"월" DD"일"') from emp; -- 예외적

-- to_char() : 숫자 -> 형식문자
-- 오라클.pdf ( 71 page 표 참조 )
-- 10000000   -> $1,000,000,000

select '>' || to_char(12345,'9999999999') || '<' from dual;  -- >      12345<
select '>' || to_char(12345,'0999999999') || '<' from dual;  -- > 0000012345<

select '>' || to_char(12345,'$9,999,999,999') || '<' from dual;

select sal, to_char(sal,'$999,999,999') from emp;

-- HR 계정
select * from employees;
select sysdate from dual;
--alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';

/*
사원테이블 (employees) 에서 사원의 이름은 last_name, first_name 합쳐서 fullname 별칭 부여해서 출력하고
입사일은 YYYY-MM-DD 형식으로 출력하고 연봉(급여*12) 구하고 연봉의 10%(연봉 * 1.1) 인상한 값을
출력하고 그 결과는 1000단위 콤마 처리해서 출력하세요
단 2005년 이후 입사자들만 출력하세요 그리고 연봉이 높은 순으로 출력하세요
*/

select last_name || first_name as "fullname", 
    to_char(hire_date, 'YYYY-MM-DD') as "입사일",
    to_char((salary * 12),'999,999') as "연봉" , 
    to_char((salary * 12) * 1.1,'999,999') as "연봉 10%인상"
from employees
where to_char(hire_date, 'YYYY') >= '2005'
--order by salary * 12 desc;
order by "연봉" desc;

-- order by 절에 select가 가지고 있는 별칭(as)를 사용 할 수 있다. 그 이유는 실행 순서 때문에.
-----------------------------------------------------------------------------
--문자함수
--날짜함수
--숫자함수
--변환함수(to_char(), to_number(), to_date())
-----------------------------------------------------------------------------
-- 일반함수(프로그램 성격이 가장 강한 함수)
-- nvl(), nvl2() >> null 을 처리하는 함수
-- decode() >> java if문 처럼 사용
-- case()   >> java switch 처럼 사용

-- 오라클 SQL ( 변수, 제어문 개념이 없다 )
-- 오라클 PL-SQL ( 변수, 제어문 사용가능 ) 고급기능


select comm, nvl(comm,0) from emp;

create table t_emp(
 id number(6), -- 정수 6자리
 job nvarchar2(20)
 );
 
insert into t_emp(id, job) values (100,'IT');
insert into t_emp(id, job) values (200,'SALES');    
insert into t_emp(id, job) values (300,'MGR');    
insert into t_emp(id) values (400);    
insert into t_emp(id, job) values (500,'MGR');    
commit;

select * from t_emp;

select id, decode(id, 100,'아이티',
                      200,'영업부',
                      300,'관리팀',
                      '기타부서') as "부서이름"
from t_emp;

select empno, ename, deptno, decode(deptno, 10, '인사부',
                                             20, '관리부',
                                             30, '회계부',
                                             40, '부서',
                                             'ETC') as "부서이름"
from emp;                                             
                                        

--Quiz
CREATE TABLE t_emp2(
id NUMBER(2),
jumin CHAR(7)
);
INSERT INTO t_emp2(id, jumin) VALUES(1,'1234567');
INSERT INTO t_emp2(id, jumin) VALUES(2,'2234567');
INSERT INTO t_emp2(id, jumin) VALUES(3,'3234567');
INSERT INTO t_emp2(id, jumin) VALUES(4,'4234567');
INSERT INTO t_emp2(id, jumin) VALUES(5,'5234567');
COMMIT;
SELECT * FROM t_emp2;
/*
t_emp2 테이블에서 id, jumin 데이터를 출력하되 jumin 컬럼의 앞자리가 1이면
'남성' 출력 2이면 '여성' 3이면 '중성' 그외는  '기타' 라고 출력하세요
컬럼명은 '성별'
*/

select decode(substr(jumin,1,1), 1,'남성',
                                 2,'여성',
                                 3,'중성',
                                   '기타') as "성별"
                    
                    
from t_emp2;

/*
if 문안에 if 문 ( 중첩 ) 

아래 코드 decode() 함수 작업하기
-- 커피 쿠폰 빙고 답 .....
부서번호가 20번인 사원중에서 SMITH 라는 이름을 가진 사원이라면 HELLO 문자 출력하고
부서번호가 20번인 사원중에서 SMITH 라는 이름을 가진 사원이 아니라면 WOLRD 문자 출력하고
부서번호가 20번인 사원이 아니라면 ETC 라는 문자를 출력하세요

*/

select decode(deptno, 20,decode(ename,'SMITH','HELLO','WOLRD'),'ETC')
from emp;

-- CASE 문
-- java switch
/*
case 조건식 WHEN 결과1 THEN 출력1
           WHEN 결좌2 THEN 출력2
           WHEN 결좌3 THEN 출력3
           ELSE 출력4
END "컬럼명"
*/
create table t_zip(
    zipcode number(10)
);

insert into t_zip(zipcode) values(2);
insert into t_zip(zipcode) values(31);
insert into t_zip(zipcode) values(32);
insert into t_zip(zipcode) values(33);
insert into t_zip(zipcode) values(41);
commit;

select * from t_zip;

select '0' || to_char(zipcode), case zipcode when 2 then '서울'
                                             when 31 then '경기'
                                             when 32 then '강원'
                                             when 41 then '제주'
                                             else '기타지역'
                                    end "지역이름"
from t_zip;                                    
                                    
                                    
-- case 컬럼명 when 결과 then 출력
-- case when [컬럼명 조건 비교식] then
select sal , case when sal<=1000 then '4급'
                  when sal>=1001 and sal<=2000 then '3급'
                  when sal>=2001 and sal<=3000 then '4급'
                  when sal>=3001 and sal<=4000 then '4급'
                  else '특급'
                  end "사원급여"
from emp;
------------------------------------------------------------------------
--문자함수
--숫자함수
--날짜함수
--변환함수 ( to_char(), to_date(), to_number())
--일반함수 nvl(), decode(), case 구문
-- 기본함수 end --
------------------------------------------------------------------------
-- 집계(그룹) 함수
-- 오라클.pdf (75page)

-- 1. count(*) >> row수 , count(컬럼명) >> 데이터 건수 ( null은 포함하지 않는다 )
-- 2. sum() 
-- 3. avg()
-- 4. max()
-- 5. min()
-- 기타
-- 1. 집계함수는 group by 절과 같이 사용
-- 2. 모든 집계함수는 null 값을 무시한다
-- 3. select 절에 집계함수 이외의 다른 컬럼이 오면 반드시 그 컬럼은 group by 절에 명시

select count(*) from emp; -- 14건 데이터 건수가 아니고 row 수

select count(empno) from emp; -- 14건

select count(comm) from emp; -- 6건  null 값 무시

select comm from emp;
-- comm 컬럼의 데이터도 14건 나오고 싶다.
select count(nvl(comm,0)) from emp;

select sum(sal) as "급여의 합" from emp;
select round(avg(sal),0) as "급여의 평균" from emp;

-- 사장님 우리회사 총 수당이 얼마나 지급 되었나
select sum(comm) from emp;

-- 수당의 평균
select trunc(avg(comm),0) from emp; -- 721

select trunc(sum(comm)/14,0) from emp; -- 309

select trunc(avg(nvl(comm,0))) from emp; -- 309


select max(sal) from emp;
select min(sal) from emp;

select empno, count(empno) from emp; -- ORA-00937: not a single-group group function

select sum(sal), avg(sal), max(sal), min(sal), count(sal) from emp;
--------------------------------------------------------------------------
--부서별 평균 급여를 구하세요
select deptno, avg(sal) 
from emp
group by  deptno;

--직종별 평균 급여를 구하세요
select job, avg(sal)
from emp
group by job;

--직종별 평균급여, 급여의 합, 최대급여 , 최소급여, 건수 출력하세요
select job, avg(sal), sum(sal), max(sal), min(sal), count(sal)
from emp
group by job;
/*
grouping

distinct 컬러명1, 컬럼명2

order by 컬럼명1, 컬럼명2

group by 컬럼명1, 컬럼명2

*/

-- 부서별, 직종별 급여의 합을 구하세요
select deptno, job, sum(sal), count(sal)
from emp
group by deptno, job;


/* 
select     5번
from       1번
where      2번
group by   3번
having     4번
ordey by   6번
*/

-- 직종별 평균급여가 3000달러 이상인 사원의 직종과 평균급여를 출력하세요
select job, avg(sal) as "평균급여"
from emp
group by job
having avg(sal) >= 3000;
-- having 절에서  select 절 가명칭 사용 불가 
-- 실행순서가 having이 먼저 실행 되기 때문에
/*
1. from 조건절  *where
2. group by 절의 조건절 *having
*/


/* 사원테이블에서 직종별 급여합을 출력하되 수당을 지급 받고 급여의 합이 5000 이상인 사원들의 목록을 출력하세요
-- 급여의 합이 낮은 순으로 출력하세요*/
select job, sum(sal) as "급여의합"
from emp
where comm is not null
group by job
having sum(sal) >= 5000
order by sum(sal) asc;

/* 사원테이블에서 부서 인원이 4명보다 많은 부서의 부서번호, 인원수, 급여의 합을 출력하세요 */
select deptno, count(deptno) as "인원수", sum(sal) as "급여의 합"
from emp
group by deptno
having count(deptno) > 4;

/* 사원테이블에서 직종별 급여의 합이 5000을 초과하는 직종과 급여의 합을 출력하세요
단 판매직종(salesman) 은 제외하고 급여합을 내림차순 정렬하세요 */
select job, sum(sal) as "급여의 합"
from emp
where job != 'SALESMAN'
group by job
having sum(sal) > 5000
order by "급여의 합" desc;

---------------------------------------------------------
------------------2021-03-04 수업-------------------------

--JOIN
--다중테이블에서 데이터 가져오기
--RDBMS ( 한개 이상의 테이블들이 서로 관계를 가지고 있는 구조 )
--JOIN : 데이터를 가지고 오는 방법
--관계
-- 1 : 1
-- 1 : N 
-- M : N

--조인 실습 테이블 구성하기--
create table M (M1 char(6) , M2 char(10));
create table S (S1 char(6) , S2 char(10));
create table X (X1 char(6) , X2 char(10));

insert into M values('A','1');
insert into M values('B','1');
insert into M values('C','3');
insert into M values(null,'3');
commit;

insert into S values('A','X');
insert into S values('B','Y');
insert into S values(null,'Z');
commit;

insert into X values('A','DATA');
commit;

select * from m;
select * from s;
select * from x;


-- 종류
-- 1. 등가조인 (equi join) 70%가 이걸 사용.
-- 원테이블과 대응대는 테이블에 있는 컬럼의 데이터를 1 : 1 매핑

--문법
-- 1. SQL JOIN 문법 ( 오라클 문법 ) >> 간단하게 사용 가능
-- 2. ANSI 문법 ( 표준 ) 권장 : 무조건 사용 >> [inner] join on 조건절
select *
from m , s
where m.m1 = s.s1;

select m.m1 , m.m2 , s.s2
from m , s
where m.m1 = s.s1;

-- ANSI
select m.m1 , m.m2 , s.s2
from m join s   -- inner 일반적으로 생략
on m.m1 = s.s1;

select m.m1 , m.m2 , x.x2
from m join x
on m.m1 = x.x1;

-- emp, dept
-- 사원번호, 사원의 이름, 부서번호, 부서이름을 출력하세요
select emp.empno, emp.ename, emp.deptno , dept.dname
from emp join dept
on emp.deptno = dept.deptno;

-- 현업 : 테이블 명이 길다.
-- join 테이블의 별칭
select e.empno, e.ename , e.deptno , d.dname
from emp e join dept d
on e.deptno = d.deptno;

-- join
-- 테이블 2개, 3개, 4개 일수도 있다.
-- SQL join 
select * 
from m , s , x
where m.m1 = s.s1 and s.s1 = x.x1;

-- ANSI JOIN   > 이걸로 사용
select m.m1 , m.m2 , s.s2 , x.x2
from m join s on m.m1 = s.s1 
       join x on s.s1 = x.x1;
       
-- a(a1) , b(b1) , c(c1) , d(d1)       
from a join b on a.a1 = b.b1
       join c on c.c1 = b.b1
       join d on d.d1 = c.c1;
       
-- HR 계정으로 이동
select * from employees;
select * from departments;
select * from locations;
       
-- 1. 사번, 이름(last_name), 부서번호, 부서이름을 출력하세요
select e.employee_id , e.last_name , e.department_id, d.department_name
from employees e join departments d
on e.department_id = d.department_id;

-- 1. 사번, 이름(last_name), 부서번호, 부서이름, 지역코드, 도시명 을 출력하세요
select e.employee_id , e.last_name , e.department_id, d.department_name , l.location_id  , l.street_address
from employees e join departments d on e.department_id = d.department_id
                 join locations l on l.location_id = d.location_id;
                 
-----------------------------------------------------------------------
select * from emp;

-- 2. 비등가 조인(non-equi join ) => 1:1로 비교할 컬럼이 없다
-- >> 의미만 존재 >> 등가조인 문법
-- join : 컬럼과 컬럼이 1:1 매핑 emp.depno = dept.deptno
select * from emp;
select * from salgrade;
                 
-- 비등가 조인                 
select e.empno, e.ename , e.sal , s.grade
from emp e join salgrade s
on e.sal between s.losal and s.hisal;
                 
-- 3. outer join (equi join + null(나머지)
-- outer join >> 1. equi join 선행하고 > 2. 그 다음 의사 결정 (남은 데이터를 어떻게 가져올 것인지 )
-- outer join join테이블의 주종 관계를 파악
-- 주인되는 테이블의 남은 데이터를 가져 올 수 있다
-- 문법
-- 1. left [outer] join ( 왼쪽 테이블이 주인 )
-- 2. right [outer] join ( 오른쪽 테이블이 주인 )
-- 3. full [outer] join ( left 와 right join >> union )

-- SQL 문법 ( 사용절대 x )
select *
from m join s
on m.m1 *= s.s1;

-- ANSI 문법
-- left join
select *
from m left join s
on m.m1 = s.s1;

-- right join
select *
from m right join s
on m.m1 = s.s1;

-- full join
select *
from m full  join s
on m.m1 = s.s1;

-------------------------------------------------------------------------
-- 1. 사번, 이름(last_name), 부서번호, 부서이름을 출력하세요
select e.employee_id , e.last_name , e.department_id, d.department_name
from employees e left join departments d
on e.department_id = d.department_id;


-- 4. self join ( 자기 참조 ) > 문법은 없고 의미만 존재한다 >> 문법(등가조인)
-- 하나의 테이블 컬럼이 자신의 테이블에 있는 다른 컬럼을 참조하는 경우

-- join 기본 테이블 2개
-- emp 테이블 1개
-- 가명칭

select e.empno, e.ename, m.empno, m.ename
from emp e left join emp m
on e.mgr = m.empno;

---------------------------------------------------------------------------
-- 1. 사원들의 이름, 부서번호, 부서이름을 출력하라.
select e.ename, e.empno, d.dname
from emp e join dept d
on e.deptno = d.deptno;


-- 2. DALLAS에서 근무하는 사원의 이름, 직위, 부서번호, 부서이름을
-- 출력하라.
select e.ename , e.job,e.deptno, d.dname
from emp e join dept d
on e.deptno = d.deptno
where d.loc = 'DALLAS';


-- 3. 이름에 'A'가 들어가는 사원들의 이름과 부서이름을 출력하라.
select e.ename, d.dname
from emp e join dept d
on e.deptno = d.deptno
where e.ename like '%A%';

-- 4. 사원이름과 그 사원이 속한 부서의 부서명, 그리고 월급을
--출력하는데 월급이 3000이상인 사원을 출력하라.
select e.ename, d.dname, sal
from emp e join dept d
on e.deptno = d.deptno
where sal >= 3000;
?

-- 5. 직위(직종)가 'SALESMAN'인 사원들의 직위와 그 사원이름, 그리고
-- 그 사원이 속한 부서 이름을 출력하라.
select e.job , e.ename , d.dname
from emp e join dept d
on e.deptno = d.deptno
where job = 'SALESMAN';

-- 6. 커미션이 책정된 사원들의 사원번호, 이름, 연봉, 연봉+커미션,
-- 급여등급을 출력하되, 각각의 컬럼명을 '사원번호', '사원이름',
-- '연봉','실급여', '급여등급'으로 하여 출력하라.
--(비등가 ) 1 : 1 매핑 대는 컬럼이 없다

select e.empno as "사원번호", e.ename as "사원이름 ", e.sal as "연봉", e.sal+e.comm as "실급여" , s.grade as "급여등급"
from emp e join salgrade s
on e.sal between s.losal and s.hisal
where comm is not null;

-- 7. 부서번호가 10번인 사원들의 부서번호, 부서이름, 사원이름,
-- 월급, 급여등급을 출력하라.
select e.empno , e.ename , e.deptno , e.sal , s.grade
from emp e join salgrade s
on e.sal between s.losal and s.hisal
where e.deptno = 10;
?

-- 8. 부서번호가 10번, 20번인 사원들의 부서번호, 부서이름,
-- 사원이름, 월급, 급여등급을 출력하라. 그리고 그 출력된
-- 결과물을 부서번호가 낮은 순으로, 월급이 높은 순으로
-- 정렬하라.

select d.deptno, d.dname, e.empno, e.ename, e.sal , s.grade 
from emp e join salgrade s on e.sal between s.losal and s.hisal
            join dept d on e.deptno = d.deptno
where e.deptno != 30
order by e.sal desc;

-- 9. 사원번호와 사원이름, 그리고 그 사원을 관리하는 관리자의
-- 사원번호와 사원이름을 출력하되 각각의 컬럼명을 '사원번호',
-- '사원이름', '관리자번호', '관리자이름'으로 하여 출력하라.
--SELF JOIN (자기 자신테이블의 컬럼을 참조 하는 경우)
select e.empno as "사원번호" , e.ename as "사원이름" , a.mgr as "관리자번호" , a.ename as "관리자이름"
from emp e join emp a
on e.mgr = a.empno;


----------------------------------------------------------
--subquery
--오라클.pdf ( 7장 100page )
-- SQL 꽃 >> SQL 만능 해결사
-- 1. 함수 >> 다중 >> JOIN >> 해결이 안되면 >> SUBQUERY

-- 사원테이블에서 사원들의 평균 월급보다 더 많은 급여를 받는 사원의 사번, 이름, 급여를 출력하세요

-- 1. 평균 급여
select avg(sal) from emp;

select empno, ename , sal
from emp
where sal > 2073;

-- 하나의 문제 해결 쿼리 2개 ( 1개의 문장 )
select empno, ename , sal
from emp
where sal > (select avg(sal) from emp);

-- SubQuery
-- 1. single row subquery : subquery 의 실행 결과가 단일 row 단일 column ( 단일 값 ) : 한개의 값
-- 기존 연산자 ( = > < ... )

-- 2. multi  row subquery : subquery 의 실행 결과가 1개 이상의 row ( 여러개의 값 ) : 단일 컬럼
-- in(), not in(), ANY(), ALL() 연산자
-- ALL : sal > 1000 and sal > 4000 and ....
-- ANY : sal > 1000 or sal > 4000 or ....

-- why : 사용되는 연산자의 종류가 다르다

--subquery 문법
-- 1. 괄호 안에 있어야한다 >> (select max(sal) from emp)
-- 2. 단일 컬럼으로 구성되어야 한다 >> select empno, sal from emp ( 서브쿼리 x )
-- 3. 단독으로 실행이 가능하여야 한다

-- 실행순서
-- 1. subquery 먼저 실행
-- 2. subquery 결과를 가지고 메인 query 가 실행

-- TIP )
-- SELECT (subquery) -> 한개의 행만 반환 할 경우 ( Scala Sub Query)
-- FROM (subquery)   -> INline View(가상테이블)
-- WHERE (subquery)  -> 조건

-- 사원테이블에서 jones의 급여보다 더 많은 급여를 받는 사원의 사번, 이름, 급여를 출력하세요
select empno, ename,sal
from emp
where sal >= (select sal from emp where ename = 'JONES');

select *
from emp
where sal = (select sal from emp where deptno = 30); -- 멀티row 
-- ORA-01427: single-row subquery returns more than one row

select *
from emp
where sal in(select sal from emp where deptno = 30);
--sal = 1600 and sal = 1250 and sal = 2850....

select *
from emp
where sal not in(select sal from emp where deptno = 30);
--sal != 1600 and sal != 1250 and sal != 2850....

-- 부하 직원이 있는 사원의 사번과 이름을 출력하세요
-- (내 사번이 mgr 컬럼에 있다 )
select empno,ename
from emp
where empno in(select mgr from emp);

-- empno == 7902 or empno == 7698 ...
-- 부하직원이 없는 사원의 사번과 이름을 출력하세요
select empno,ename
from emp
where empno not in(select mgr from emp);
-- (and 연산에 null 영향 ) >> 그 결과는 null
-- empno != 7902 and empno != 7698 ...
select empno,ename
from emp
where empno not in (select nvl(mgr,0) from emp);

-- king 에게 보고하는 즉 직속상관이 king 인 사원의 사번, 이름, 직종 , 관리자 사번을 출력하세요
select empno, ename ,job ,mgr
from emp
where mgr = (select empno from emp where ename = 'KING');

-- 20번 부서의 사원중에서 가장 많은 급여를 받는 사원보다 더 많은 급여를 받는 사원의 사번, 이름, 급여, 부서번호를 출력하세요.
select empno, ename , sal , deptno
from emp
where sal > (select max(sal) from emp where deptno = 20);

select empno, ename, sal , avgsal
from emp e join (select deptno, avg(sal)as avgsal from emp group by deptno) d
on e.deptno = d.deptno
where e.sal > d.avgsal;

-----------------------------------------------------------------------
--1. 'SMITH'보다 월급을 많이 받는 사원들의 이름과 월급을 출력하라.
select ename, sal
from emp
where sal > (select sal from emp where ename = 'SMITH');

select sal from emp where ename = 'SMITH';

--2. 10번 부서의 사원들과 같은 월급을 받는 사원들의 이름, 월급,
-- 부서번호를 출력하라.
select ename, sal, deptno
from emp
where sal in (select sal from emp where deptno = 10);?

select sal from emp where deptno = 10;
--3. 'BLAKE'와 같은 부서에 있는 사원들의 이름과 고용일을 뽑는데
-- 'BLAKE'는 빼고 출력하라.
select ename, hiredate
from emp
where deptno = (select deptno from emp where ename = 'BLAKE') and ename != 'BLAKE';
?


--4. 평균급여보다 많은 급여를 받는 사원들의 사원번호, 이름, 월급을
-- 출력하되, 월급이 높은 사람 순으로 출력하라.
select empno, ename, sal
from emp
where sal > (select avg(sal) from emp)
order by sal desc;

?

--5. 이름에 'T'를 포함하고 있는 사원들과 같은 부서에서 근무하고
-- 있는 사원의 사원번호와 이름을 출력하라.
select empno, ename, deptno
from emp
where deptno in(select deptno from emp where ename like '%T%');

?

--6. 30번 부서에 있는 사원들 중에서 가장 많은 월급을 받는 사원보다
-- 많은 월급을 받는 사원들의 이름, 부서번호, 월급을 출력하라.
--(단, ALL(and) 또는 ANY(or) 연산자를 사용할 것)
select ename, deptno , sal
from emp
where sal > ALL(select max(sal) from emp where deptno = 30);

select max(sal) from emp where deptno = 30;
--7. 'DALLAS'에서 근무하고 있는 사원과 같은 부서에서 일하는 사원의
-- 이름, 부서번호, 직업을 출력하라.
select e.ename , e.DEPTNO , e.job
from emp e join dept d
on e.deptno = d.deptno
where e.deptno = (select deptno from dept where loc = 'DALLAS');


SELECT ENAME, DEPTNO, JOB
FROM EMP
WHERE DEPTNO IN(SELECT DEPTNO    -- = 이 맞는데  IN
                      FROM DEPT
                      WHERE LOC='DALLAS');

--8. SALES 부서에서 일하는 사원들의 부서번호, 이름, 직업을 출력하라.

select e.deptno , e.ename , e.job
from emp e join dept d
on e.deptno = d.deptno
where e.deptno = (select deptno from dept where dname = 'SALES');

select DEPTNO, ENAME, JOB
FROM EMP
WHERE DEPTNO IN(SELECT DEPTNO
                      FROM DEPT
                      WHERE DNAME='SALES');
--9. 'KING'에게 보고하는 모든 사원의 이름과 급여를 출력하라
--king 이 사수인 사람 (mgr 데이터가 king 사번)
select ENAME, SAL
from emp
where mgr = (select empno from emp where ename = 'KING');

SELECT ENAME, SAL
FROM EMP
WHERE MGR=(SELECT EMPNO
                FROM EMP
                WHERE ENAME='KING');

--10. 자신의 급여가 평균 급여보다 많고, 이름에 'S'가 들어가는
-- 사원과 동일한 부서에서 근무하는 모든 사원의 사원번호, 이름,
-- 급여를 출력하라.

select empno,ename,sal
from emp
where sal > (select avg(sal) from emp) and ename like '%S%';
?

--------
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL > (SELECT AVG(SAL)
                FROM EMP)
AND DEPTNO IN(SELECT DEPTNO
                   FROM EMP
                   WHERE ENAME LIKE '%S%');
                   
--11. 커미션을 받는 사원과 부서번호, 월급이 같은 사원의
-- 이름, 월급, 부서번호를 출력하라.
select ename, sal, empno
from emp
where deptno in(select deptno from emp where comm is not null) and sal in(select sal from emp where comm is not null);

--12. 30번 부서 사원들과 월급과 커미션이 같지 않은
-- 사원들의 이름, 월급, 커미션을 출력하라.
select ename, sal , comm
from emp
where sal not in(select sal from emp where deptno = 30) and comm not in(select nvl(comm,0) from emp where deptno = 30);

SELECT ENAME, SAL, COMM
FROM EMP
WHERE SAL NOT IN(SELECT SAL
                        FROM EMP
                        WHERE DEPTNO=30)
AND COMM NOT IN(SELECT NVL(COMM, 0)
                         FROM EMP
                         WHERE DEPTNO=30 and comm is not null);

