---------------------------------------------------------------------------------------------------------
-- 데이터 조작 ( DML )
-- 오라클.pdf ( 10 장 168 page )
-- 반드시 암기
-- INSERT, UPDATE , DELETE 

/*
오라클 기준
DDL ( 데이터 정의어 ) : [create, alter , drop, truncate] , rename , modify
DML ( 데이터 조작어 ) : insert, update , delete
DQL ( 데이터 질의어 ) : select
DCL ( 데이터 제어어 ) : 관리자 : grant , revoke 
TCL ( 트랜잭션 ) : commit , rollback , savepoint

DML 작업 ( insert, update, delete )
-- A 계좌에서 B라는 계좌 이체
---------------------------------------------------
-- A 계좌 ( 1000 ) 출금 : update 계좌 set 금액 -
- > 900
-- B 계좌 ( 1000 ) 입금 : update 계좌 set 금액 +
- > 1100
---------------------------------------------------
-- A 계좌에서 출금 B 계좌 입금 [하나의 논리적인 단위로 묶어버리자]
-- 둘다 성공이 아니면 둘다 실패
-- 트랜잭션 : 하나의 논리적인 단위
-- 처리 방법 -> commit , rollback
*/

-- desc emp (기본정보)

-- 상세한 정보 ( 현재 접속 계정이 가지고 있는 테이블 목록 )
select * from tab;

-- create table 이름 ... 기존에 있으면 생성 불가 ( 기존에 있는지 없는지 확인하는 방법 )  select * from tab;

select * from tab where tname='BOARD';

select * from col where tname = 'EMP'; 

-----------------------------------------------------------
-- 1. insert

create table temp(
    id number primary key, -- 제약 ( null 값(x), 중복(x) )
    name nvarchar2(20)
);

-- 1. 가장 일반적인 INSERT 작업
insert into temp(id,name) values(100,'홍길동');

select * from temp;

commit; -- 실 반영

-- 2. 컬럼 목록을 생략 가능 - 개발에서 사용 x ( 가독성이 떨어진다 )
insert into temp
values(200,'김유신');

select * from temp;

rollback;

-- 3. 문제 ( id 컬럼에 PK )
insert into temp(name)
values ('누구야');
-- ORA-00001: unique constraint (BITUSER.SYS_C007003) violated  
-- ORA-01400: cannot insert NULL into ("BITUSER"."TEMP"."ID")
-- DB 는 무결성을 중요시 한다.
------------------------------------------------------------------------
-- TIP)
-- 일반적인 SQL 문은 프로그램적인 요소가 없다
-- PL-SQL ( 변수, 제어문 )

/*
create table temp2 (id varchar2(50));

BEGIN
    FOR i IN 1..100 LOOP
        insert into temp2(id) values('A' || to_char(i));
    END LOOP;
END;
*/

--select * from temp2;
--------------------------------------------------------------------------------
-- 개발시 sample 데이터 넣고 test 원하면 이런 방법 사용

create table temp3(
    memberid number(3) not null, -- 정수 3자리 null 값 금지
    name varchar(10), 
    regdate date default sysdate -- 초기값을 지정(기본값) (insert 자동 시스템 날짜)
);

select sysdate from dual;
--alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';

insert into temp3(memberid, name, regdate)
values(100,'홍길동','2021-03-04');

select * from temp3;
commit;

insert into temp3(memberid, name) values (200,'김유신');

select * from temp3;
commit;

insert into temp3(memberid)
values (300);

select * from temp3;
commit;

/*
insert into temp3(name)
values('누구');
ORA-01400: cannot insert NULL into ("BITUSER"."TEMP3"."MEMBERID")
*/

----------------------------------------------------------------------
-- TIP) 
-- 1. 대량 데이터 insert 하기
create table temp4(id number);
create table temp5(num number);

insert into temp4(id) values (1);
insert into temp4(id) values (2);
insert into temp4(id) values (3);
insert into temp4(id) values (4);
insert into temp4(id) values (5);
insert into temp4(id) values (6);
insert into temp4(id) values (7);
insert into temp4(id) values (8);
insert into temp4(id) values (9);
insert into temp4(id) values (10);
commit;

select * from temp4;

select * from temp5;

-- 요구사항
-- temp4 에 있는 모든 데이터를 temp5에 넣고 싶다.
-- insert into 테이블명(컬럼리스트) values 
-- insert into 테이블명(컬럼리스트) select 절;

insert into temp5(num) select id from temp4;
-- 대량 insert
select * from temp5;
commit;

--2. 대량 insert 
-- 테이블이 없는 상황에서 >> [테이블 복제(구조 : 스키마) + 데이터 삽입]
-- 단 제약 정보는 복사가 안된다. ( pk .. fk )
-- 순서한 데이터 구조 + 데이터 복사
-- create table copyemp(id number .... )

create table copyemp
as 
    select * from emp;

select * from copyemp;
commit;

create table copyemp2
as 
    select empno,ename,sal from emp where deptno = 30;
    
select * from copyemp2;
commit;

-- 질문
-- 틀(스키마) 구조만 복제하고 데이터는 복사하고 싶지 않아요
create table copyemp3
as 
    select * from emp where 1=2; -- where 1=1 거짓 조건

select * from copyemp3;

------------------------------[INSERT EMP]-------------------------------------
-- [UPDATE]
/*
update table_name
set column1 =  values, column2 = values ......
where condition

update table_name
set column1 = (subquery)
where colunm2 = (subquery)
*/
select * from copyemp;

update copyemp set sal = 0;

rollback;


update copyemp set sal =1111
where deptno = 20;

select * from copyemp where deptno = 20;
rollback;

-- subquery 활용
update copyemp
set sal = (select sum(sal) from emp);

select * from copyemp;
rollback;

-- 여러개의 컬럼 업데이트 가능
update copyemp
set ename='AAA', job = 'BBB', hiredate = sysdate , sal = (select sum(sal) from emp)
where empno = 7369;

select * from copyemp where empno = 7369;
rollback;
--------------------------------[update END]------------------------------------
-- [DELETE]
delete from copyemp;

select * from copyemp;
rollback;

delete from copyemp where deptno = 10;

select * from copyemp where deptno = 10;
commit;
--------------------------------[DELETE END]------------------------------------
-- 개발자 (SQL) >> CRUD ( Create(insete) , Read(select) , Update , Delete )
-- APP(JAVA) - JDBC API - Oracle

-- CRUD 
-- 전체조회 , 조건조회 , 삽입 , 수정 , 삭제  => 개발자 => 자바코드에서 작업
-- JAVA코드에서는 함수로 만든다 
-- 전체조회  - public List<Emp> getEmpAllList() { select * from emp )
-- 조건조회  - public Emp getEmpListByEmpno(int empno) { select * from emp where empno = empno }
-- 삽입     - public int insertEmp(Emp emp){ insert into emp(...) values ( ..... ) }
 
--------------------------------------------------------------------------------
-- DDL작업  ( create, alter , drop ( rename ) )  : 테이블을 만들고, 수정하고, 삭제하는 작업 
-- 오라클.pdf( 9장_ 테이블 생성  ( 138 page )
select * from board;

-- 테이블 삭제
drop table board;
-- ORA-00942: table or view does not exist

create table board(
    boardid number,
    title nvarchar2(50),
    content nvarchar2(2000),
    regdate date
);

desc board;

-- TIP (정보조회)
select * from user_tables where lower(table_name) = 'board';
select * from user_constraints where lower(table_name) = 'board';
----------

-- Oracle 11g >> 가상 컬럼 ( 조합 컬럼 )
-- 학생의 성적 테이블 : 국어 , 영어 , 수학 , 총점
-- 국어, 영어, 수학 데이터만 insert를 하면 자동으로 총점 데이터가 만들어 지고 싶다.

create table vtable(
    no1 number,
    no2 number,
    no3 number GENERATED ALWAYS as (no1 + no2) VIRTUAL
);

insert into vtable(no1, no2) values(100,50);

select * from vtable;

insert into vtable(no1, no2) values(10,80);

------ 가상 컬럼에 값을 넣을려고 하면 오류 발생 --------------
insert into vtable(no1, no2, no3) values(10,80,90);
-- SQL 오류: ORA-54013: INSERT operation disallowed on virtual columns

select * from user_tab_columns where table_name = 'VTABLE';

--실무에서  활용하는 코드
--제품정보 (입고일) 분기별 데이터 (4분기)
--입고일 : 2019-03-01 >> 1분기

create table vtable2( 
  no number , --순번
  p_code char(4), --제품코드 (A001 , B002)
  p_date char(8), --입고일(20190303)
  p_qty number,   --수량
  p_bungi number(1) GENERATED ALWAYS as (
               CASE WHEN substr(p_date,5,2) IN ('01','02','03') THEN 1
                    WHEN substr(p_date,5,2) IN ('04','05','06') THEN 2
                    WHEN substr(p_date,5,2) IN ('07','08','09') THEN 3
                    ELSE 4
                    END) VIRTUAL
);

select COLUMN_NAME , DATA_TYPE , DATA_DEFAULT 
from user_tab_columns where table_name='VTABLE2';

insert into vtable2(p_date) values('20180101');
insert into vtable2(p_date) values('20180126');
insert into vtable2(p_date) values('20190301');
insert into vtable2(p_date) values('20191225');
insert into vtable2(p_date) values('20190525');
select * from vtable2;
select * from vtable2 where p_bungi=1;

commit;

--------------------------------------------------------------------------------
-- DDL 테이블 만들고 수정 삭제

-- 1. 테이블 생성하기
create table temp6(id number);

-- 2. 테이블을 이미 생성했는데 컬럼을 하나 추가하고 싶다. ( add )
--   기존테이블에 추가.
alter table temp6
add ename varchar2(20);

select * from temp6;

-- 3. 기존 테이블에 있는 컬럼의 이름을 잘못 표기 ( ename -> username )
--   기존테이블에 있는 기존 컬럼의 이름을 수정(rename)
alter table temp6 
rename column enmae to username;

select * from temp6;


-- 4. 기본 테이블에 있는 기존 컬럼의 타입 정보 수정 ( modify )
alter table temp6
modify(username varchar2(2000));

desc temp6;

-- 5. 기본 테이블에 있는 기존 컬럼 삭제
alter table temp6
drop column username;

select * from temp6;

-- 6. 테이블 전체가 필요 없어졌다
--   6.1 delete : 데이터를 삭제.
-- 테이블을 처음 만들면 처음 크기가 주어진다 >> 데이터를 넣으면 데이터 크기 만큼 테이블 크기 증가
-- EX) 처음 테이블을 만들면 1M >> 데이터 10만건 넣으면 >> 100M 증가 >> delete 10만건 삭제 >> 데이터 삭제 >> 테이블의 크기는 그대로.

-- 테이블 데이터 삭제 [공간의 크기]도 줄일 수 없을까 ?
-- truncate ( 단점 where 사용 불가 ) 
truncate table temp6;


-- 7. 테이블 삭제 drop
drop table temp6;

--------------------------------------------------------------------------------
-- 데이터 무결성 제약 조건의 종류 
-- 테이블 제약 설정하기
-- Oracle.pdf (page.144)

-- 데이터 무결성 확보
-- insert, update 에 대해서 무결성을 확보 (제약)
/*         제 약 조 건 설 명
    PRIMARY KEY(PK) : 유일하게 테이블의 각행을 식별(NOT NULL 과 UNIQUE 조건을 만족)
                      - where empno = 7788 >> 데이터가 1건이라는 것을 보장 >> 성능 보장 >> 조회 ( 내부적으로 index )
                      - 단점 : 새로운 데이터가 오거나, 데이터를 삭제 할 경우 불합리 하다.
                      - 테이블당 1개 ( 여러개의 컬럼을 묶어서 1개 )
                      
    FOREIGN KEY(FK) : 열과 참조된 열 사이의 외래키 관계를 적용하고 설정합니다.
                      - 테이블과 테이블과의 관계를 정의 ( 참조제약 )
    
    UNIQUE key(UK)  : 테이블의 모든 행을 유일하게 하는 값을 가진 열(NULL 을 허용)
                     - 유일값 .. null은 허용 >> not null unique 둘다
                     - 컬럼의 개수 만큼 (10개)
                     
    NOT NULL(NN)    : 열은 NULL 값을 포함할 수 없습니다.
    
    CHECK(CK)       : 참이어야 하는 조건을 지정함(대부분 업무 규칙을 설정)
                       - 설정 범위 내의 값만 입력받겠다 ( gender : 컬럼에 남 또는 여 데이터만 입력 ) 
                       - where gender in ('남','여')
                       - gender in ('남','여') 제약으로
*/

-- 제약을 만드는 시점 
-- 1. ( create table ... 안에서 생성 )
-- 2. 테이블을 다 만들고 나서 추가 ( alter table ... add constraint ... ) 많이 사용 >> 모델링 툴


-- TIP)
-- 제약 정보 확인
select * from user_constraints where table_name='EMP';

create table temp7 (
    --id number primary key -- 안되요 ( 권장하지 않는다 ) -- 제약 이름 자동생성 (삭제 수정 ) 어렵다
    id number constraint pk_temp7_id primary key , -- 관용적 표현 ( 이름 설정 )
    name varchar2(20) not null,
    addr varchar2(50)
    );
    
select * from user_constraints where table_name='TEMP7';

--ORA-01400: cannot insert NULL into ("BITUSER"."TEMP7"."ID")
insert into temp7(name, addr) values('홍길동','서울시 강남구');
------------------------------------------------------------

insert into temp7(id,name,addr) values(10,'홍길동','서울시 강남구');

select * from temp7;
commit;

--ORA-00001: unique constraint (BITUSER.PK_TEMP7_ID) violated
insert into temp7(id,name,addr) values(10,'아무개','서울시 개포동');
-------------------------------------------------------------

-- 1. primary key ( 테이블에 몇개까지 걸 수 있을까 ? > 1개 )
--   여러개를 묶어서 1개
-- create teble member(ename, age) << 두개의 컬럼을 묶어서 하나의 복합키 
-- where ename = ... and age = .... and num = ....  (한건의 데이터로 보장)


create table temp8(
    id number constraint pk_temp8_id primary key,
    name nvarchar2(30) not null,
    jumin nchar(6) constraint uk_temp8_jumin unique, -- 중복은 불가능 null 은 가능 
    addr nvarchar2(1000)
);

select * from user_constraints where table_name='TEMP8';

insert into temp8(id,name,jumin,addr)
values(10,'홍길동','123456','경기도');
commit;


--ORA-00001: unique constraint (BITUSER.UK_TEMP8_JUMIN) violated
insert into temp8(id,name,addr)
values(20,'김유신','서울');
-----------------------------------------------------------------

select * from temp8; -- unique 제약은 null 허용
--    jumin nchar(6) not null constraint uk_temp8_jumin unique -- null(x)

insert into temp8(id,name,addr)
values(30,'아무개','강원도');
-- null 중복 체크를 하지 않는다.

select * from temp8;
commit;
-------------------------------------------------------------------
-- 테이블을 생성 후 제약 걸기
create table temp9 (id number);

-- 기존 테이블에 제약 추가
-- 조건 ( 제약 추가될때 테이블에 데이터 검사 ) >> 중복 데이터 >> 중복 데이터 삭제 >> 제약 추가

alter table temp9
add constraint pk_temp9_id primary key(id);
-- add constraint pk_temp9_id primary key(id, num); 복합키

select * from user_constraints where table_name='TEMP9';


alter table temp9
add ename varchar2(50);

-- not null 추가

alter table temp9
modify(ename not null);

select * from user_constraints where table_name='TEMP9';
------------------------------------------------------------------
-- [Check 제약]
-- where 조건과 동일한 형태의 제약 >> where gender in ( '남' , '여')

create table temp10(
    id number constraint pk_temp10_id primary key,
    name varchar2(20) not null,
    jumin char(6) constraint uk_temp10_jumin unique,
    addr varchar2(20),
    age number constraint ck_temp10_age check(age >= 19)
    -- 조건 where age >= 19
);

select * from user_constraints where table_name='TEMP10';

insert into temp10(id, name, jumin, addr, age)
values(100,'홍길동','12345','서울시',25);


select * from temp10;
commit;

--ORA-02290: check constraint (BITUSER.CK_TEMP10_AGE) violated
insert into temp10(id, name, jumin, addr, age)
values(200,'김유신','12345','서울시',18);
---------------------------------------------------------------
-- 참조 제약 : 테이블과 테이블과의 제약 
create table c_emp
as
    select empno, ename, deptno from emp where 1=2;


select * from c_emp;

create table c_dept
as 
    select deptno, dname from dept where 1=2;
    
select * from c_dept;

-- 참조 ( A 테이블에 있는 어떠한 컬럼의 데이터는 B 테이블에 컬럼의 데이터만 받겠다 )
-- c_emp 테이블에 있는 deptno 컬럼의 데이터는 c_dept 테이블에 있는 deptno 컬럼의 데이터를 참조하겠다.
-- 참조하겠다 ( fk ) 

alter table c_emp
add constraint fk_e_emp_deptno foreign key(deptno) references c_dept(deptno);
-- ORA-02270: no matching unique or primary key for this column-list 
-- c_dept의 deptno 는 현재 primary key 가 아니기 때문에 사용 불가능 .
-- 실행하기전에 c_dept >> deptno 컬럼에 믿음 
alter table c_dept
add constraint pk_c_dept_deptno primary key(deptno);  -- 신용확보
-- >> 
alter table c_emp
add constraint fk_e_emp_deptno foreign key(deptno) references c_dept(deptno);


-- 제약
insert into c_dept(deptno,dname) values (100,'인사팀');
insert into c_dept(deptno,dname) values (200,'관리팀');
insert into c_dept(deptno,dname) values (300,'회계팀');
commit;

select * from c_dept;

-- 신입사원 입사
insert into c_emp(empno, ename) values(100,'홍길동'); -- deptno
-- deptno fk 있어도 not null 하지 않으면 null 허용

select * from c_emp;
-- 설계 : 신입사원은 부서를 가지지 않을 수 있다


--ORA-02291: integrity constraint (BITUSER.FK_E_EMP_DEPTNO) violated - parent key not found
insert into c_emp(empno, ename,deptno) values(100,'홍길동',50);
----------------------------------------------------------------

insert into c_emp(empno, ename,deptno) values(100,'홍길동',100);

select * from c_emp;
commit;
---------------------------------------------------------------
-- 개발자
-- 테이블 ( 부모 , 자식 )
-- c_emp, c_dept [deptno] 컬럼을 기준으로 ...
-- 부모 : (master) PK를 가지고 있는 테이블이 부모..  c_dept
-- 자식 : (detail) FK를 가지고 있는 테이블은 자식..  c_cmp

-- c_dept 에서 100이라는 데이터를 삭제할 수 있을까요 ?
delete from c_dept where deptno = 100; -- 100이라는 데이터를 자식 쪽에서 사용 하고 있어서 삭제 불가능.
-- ORA-02292: integrity constraint (BITUSER.FK_E_EMP_DEPTNO) violated - child record found
-- 삭제하고싶으면 먼저 자식 쪽 데이터를 삭제한 후 부모쪽 데이터 삭제 가능.
delete from c_dept where deptno = 200; -- 자식테이블 쪽에서 데이터를 쓰고 있지 않기 때문에 삭제 가능

commit;

/*
(column datatype [CONSTRAINT constraint_name]       
REFERENCES table_ name (column1[,column2,..] [ON DELETE CASCADE]) 

column datatype, . . . . . . . , 
[CONSTRAINT constraint_name] FOREIGN KEY (column1[,column2,..])        
REFERENCES table_name  (column1[,column2,..] [ON DELETE CASCADE]) 
*/
-- [ON DELETE CASCADE]  부모테이블과 생명을 같이 하겠다
-- 300 삭제 할 있나요?  네 
-- delete from c_dept where detpno=300;
-- 참조하는 자식 데이터 같이 삭제
-- delete from c_emp where deptno=300; 같이 실행

alter table c_emp
add constraint fk_emp_deptno foreign key(deptno) references c_dept(deptno) 
ON DELETE CASCADE;

-- MS-SQL
-- on delete cascade
-- on update cascade






