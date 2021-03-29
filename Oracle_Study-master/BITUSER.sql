/*
[1���� ����]
1. ����Ŭ ����Ʈ���� �ٿ�ε�
https://www.oracle.com/technetwork/database/enterprise-edition/downloads/index.html

2. Oracle Database 11g Release 2 Express Edition for Windows 64 (���ἳġ)

3. Oracle ��ġ(SYS, SYSTEM ������ ���� ��ȣ : 1004)

4.Sqlplus ���α׷� ����(CMD) : GUI ȯ�� �Ϲݰ����� ��� ����

5.������ Tool ��ġ ����(SqlDeveloper , https://dbeaver.io/)  ,
                 ����(��� , ������ , SqlGate) ������Ʈ�� ��ġ Ȱ�� ^^

6. SqlDeveloper ���� ���ؼ� Oracle Server ���� ....
   >> HR ���� : ��ȣ 1004 , Unlock 2���� ��밡�� .... (������� �ǽ� ���̺�)
   >> ���ο� ���� : BITUSER

7. ���� ���� ���� Ȯ�� : show user;   >> USER��(��) "BITUSER"�Դϴ�.


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
�ǽ��ڵ�

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
-- 1. ��� ���̺��� ��� �����͸� ����ϼ���.
--[������]�� [��ҹ���] ����(x) 
select * from emp;

SELECT * FROM EMP;

-- 2. Ư�� �÷� ������ ����ϱ�
select empno,ename,sal
from emp;

select ename from emp;

-- 3. �÷��� ����Ī(alias) ��Ī �ο��ϱ�
select empno ���, ename �̸�
from emp;

-- SQL ǥ�� (�����͸� �ٷ�� �� ���� ����������) >> ǥ�� >> ANSI ���� 
-- as "��     ��"
-- Mysql, MS-SQL �Ʒ� ���� ����
select empno as "��    ��", ename as "��   ��"
from emp;

--Oracle ������ : [���ڿ� ������]�� �����ϰ� [��ҹ���]�� ����
--   JAVA : ���� 'A', ���ڿ� "AAA"
-- Oracle : ���ڿ� 'A', 'AAA'
-- Oracle : A, a >> �ٸ� ����
select empno, ename
from emp
where ename='king'; -- ������

select empno, ename
from emp
where ename='KING'; 

/*
select ��
from ��
where ��
*/

-- Oracle query (���Ǿ�) : ���
-- ������ (���տ����� ||, ��������� + )
-- JAVA : + ����(�������)
--        + ���ڿ�(����)
-- Tip ) ms-Sql  + (���� ���)

select '����� �̸���' || ename || '�Դϴ�' as "�������"
from emp;

-- ���̺��� �÷� >> Ÿ��
-- JAVA class Emp{private int empno}
-- Oracle create table emp (empno number)
-- Ÿ��(�÷�) : ����, ���ڿ�, ��¥
-- create table emp (ename varchar2(10));
-- 10byte >> �ѱ� 1�� : 2byte, ������,Ư������,���� : 1byte
-- �ѱ� 5��, ������ 10��

desc emp;

-- ����ȯ   ���������� �ڵ� ����ȯ (���� -> ���ڿ�) ����
select empno || ename
from emp;

select empno + ename   -- ���� + ���ڿ� ORA-01722: invalid number ������� �Ұ�
from emp;

-- ���߽�
-- �����
-- �츮ȸ���� ������ ��� �ֳ� ?
select job from emp;
-- �ߺ� ������ ���� : Ű���� - distinct
select DISTINCT job from emp;

-- distinct ���� : grouping

select DISTINCT job, deptno
from emp
order by job; -- job group �׾ȿ��� deptno group 1�Ǿ�(�ߺ����� �ʴ� ������)

select DISTINCT deptno,job
from emp
order by deptno;


-- Oracle Sql ���(������)
-- java ���� ���� ( + - * / ) ������ %
-- Oracle ����  [ % �����ڸ� �����ʴ´� ] >> ����Ŭ�� �Լ��� ���� �ִ� Mod()

-- ������̺��� ����� �޿��� 100 �޷� �λ��� ����� ����ϼ���.

select empno, ename, sal, sal + 100 as "�λ�޿�"
from emp;

-- dual �ӽ� ���̺� (����)
-- syso
select 100 + 100 from dual; -- ������ �׽�Ʈ
select 100 || 100 from dual; --100100
select '100' + 100 from dual; -- ����ȯ 200 >> '100' ������ ���ڵ����� (���� ��ȯ�ϸ� ���ڰ� ������ ������)
select 'A100' + 100 from dual;

-- �� ������
--  <   >   <=
--����
--java ���� (==)  �Ҵ� (=)   javascript(==, ===) ����
--Oracle ���� (=) ���� �ʴ� (!=)

-- �� ������
-- AND, OR, NOT

-- ������ (where) ���ϴ� row ��
select empno, ename, sal
from emp;

select empno, ename, sal
from emp
where sal >= 2000;

--����� 7788���� ����� ���, �̸�, ����, �Ի����� ���
select empno, ename, job, hiredate
from emp
where empno = 7788;

-- ����� �̸��� king �� ����� ���, �̸�, �޿�, ������ ����ϼ���
select empno,ename,sal
from emp
where ename = 'KING';

-- �޿��� 2000�޷� �̻��̸鼭 ������ manager �� ����� ��� ������ ����ϼ���
-- hint) AND, OR
select *
from emp
where sal >= 2000 AND job = 'MANAGER';

-- �޿��� 2000�޷� �̻��̰ų� �Ǵ� ������ manager �� ����� ��� ������ ����ϼ���
select *
from emp
where sal >= 2000 OR job = 'MANAGER';

-- ����Ŭ ��¥ ( DB ������ ��¥)
-- ����Ŭ ��¥ Ű����(sysdate) 
select sysdate from dual; -- 21/03/02
-- ����Ŭ�� ��ġ�� PC�� �ð� (������ �ð�)

-- ��� �ý��� ��¥ �ʼ� ����
-- �Խ���
-- insert into board(writer, title, content, regdate)
-- values('ȫ�浿','�氡','������',sysdate);
-- regdate �÷��� �����ʹ� ������ �ð�
-- Tip) ms-sql : select getdate()

-- ����Ŭ ����(ȯ�� ���� -> ��¥ )
select * from nls_session_parameters;

--NLS_DATE_FORMAT    >>  RR/MM/DD
--NLS_DATE_LANGUAGE	 >>  KOREAN
--NLS_TIME_FORMAT    >>  HH24:MI:SSXFF

-- �Ϲ������� 2021-03-02
-- ���� ������ ���� ����Ŭ�� ������ ������� �۾� ȯ�游 ����
-- �׷��� ������ �����ٰ� ������ �ϸ� �������·� ����
-- ���� session���� �ݿ�
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
where hiredate='80/12/17'; -- ���� format (yyyy-MM-DD)

-- ����� �޿��� 2000�̻��̰� 4000������ ��� ����� ������ ����ϼ���
select *
from emp
where sal >= 2000 and sal <= 4000;


-- ������ : �÷��� between A and B (= ����)
select *
from emp
where sal between 2000 and 4000;

-- �μ���ȣ�� 10�� �Ǵ� 20�� �Ǵ� 30���� ����� ���, �̸�, �޿�, �μ���ȣ�� ����ϼ���
select empno, ename, sal, deptno
from emp
where deptno between 10 and 30;
-- ������ ( IN ������ )
select *
from emp
where deptno in (10,20,30);

-- �μ���ȣ�� 10�� �Ǵ� 20���� �ƴ� ����� ���, �̸�, �޿�, �μ���ȣ�� ����ϼ���
select empno, ename, sal, deptno
from emp
where deptno!=10 and deptno!=20;
-- IN ���������� ( NOT IN )
select empno,ename,sal,deptno
from emp
where deptno not in(10,20);

-- POINT : Oracle ���� ���� ( ������ ���� ) >> null
-- �� ��� (null)

create table member(
    userid VARCHAR2(20) not null, -- null ������� �ʰڴ�. (�ʼ� �Է�)
    name VARCHAR2(20) not null, -- �ʼ� �Է�
    hobby VARCHAR2(50) -- defalut null ( �⺻������ null ���) �����Է�
);
    
select * from member;
-- ȸ������ ����
insert into member(userid,hobby) values('hong','��'); -- x
--ORA-01400: cannot insert NULL into ("BITUSER"."MEMBER"."NAME")
insert into member(userid,name) values('hong','ȫ�浿');
-- hobby �÷��� ������ : null ä������
select * from member;

-- point ( INSERT, UPDATE, DELETE )
-- ���� �ݿ��� ���ؼ��� 
-- �ݵ�� commit �� �ؾ��Ѵ�. <-> ( rollback )
commit;



-- ������ �����ϰ� �ٽ� �ǽ�
delete from member;
commit;


-- ����(comm) �� ���� �ʴ� ��� ����� ������ ����ϼ���
-- 0�� ������(�޴� ����)
select comm from emp;

select *
from emp
where comm = null; -- �̷� ������ ����.
-- null �񱳴� (is null, is not null) �ϱ�

select *
from emp
where comm is null;

-- ����(comm) �� �޴� ��� ����� ������ ����ϼ���
select *
from emp
where comm is not null;

-- ������̺��� ���, �̸�, �޿�, ����, �ѱ޿��� ����ϼ���
-- �ѱ޿�(�޿� + ����)
select empno, ename, sal, comm, sal + comm as "�ѱ޿�"
from emp;

-- POINT null �̶� �༮...
-- 1. null���� ��� ������ ����� : null   ex) 100+null : null, 100-null : null
-- 2. �� ������ �ذ��ϱ� ���ؼ� �Լ��� ���� >> nvl(), nvl2()
-- nvl(�÷���, ��ü��) >> ��ü������ ġȯ
-- Tip) MS-sql : null > convert()
--      my-sql : null > IFNULL()

select empno, ename, sal, comm, sal + nvl(comm,0) as "�ѱ޿�"
from emp;

-- comm �÷����� null �����͸� ������  0���� ġȯ�ؼ� �����ض�

select 1000 + null from dual;

select 1000 + nvl(null,100) from dual;

select comm, nvl(comm,111111) from emp;

-- ����� �޿��� 1000 �̻��̰� ������ ���� �ʴ� ����� ���, �̸�, ����, �޿�, ������ ����ϼ���
select empno, ename, job, sal, comm
from emp
where sal >= 1000 AND comm is null;

-- DQL ( data query language ) : select
-- DDL : ���Ǿ� - create, alter, drop ( Table emp, dept) ��ü
-- DML : ���۾� - insert, update , delete ( �ݵ�� �۾� �� ���� 
--      �� �ݿ� : commit 
--    �۾� ��� : rollback ��ɾ� �ݵ�� ����

-- create table board (boardno number)
-- JAVA : class board (private int boardno)

create table Board(
    boardid number not null, -- ����, �ʼ� �Է�
    title varchar2(50) not null, -- ������(�ѱ� 25��, ������ 50�� ����) �ʼ� �Է�
    content varchar2(2000) not null, -- �۳���(�ѱ� 1000��, ���� 2000�� ����) �ʼ� �Է�
    hp varchar2(20) -- default null   �ʼ� �Է� x (null �� ���)
);

select * from USER_TAB_COLUMNS where table_name='BOARD';

-- create, alter, drop >> commit, rollback ( x )
-- commit, rollback ( insert, update, delete ) �۾� �ÿ��� 

select * from board;

insert into board(boardid, title,content)
values(100,'����Ŭ','�Ǽ��߳�^^');

-- ������ �߸� �־��� ....  ��� > rollback
rollback;

-- ������ �ݿ� �ؾ���
commit;

/*
-- Tip) MS-SQL : default - auto_commit 
insert into emp(empno) values(100); �ڵ� Ŀ��

begin 
    insert into emp(empno) values(100);

rollback or commit �Ҷ����� ���.

Tip_ : Oracle�� �����ڰ� commit �Ǵ� rollback�� �����ϱ� ������ �� �ݿ����� �ʴ´�.
*/

select * from board;
commit;

insert into board(boardid,title,content)
values(200,'�ڹ�','�׸���');

insert into board(boardid,title,content)
values(300,'�ڹ�','������ ������');

select * from board;
-- rollback�� commit�� ���� ������ �ǵ�����
rollback;

select boardid, title, content, nvl(hp,'EMPTY') as "HP"
from board; -- nvl�Լ� �߿�

-- ���ڿ� �˻�
-- �ּҰ˻� : �˻��� - ���� -> ���� �ܾ ���Ե� ��� �ּҰ� �ٳ��´� ( LIKE ���� �˻� )
-- ���ڿ� ���� �˻�( LIKE ������ )

-- like ������ ( ���ϵ� ī�� ���� : 1. %(����), 2. _(�ѹ���) ���� ������ ����
-- �˻��� ������ >> ���� �˻��� ���� ����ǥ���� ( JAVA ����ǥ���� ����Ŭ�� ���� )

select * 
from emp
where ename like '%A%'; -- ename �÷��� �����Ͱ� A �� �����ϰ� �ִ��� Ȯ��

select * 
from emp
where ename like '%a%'; -- ��ҹ��ڸ� �����ϰ� ����

select * 
from emp
where ename like 'A%'; -- �̸��� ù ���ڰ� A �� ��� ���

select * 
from emp
where ename like '%E'; 

-- ���� �ܾ ����ִ� �ּҸ� �� ã�ƶ�
-- selete * from zip where dong like '%����%';

-- selete * from member where name like '��%';

select * 
from emp
where ename like '%LL%';

select * 
from emp
where ename like '%A%A%';

select ename
from emp
where ename like '_A%'; -- ù���ڴ� ����� �͵� �������, �ι�° ���ڴ� A�� �����ϴ� ��� �̸�

select ename
from emp
where ename like '__A%';

-- ����Ŭ ���� (regexp_like) �󼼰˻�
select * from emp where REGEXP_LIKE (ename,'[A-C]');
-- ����Ŭ ����� �� �ִ� ���� ǥ�� �˻� 5�� ����� (EMP)

select *
from emp;

----------------------- 21-03-03 ���� -----------------------
-- ������ �����ϱ�
-- order by �÷��� : ����, ����, ��¥����
-- �������� : asc  - ������ : default
-- �������� : desc - ������

select *
from emp
order by sal; -- defalut asc

select *
from emp
order by sal asc;

-- �޿��� ���� �޴� ������ ����
select *
from emp
order by sal desc;

-- �Ի����� ���� ���� ������ �����ؼ� ���, �̸�, �޿�, �Ի����� ����ϼ���
select empno, ename, sal, hiredate
from emp
order by hiredate desc;

select empno, ename
from emp
order by ename asc; -- ���ڿ� ���İ���
/*
select ��       3����
from ��         1����
where ��        2����
order by ��     4���� ( select �� ����� ���� )
*/

-- �ؼ�
select empno, ename, sal, job, hiredate
from emp
where job='MANAGER'
order by hiredate desc;

--order by �÷��� asc, �÷��� desc, �÷��� asc
--POINT(�亯�� �Խ���) �ʼ�
select job, deptno
from emp
order by job asc, deptno desc; 
-- group��
-- ������ �������� ���������ϰ�, ������ �׷��� ������ �������� ���������Ѵ�

-- ������
-- ������ ( union ) : ���̺�� ���̺��� �����͸� ��ġ�� ��  ( �ߺ����� ���� )
-- ������ ( union all ) : �ߺ��� ���

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
union   -- �ߺ� ������ ����
select * from uta;


select * from ut
union all 
select * from uta;

-- union
-- 1. �����Ǵ� �÷��� Ÿ���� ����
select empno, ename from emp  -- empno ����Ÿ��
union
select job, deptno from dept; -- job ���ڿ�Ÿ��

-- 2. �����Ǵ� �÷��� ������ ����
select empno, ename, job, sal from emp  -- �÷� 4��
union
select deptno, dname, loc from dept;   -- �÷� 3��
-- 2-1. �����Ǵ� �÷��� ������ ����
--�ʿ�� : null
select empno, ename, job, sal from emp  -- �÷� 4��
union
select deptno, dname, loc, null from dept;   -- �÷� 3�� 
-- �÷��� ���߱����� null�� ��ü
---------------------------------------------------------------
-- �ʺ� �����ڰ� �ǹ������� �ؾ��ϴ� �۾� ( �������̺� select )
---------------------------------------------------------------

-- Tip
--����Ŭ �Լ� ......
select * from SYS.NLS_DATABASE_PARAMETERS;
--NLS_CHARACTERSET  : 	AL32UTF8  �ѱ� 3byte �ν�
--KO16KSC5601 2Byte (���� ��ȯ�ϸ� �ѱ� �ٱ���)
select * from nls_database_parameters where parameter like '%CHAR%';
------------------------------------------------------------------------------
create table test2(name varchar2(2));

insert into test2(name) values('a');
insert into test2(name) values('aa');
insert into test2(name) values('��'); --�ѱ� 1�� 3byte ����
-- value too large for column "BITUSER"."TEST2"."NAME" (actual: 3, maximum: 2)
-------------------------------------------------------------------------------
-- [2����]
-- ����Ŭ �Լ� ����
/*
���� �� �Լ��� ����
1) ������ �Լ� : ���ڸ� �Է� �ް� ���ڿ� ���� �� ��θ� RETURN �� �� �ִ�.
2) ������ �Լ� : ���ڸ� �Է� �ް� ���ڸ� RETURN �Ѵ�.
3) ��¥�� �Լ� : ��¥���� ���� �����ϰ� ���ڸ� RETURN �ϴ� MONTHS_BETWEEN �Լ���
�����ϰ� ��� ��¥ ���������� ���� RETURN �Ѵ�.
4) ��ȯ�� �Լ� : � ���������� ���� �ٸ� ������������ ��ȯ�Ѵ�.
5) �Ϲ����� �Լ� : NVL, DECODE
*/

-- ���ڿ� �Լ�
select initcap('the super man') from dual; -- initcap �ܾ� �ձ��� �빮�ڷ� ����
select lower('AAA'), --  lower (�빮�� -> �ҹ���) 
upper('aaa') from dual; -- upper ( �ҹ��� -> �빮�� )
select ename, lower(ename) as "ename" from emp;
select * from emp where lower(ename) = 'king';

select length('ABCD') from dual;   -- length ( ���ڿ� ����)
select length('ȫ�浿') from dual;  -- 3��

select length('  ȫ �� �� a') from dual; -- 9�� ( �������� )

-- ���� ������ : ||
-- concat()
select 'a' || 'b' || 'c' as "data"
from dual; -- abc

--select concat('a','b','c') from dual; -- concat �� �Ķ���Ͱ����� 2�� ������ ���� ����
select concat('a','b') from dual;

select ename || '                ' || job from emp;
select concat(ename,job) from emp;

-- �κ� ���ڿ� ���� 
-- JAVA ( substring )
-- Oracle ( substr )
select substr('ABCDE',2,3) from dual; -- BCD
select substr('ABCDE',1,1) from dual; -- A
select substr('ABCDE',3,1) from dual; -- C

select substr('ABCDEsfasfsafsa',3) from dual; -- 3�� °���� �ڿ����� ��ü ���
select substr('ABCDE',-2,1) from dual; -- �ڿ��� ���� 2��° 'D'
select substr('ABCDE',-2,2) from dual; -- DE

-- ������̺��� ename �÷� �����Ϳ� ���ؼ� ù���ڴ� �ҹ��ڷ� ������ ���ڴ� �빮�ڷ� ����ϵ�
-- �ϳ��� �÷����� ���� ����ϼ���
-- �÷��� ��Ī�� : fullname
-- ù���ڿ� ������ ���� ���̿��� ���� �ϳ��� ��������
-- SMITH >> s MITH ���

select lower(substr(ename,1,1)) || ' ' || substr(ename,2) as "fullname"
FROM emp;

-- lpad, rpad ( ä��� )
select lpad('ABC',10,'*') from dual; -- *******ABC
select rpad('ABC',10,'%') from dual; -- ABC%%%%%%%

-- ������� ��� : hong1007
-- ȭ�� : ho******
-- ��� : 1004 > 10**

select rpad(substr('hong1007',1,2),length('hong1007'),'*') as "pwd" from dual;   -- ho******

select rpad(substr('1004',1,2),length('1004'),'*') as "pwd" from dual; -- 10**

-- emp ���̺��� ename �÷��� �����͸� ����ϵ� ù���ڸ� ����ϰ� �������� * �� ����ϼ���
select rpad(substr(ename,1,1),length(ename),'*') as "ename" from emp;

-- rtrim �Լ�
-- (������ ����)�� ������
select rtrim('MILLER', 'ER') from dual; -- MILL

-- ltrim 
-- (���� ����)�� ������
select ltrim('MILLLLLLLLLLLER', 'MIL') from dual; -- ER

-- ���� �����ϴµ� Ȱ����
select '>' || rtrim('MILLER       ',' ') || '<' from dual;

-- ġȯ�Լ� ( replace )
select ename, replace(ename,'A','�Ϳ�') from emp;
--------------------------------------------------------------------------------
-- [ ���� �Լ� ]

-- round() (�ݿø� �Լ�)
--  -3  -2  -1  0(����)  +1  +2  +3  +4  
select round(12.345,0) as "r" from dual;  -- 12 �����κи� ���ܶ�.
select round(12.567,0) as "r" from dual;  -- 13

select round(12.345,1) as "r" from dual;  -- 12.3
select round(12.567,1) as "r" from dual;  -- 12.6

select round(12.567,-1) as "r" from dual; -- 10
select round(15.345,-1) as "r" from dual; -- 20
select round(15.345,-2) as "r" from dual; -- 0

-- trunc() (���� �Լ�)
--  -3  -2  -1  0(����)  +1  +2  +3  +4  
select trunc(12.345,0) as "t" from dual; -- 12
select trunc(12.567,0) as "t" from dual; -- 12

select trunc(12.345,1) as "t" from dual; -- 12.3
select trunc(12.567,1) as "t" from dual; -- 12.5

select trunc(12.345,-1) as "t" from dual; -- 10
select trunc(15.567,-1) as "t" from dual; -- 10
select trunc(15.567,-2) as "t" from dual; -- 0

-- mod() (������ ���ϴ� �Լ�)
select 12/10 from dual;   -- 1.2
select mod(12,10) from dual; -- ������ 2

select mod(0,0) from dual; -- 0
-----------------------------------------------------------------------
--[ ��¥ �Լ� ]
-- alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';
select sysdate from dual;

-- POINT (��¥ ����)
-- 1. Date + NUMBER >> Date
-- 2. Date - NUMBER >> Date
-- 3. Date - Date >> Number
select sysdate + 100 from dual; -- 2021-06-11 12:04:02
select sysdate + 1000 from dual; -- 2023-11-28 12:04:21

select hiredate from emp;
-- �Լ� 
select trunc(months_between('2018-02-27','2010-02-20'),0) from dual; -- 96����

select months_between(sysdate,'2010-03-03') from dual; -- 132����

select '2019-03-03' + 100 from dual;
--POINT to_date() ��ȯ�Լ�
select to_date('2019-03-03') + 100 from dual;

-- ��� ���̺��� ������� �Ի��Ͽ��� ���糯¥���� �ټӿ����� ���ϼ��� ( ����̸�, �Ի���, �ټӿ��� )
-- �� �ټӿ����� �����κи� ����ϼ��� ( �ݿø� ���� ������ )
select ename, hiredate, trunc(months_between(sysdate,hiredate),0) as "�ټӿ���"
from emp;

-- 2. �Ѵ��� 31�� �̶�� ���ؿ��� �ټӿ����� ���ϼ��� ( �ݿø� ���� ������ ) ( �Լ���� x ) ��¥ - ��¥ >> 150�� �ҿ�
select trunc((sysdate - hiredate)/31,0) as "�ټӿ���" from emp;
------------------------------------------------------------------------------
--[��ȯ�Լ�] TODAY POINT
-- Oracle ������ : ���ڿ�, ����, ��¥
-- to_char() : ���� -> ���� ( 1000 - > $100,000 )  �������
--             ��¥ -> ���� ( '2021-03-03' -> 2021��03��03�� )  �������

-- to_date() : ���� -> ��¥ 
select to_date('2019-03-03') + 100 from dual;

-- to_number() : ���� -> ���� >> �ڵ� ����ȯ�� �־ ���� ��� ����
select '100' + 100 from dual; -- [������ ����]�� �ڵ� ����ȯ �ȴ�.
select to_number('100') + 100 from dual; --(������ ǥ��) ���� ���� �ʴ´�.

-------------------------------------------------------------------------------
/*
create table ���̺�� (�÷��� Ÿ��, �÷��� Ÿ�� ...)
create table member (age number); insert .... 1�� ~ 1000��
insert into member(age) values(100);
.... 100�� insert 

insert into member(age) values(100);
insert into member(age) values(200);
insert into member(age) values(300);
insert into member(age) values(400);
....


[Java] ��� �Ѵٸ�
class member {private int age; }
1�� -> ��ü 1��
member m = new member();
m.setAge(100);

100��
List<member> mlist = new ArrayList<member>();
mlist.add(new member(100));
mlist.add(new member(200));
mlist.add(new member(300));
mlist.add(new member(400));
.....

������ Ÿ��
���ڿ� Ÿ��
char(10)      >> 10byte >> �ѱ� 5��, ������ Ư������ ���� 10��,      char : �������� ���ڿ�
varchar2(10)  >> 10byte >> �ѱ� 5��, ������ Ư������ ���� 10��,  varchar2 : �������� ���ڿ�

char(10)     >> 'abc' >> 3byte >> [a] [b] [c] [] [] [] [] [] [] [] []   >> ������ ��ȭ�� ����
varchar2(10) >> 'abc' >> 3byte >> [a] [b] [c]  >> ������ ũ�� ��ŭ�� ���� Ȯ��

-- �ѱ� 1�� 3byte ( ��, �� )
create table member(gender char(3));
create table member(gender varchar2(3));
-- ����(char) 


create table member(gender char(30));  >> ����� �̸�
create table member(gender varchar2(30));

��� : �������� ������ ( ��,�� ... ��, ��, �� ... �ֹι�ȣ ) char
       �������� ������ ( ���÷� �ٲ�� ������ ( ����̸� , �ּ�, ��� ) varchar2 

char() varchar2 ���� : �ѱ�, ������ Ư������ ���� ȥ�� ����ϸ� ���� �߻�
varchar2(10)

unicode ( 2byte ) : �ѱ�, ������, Ư������ , ���� >> 2byte 

nchar(20) >> 20���� >> 2 * 20 >> 40byte 
nvarchar2(20) >> 20���� >> 2 * 20 >> 40byte

�ѱ� ��ȭ���� n (�����ڵ�)�� ���� ����Ѵ�.
*/

create table test3(name nchar(2), ename nvarchar2(2));

insert into test3(name) values('a');
insert into test3(name) values('��');

insert into test3(name) values('ab');
insert into test3(name) values('����');

insert into test3(name) values('abc'); -- 3����  value too large for column
insert into test3(ename) values('������'); -- value too large for column
commit;

select * from test3;

-- 1. to_number() ���� -> ���ڷ� (�ڵ� ����ȯ)
select '1' + 1 from dual;
-- ��Ģ
select to_number('1') + 1 from dual;

-- 2. to_char() ���� -> ���Ĺ���  , ��¥ -> ���Ĺ���
select sysdate, to_char(sysdate,'YYYY') || '��' as "YYYY",
                to_char(sysdate,'YEAR'),  
                to_char(sysdate,'MM'),     
                to_char(sysdate,'DD'),
                to_char(sysdate,'DAY'),
                to_char(sysdate,'DY')
from dual;                    


-- �Ի����� 12���� ����� ���, �̸�, �Ի���, �Ի�⵵, �Ի���� ����ϼ���
select empno, ename, hiredate, to_char(hiredate,'MM') as "�Ի���", to_char(hiredate,'YYYY') as "�Ի�⵵"
from emp
where to_char(hiredate,'MM') = '12';


select to_char(hiredate, 'YYYY MM DD') from emp;
select to_char(hiredate, 'YYYY"��" MM"��" DD"��"') from emp; -- ������

-- to_char() : ���� -> ���Ĺ���
-- ����Ŭ.pdf ( 71 page ǥ ���� )
-- 10000000   -> $1,000,000,000

select '>' || to_char(12345,'9999999999') || '<' from dual;  -- >      12345<
select '>' || to_char(12345,'0999999999') || '<' from dual;  -- > 0000012345<

select '>' || to_char(12345,'$9,999,999,999') || '<' from dual;

select sal, to_char(sal,'$999,999,999') from emp;

-- HR ����
select * from employees;
select sysdate from dual;
--alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';

/*
������̺� (employees) ���� ����� �̸��� last_name, first_name ���ļ� fullname ��Ī �ο��ؼ� ����ϰ�
�Ի����� YYYY-MM-DD �������� ����ϰ� ����(�޿�*12) ���ϰ� ������ 10%(���� * 1.1) �λ��� ����
����ϰ� �� ����� 1000���� �޸� ó���ؼ� ����ϼ���
�� 2005�� ���� �Ի��ڵ鸸 ����ϼ��� �׸��� ������ ���� ������ ����ϼ���
*/

select last_name || first_name as "fullname", 
    to_char(hire_date, 'YYYY-MM-DD') as "�Ի���",
    to_char((salary * 12),'999,999') as "����" , 
    to_char((salary * 12) * 1.1,'999,999') as "���� 10%�λ�"
from employees
where to_char(hire_date, 'YYYY') >= '2005'
--order by salary * 12 desc;
order by "����" desc;

-- order by ���� select�� ������ �ִ� ��Ī(as)�� ��� �� �� �ִ�. �� ������ ���� ���� ������.
-----------------------------------------------------------------------------
--�����Լ�
--��¥�Լ�
--�����Լ�
--��ȯ�Լ�(to_char(), to_number(), to_date())
-----------------------------------------------------------------------------
-- �Ϲ��Լ�(���α׷� ������ ���� ���� �Լ�)
-- nvl(), nvl2() >> null �� ó���ϴ� �Լ�
-- decode() >> java if�� ó�� ���
-- case()   >> java switch ó�� ���

-- ����Ŭ SQL ( ����, ��� ������ ���� )
-- ����Ŭ PL-SQL ( ����, ��� ��밡�� ) ��ޱ��


select comm, nvl(comm,0) from emp;

create table t_emp(
 id number(6), -- ���� 6�ڸ�
 job nvarchar2(20)
 );
 
insert into t_emp(id, job) values (100,'IT');
insert into t_emp(id, job) values (200,'SALES');    
insert into t_emp(id, job) values (300,'MGR');    
insert into t_emp(id) values (400);    
insert into t_emp(id, job) values (500,'MGR');    
commit;

select * from t_emp;

select id, decode(id, 100,'����Ƽ',
                      200,'������',
                      300,'������',
                      '��Ÿ�μ�') as "�μ��̸�"
from t_emp;

select empno, ename, deptno, decode(deptno, 10, '�λ��',
                                             20, '������',
                                             30, 'ȸ���',
                                             40, '�μ�',
                                             'ETC') as "�μ��̸�"
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
t_emp2 ���̺��� id, jumin �����͸� ����ϵ� jumin �÷��� ���ڸ��� 1�̸�
'����' ��� 2�̸� '����' 3�̸� '�߼�' �׿ܴ�  '��Ÿ' ��� ����ϼ���
�÷����� '����'
*/

select decode(substr(jumin,1,1), 1,'����',
                                 2,'����',
                                 3,'�߼�',
                                   '��Ÿ') as "����"
                    
                    
from t_emp2;

/*
if ���ȿ� if �� ( ��ø ) 

�Ʒ� �ڵ� decode() �Լ� �۾��ϱ�
-- Ŀ�� ���� ���� �� .....
�μ���ȣ�� 20���� ����߿��� SMITH ��� �̸��� ���� ����̶�� HELLO ���� ����ϰ�
�μ���ȣ�� 20���� ����߿��� SMITH ��� �̸��� ���� ����� �ƴ϶�� WOLRD ���� ����ϰ�
�μ���ȣ�� 20���� ����� �ƴ϶�� ETC ��� ���ڸ� ����ϼ���

*/

select decode(deptno, 20,decode(ename,'SMITH','HELLO','WOLRD'),'ETC')
from emp;

-- CASE ��
-- java switch
/*
case ���ǽ� WHEN ���1 THEN ���1
           WHEN ����2 THEN ���2
           WHEN ����3 THEN ���3
           ELSE ���4
END "�÷���"
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

select '0' || to_char(zipcode), case zipcode when 2 then '����'
                                             when 31 then '���'
                                             when 32 then '����'
                                             when 41 then '����'
                                             else '��Ÿ����'
                                    end "�����̸�"
from t_zip;                                    
                                    
                                    
-- case �÷��� when ��� then ���
-- case when [�÷��� ���� �񱳽�] then
select sal , case when sal<=1000 then '4��'
                  when sal>=1001 and sal<=2000 then '3��'
                  when sal>=2001 and sal<=3000 then '4��'
                  when sal>=3001 and sal<=4000 then '4��'
                  else 'Ư��'
                  end "����޿�"
from emp;
------------------------------------------------------------------------
--�����Լ�
--�����Լ�
--��¥�Լ�
--��ȯ�Լ� ( to_char(), to_date(), to_number())
--�Ϲ��Լ� nvl(), decode(), case ����
-- �⺻�Լ� end --
------------------------------------------------------------------------
-- ����(�׷�) �Լ�
-- ����Ŭ.pdf (75page)

-- 1. count(*) >> row�� , count(�÷���) >> ������ �Ǽ� ( null�� �������� �ʴ´� )
-- 2. sum() 
-- 3. avg()
-- 4. max()
-- 5. min()
-- ��Ÿ
-- 1. �����Լ��� group by ���� ���� ���
-- 2. ��� �����Լ��� null ���� �����Ѵ�
-- 3. select ���� �����Լ� �̿��� �ٸ� �÷��� ���� �ݵ�� �� �÷��� group by ���� ���

select count(*) from emp; -- 14�� ������ �Ǽ��� �ƴϰ� row ��

select count(empno) from emp; -- 14��

select count(comm) from emp; -- 6��  null �� ����

select comm from emp;
-- comm �÷��� �����͵� 14�� ������ �ʹ�.
select count(nvl(comm,0)) from emp;

select sum(sal) as "�޿��� ��" from emp;
select round(avg(sal),0) as "�޿��� ���" from emp;

-- ����� �츮ȸ�� �� ������ �󸶳� ���� �Ǿ���
select sum(comm) from emp;

-- ������ ���
select trunc(avg(comm),0) from emp; -- 721

select trunc(sum(comm)/14,0) from emp; -- 309

select trunc(avg(nvl(comm,0))) from emp; -- 309


select max(sal) from emp;
select min(sal) from emp;

select empno, count(empno) from emp; -- ORA-00937: not a single-group group function

select sum(sal), avg(sal), max(sal), min(sal), count(sal) from emp;
--------------------------------------------------------------------------
--�μ��� ��� �޿��� ���ϼ���
select deptno, avg(sal) 
from emp
group by  deptno;

--������ ��� �޿��� ���ϼ���
select job, avg(sal)
from emp
group by job;

--������ ��ձ޿�, �޿��� ��, �ִ�޿� , �ּұ޿�, �Ǽ� ����ϼ���
select job, avg(sal), sum(sal), max(sal), min(sal), count(sal)
from emp
group by job;
/*
grouping

distinct �÷���1, �÷���2

order by �÷���1, �÷���2

group by �÷���1, �÷���2

*/

-- �μ���, ������ �޿��� ���� ���ϼ���
select deptno, job, sum(sal), count(sal)
from emp
group by deptno, job;


/* 
select     5��
from       1��
where      2��
group by   3��
having     4��
ordey by   6��
*/

-- ������ ��ձ޿��� 3000�޷� �̻��� ����� ������ ��ձ޿��� ����ϼ���
select job, avg(sal) as "��ձ޿�"
from emp
group by job
having avg(sal) >= 3000;
-- having ������  select �� ����Ī ��� �Ұ� 
-- ��������� having�� ���� ���� �Ǳ� ������
/*
1. from ������  *where
2. group by ���� ������ *having
*/


/* ������̺��� ������ �޿����� ����ϵ� ������ ���� �ް� �޿��� ���� 5000 �̻��� ������� ����� ����ϼ���
-- �޿��� ���� ���� ������ ����ϼ���*/
select job, sum(sal) as "�޿�����"
from emp
where comm is not null
group by job
having sum(sal) >= 5000
order by sum(sal) asc;

/* ������̺��� �μ� �ο��� 4���� ���� �μ��� �μ���ȣ, �ο���, �޿��� ���� ����ϼ��� */
select deptno, count(deptno) as "�ο���", sum(sal) as "�޿��� ��"
from emp
group by deptno
having count(deptno) > 4;

/* ������̺��� ������ �޿��� ���� 5000�� �ʰ��ϴ� ������ �޿��� ���� ����ϼ���
�� �Ǹ�����(salesman) �� �����ϰ� �޿����� �������� �����ϼ��� */
select job, sum(sal) as "�޿��� ��"
from emp
where job != 'SALESMAN'
group by job
having sum(sal) > 5000
order by "�޿��� ��" desc;

---------------------------------------------------------
------------------2021-03-04 ����-------------------------

--JOIN
--�������̺��� ������ ��������
--RDBMS ( �Ѱ� �̻��� ���̺���� ���� ���踦 ������ �ִ� ���� )
--JOIN : �����͸� ������ ���� ���
--����
-- 1 : 1
-- 1 : N 
-- M : N

--���� �ǽ� ���̺� �����ϱ�--
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


-- ����
-- 1. ����� (equi join) 70%�� �̰� ���.
-- �����̺�� ������� ���̺� �ִ� �÷��� �����͸� 1 : 1 ����

--����
-- 1. SQL JOIN ���� ( ����Ŭ ���� ) >> �����ϰ� ��� ����
-- 2. ANSI ���� ( ǥ�� ) ���� : ������ ��� >> [inner] join on ������
select *
from m , s
where m.m1 = s.s1;

select m.m1 , m.m2 , s.s2
from m , s
where m.m1 = s.s1;

-- ANSI
select m.m1 , m.m2 , s.s2
from m join s   -- inner �Ϲ������� ����
on m.m1 = s.s1;

select m.m1 , m.m2 , x.x2
from m join x
on m.m1 = x.x1;

-- emp, dept
-- �����ȣ, ����� �̸�, �μ���ȣ, �μ��̸��� ����ϼ���
select emp.empno, emp.ename, emp.deptno , dept.dname
from emp join dept
on emp.deptno = dept.deptno;

-- ���� : ���̺� ���� ���.
-- join ���̺��� ��Ī
select e.empno, e.ename , e.deptno , d.dname
from emp e join dept d
on e.deptno = d.deptno;

-- join
-- ���̺� 2��, 3��, 4�� �ϼ��� �ִ�.
-- SQL join 
select * 
from m , s , x
where m.m1 = s.s1 and s.s1 = x.x1;

-- ANSI JOIN   > �̰ɷ� ���
select m.m1 , m.m2 , s.s2 , x.x2
from m join s on m.m1 = s.s1 
       join x on s.s1 = x.x1;
       
-- a(a1) , b(b1) , c(c1) , d(d1)       
from a join b on a.a1 = b.b1
       join c on c.c1 = b.b1
       join d on d.d1 = c.c1;
       
-- HR �������� �̵�
select * from employees;
select * from departments;
select * from locations;
       
-- 1. ���, �̸�(last_name), �μ���ȣ, �μ��̸��� ����ϼ���
select e.employee_id , e.last_name , e.department_id, d.department_name
from employees e join departments d
on e.department_id = d.department_id;

-- 1. ���, �̸�(last_name), �μ���ȣ, �μ��̸�, �����ڵ�, ���ø� �� ����ϼ���
select e.employee_id , e.last_name , e.department_id, d.department_name , l.location_id  , l.street_address
from employees e join departments d on e.department_id = d.department_id
                 join locations l on l.location_id = d.location_id;
                 
-----------------------------------------------------------------------
select * from emp;

-- 2. �� ����(non-equi join ) => 1:1�� ���� �÷��� ����
-- >> �ǹ̸� ���� >> ����� ����
-- join : �÷��� �÷��� 1:1 ���� emp.depno = dept.deptno
select * from emp;
select * from salgrade;
                 
-- �� ����                 
select e.empno, e.ename , e.sal , s.grade
from emp e join salgrade s
on e.sal between s.losal and s.hisal;
                 
-- 3. outer join (equi join + null(������)
-- outer join >> 1. equi join �����ϰ� > 2. �� ���� �ǻ� ���� (���� �����͸� ��� ������ ������ )
-- outer join join���̺��� ���� ���踦 �ľ�
-- ���εǴ� ���̺��� ���� �����͸� ���� �� �� �ִ�
-- ����
-- 1. left [outer] join ( ���� ���̺��� ���� )
-- 2. right [outer] join ( ������ ���̺��� ���� )
-- 3. full [outer] join ( left �� right join >> union )

-- SQL ���� ( ������� x )
select *
from m join s
on m.m1 *= s.s1;

-- ANSI ����
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
-- 1. ���, �̸�(last_name), �μ���ȣ, �μ��̸��� ����ϼ���
select e.employee_id , e.last_name , e.department_id, d.department_name
from employees e left join departments d
on e.department_id = d.department_id;


-- 4. self join ( �ڱ� ���� ) > ������ ���� �ǹ̸� �����Ѵ� >> ����(�����)
-- �ϳ��� ���̺� �÷��� �ڽ��� ���̺� �ִ� �ٸ� �÷��� �����ϴ� ���

-- join �⺻ ���̺� 2��
-- emp ���̺� 1��
-- ����Ī

select e.empno, e.ename, m.empno, m.ename
from emp e left join emp m
on e.mgr = m.empno;

---------------------------------------------------------------------------
-- 1. ������� �̸�, �μ���ȣ, �μ��̸��� ����϶�.
select e.ename, e.empno, d.dname
from emp e join dept d
on e.deptno = d.deptno;


-- 2. DALLAS���� �ٹ��ϴ� ����� �̸�, ����, �μ���ȣ, �μ��̸���
-- ����϶�.
select e.ename , e.job,e.deptno, d.dname
from emp e join dept d
on e.deptno = d.deptno
where d.loc = 'DALLAS';


-- 3. �̸��� 'A'�� ���� ������� �̸��� �μ��̸��� ����϶�.
select e.ename, d.dname
from emp e join dept d
on e.deptno = d.deptno
where e.ename like '%A%';

-- 4. ����̸��� �� ����� ���� �μ��� �μ���, �׸��� ������
--����ϴµ� ������ 3000�̻��� ����� ����϶�.
select e.ename, d.dname, sal
from emp e join dept d
on e.deptno = d.deptno
where sal >= 3000;
?

-- 5. ����(����)�� 'SALESMAN'�� ������� ������ �� ����̸�, �׸���
-- �� ����� ���� �μ� �̸��� ����϶�.
select e.job , e.ename , d.dname
from emp e join dept d
on e.deptno = d.deptno
where job = 'SALESMAN';

-- 6. Ŀ�̼��� å���� ������� �����ȣ, �̸�, ����, ����+Ŀ�̼�,
-- �޿������ ����ϵ�, ������ �÷����� '�����ȣ', '����̸�',
-- '����','�Ǳ޿�', '�޿����'���� �Ͽ� ����϶�.
--(�� ) 1 : 1 ���� ��� �÷��� ����

select e.empno as "�����ȣ", e.ename as "����̸� ", e.sal as "����", e.sal+e.comm as "�Ǳ޿�" , s.grade as "�޿����"
from emp e join salgrade s
on e.sal between s.losal and s.hisal
where comm is not null;

-- 7. �μ���ȣ�� 10���� ������� �μ���ȣ, �μ��̸�, ����̸�,
-- ����, �޿������ ����϶�.
select e.empno , e.ename , e.deptno , e.sal , s.grade
from emp e join salgrade s
on e.sal between s.losal and s.hisal
where e.deptno = 10;
?

-- 8. �μ���ȣ�� 10��, 20���� ������� �μ���ȣ, �μ��̸�,
-- ����̸�, ����, �޿������ ����϶�. �׸��� �� ��µ�
-- ������� �μ���ȣ�� ���� ������, ������ ���� ������
-- �����϶�.

select d.deptno, d.dname, e.empno, e.ename, e.sal , s.grade 
from emp e join salgrade s on e.sal between s.losal and s.hisal
            join dept d on e.deptno = d.deptno
where e.deptno != 30
order by e.sal desc;

-- 9. �����ȣ�� ����̸�, �׸��� �� ����� �����ϴ� ��������
-- �����ȣ�� ����̸��� ����ϵ� ������ �÷����� '�����ȣ',
-- '����̸�', '�����ڹ�ȣ', '�������̸�'���� �Ͽ� ����϶�.
--SELF JOIN (�ڱ� �ڽ����̺��� �÷��� ���� �ϴ� ���)
select e.empno as "�����ȣ" , e.ename as "����̸�" , a.mgr as "�����ڹ�ȣ" , a.ename as "�������̸�"
from emp e join emp a
on e.mgr = a.empno;


----------------------------------------------------------
--subquery
--����Ŭ.pdf ( 7�� 100page )
-- SQL �� >> SQL ���� �ذ��
-- 1. �Լ� >> ���� >> JOIN >> �ذ��� �ȵǸ� >> SUBQUERY

-- ������̺��� ������� ��� ���޺��� �� ���� �޿��� �޴� ����� ���, �̸�, �޿��� ����ϼ���

-- 1. ��� �޿�
select avg(sal) from emp;

select empno, ename , sal
from emp
where sal > 2073;

-- �ϳ��� ���� �ذ� ���� 2�� ( 1���� ���� )
select empno, ename , sal
from emp
where sal > (select avg(sal) from emp);

-- SubQuery
-- 1. single row subquery : subquery �� ���� ����� ���� row ���� column ( ���� �� ) : �Ѱ��� ��
-- ���� ������ ( = > < ... )

-- 2. multi  row subquery : subquery �� ���� ����� 1�� �̻��� row ( �������� �� ) : ���� �÷�
-- in(), not in(), ANY(), ALL() ������
-- ALL : sal > 1000 and sal > 4000 and ....
-- ANY : sal > 1000 or sal > 4000 or ....

-- why : ���Ǵ� �������� ������ �ٸ���

--subquery ����
-- 1. ��ȣ �ȿ� �־���Ѵ� >> (select max(sal) from emp)
-- 2. ���� �÷����� �����Ǿ�� �Ѵ� >> select empno, sal from emp ( �������� x )
-- 3. �ܵ����� ������ �����Ͽ��� �Ѵ�

-- �������
-- 1. subquery ���� ����
-- 2. subquery ����� ������ ���� query �� ����

-- TIP )
-- SELECT (subquery) -> �Ѱ��� �ุ ��ȯ �� ��� ( Scala Sub Query)
-- FROM (subquery)   -> INline View(�������̺�)
-- WHERE (subquery)  -> ����

-- ������̺��� jones�� �޿����� �� ���� �޿��� �޴� ����� ���, �̸�, �޿��� ����ϼ���
select empno, ename,sal
from emp
where sal >= (select sal from emp where ename = 'JONES');

select *
from emp
where sal = (select sal from emp where deptno = 30); -- ��Ƽrow 
-- ORA-01427: single-row subquery returns more than one row

select *
from emp
where sal in(select sal from emp where deptno = 30);
--sal = 1600 and sal = 1250 and sal = 2850....

select *
from emp
where sal not in(select sal from emp where deptno = 30);
--sal != 1600 and sal != 1250 and sal != 2850....

-- ���� ������ �ִ� ����� ����� �̸��� ����ϼ���
-- (�� ����� mgr �÷��� �ִ� )
select empno,ename
from emp
where empno in(select mgr from emp);

-- empno == 7902 or empno == 7698 ...
-- ���������� ���� ����� ����� �̸��� ����ϼ���
select empno,ename
from emp
where empno not in(select mgr from emp);
-- (and ���꿡 null ���� ) >> �� ����� null
-- empno != 7902 and empno != 7698 ...
select empno,ename
from emp
where empno not in (select nvl(mgr,0) from emp);

-- king ���� �����ϴ� �� ���ӻ���� king �� ����� ���, �̸�, ���� , ������ ����� ����ϼ���
select empno, ename ,job ,mgr
from emp
where mgr = (select empno from emp where ename = 'KING');

-- 20�� �μ��� ����߿��� ���� ���� �޿��� �޴� ������� �� ���� �޿��� �޴� ����� ���, �̸�, �޿�, �μ���ȣ�� ����ϼ���.
select empno, ename , sal , deptno
from emp
where sal > (select max(sal) from emp where deptno = 20);

select empno, ename, sal , avgsal
from emp e join (select deptno, avg(sal)as avgsal from emp group by deptno) d
on e.deptno = d.deptno
where e.sal > d.avgsal;

-----------------------------------------------------------------------
--1. 'SMITH'���� ������ ���� �޴� ������� �̸��� ������ ����϶�.
select ename, sal
from emp
where sal > (select sal from emp where ename = 'SMITH');

select sal from emp where ename = 'SMITH';

--2. 10�� �μ��� ������ ���� ������ �޴� ������� �̸�, ����,
-- �μ���ȣ�� ����϶�.
select ename, sal, deptno
from emp
where sal in (select sal from emp where deptno = 10);?

select sal from emp where deptno = 10;
--3. 'BLAKE'�� ���� �μ��� �ִ� ������� �̸��� ������� �̴µ�
-- 'BLAKE'�� ���� ����϶�.
select ename, hiredate
from emp
where deptno = (select deptno from emp where ename = 'BLAKE') and ename != 'BLAKE';
?


--4. ��ձ޿����� ���� �޿��� �޴� ������� �����ȣ, �̸�, ������
-- ����ϵ�, ������ ���� ��� ������ ����϶�.
select empno, ename, sal
from emp
where sal > (select avg(sal) from emp)
order by sal desc;

?

--5. �̸��� 'T'�� �����ϰ� �ִ� ������ ���� �μ����� �ٹ��ϰ�
-- �ִ� ����� �����ȣ�� �̸��� ����϶�.
select empno, ename, deptno
from emp
where deptno in(select deptno from emp where ename like '%T%');

?

--6. 30�� �μ��� �ִ� ����� �߿��� ���� ���� ������ �޴� �������
-- ���� ������ �޴� ������� �̸�, �μ���ȣ, ������ ����϶�.
--(��, ALL(and) �Ǵ� ANY(or) �����ڸ� ����� ��)
select ename, deptno , sal
from emp
where sal > ALL(select max(sal) from emp where deptno = 30);

select max(sal) from emp where deptno = 30;
--7. 'DALLAS'���� �ٹ��ϰ� �ִ� ����� ���� �μ����� ���ϴ� �����
-- �̸�, �μ���ȣ, ������ ����϶�.
select e.ename , e.DEPTNO , e.job
from emp e join dept d
on e.deptno = d.deptno
where e.deptno = (select deptno from dept where loc = 'DALLAS');


SELECT ENAME, DEPTNO, JOB
FROM EMP
WHERE DEPTNO IN(SELECT DEPTNO    -- = �� �´µ�  IN
                      FROM DEPT
                      WHERE LOC='DALLAS');

--8. SALES �μ����� ���ϴ� ������� �μ���ȣ, �̸�, ������ ����϶�.

select e.deptno , e.ename , e.job
from emp e join dept d
on e.deptno = d.deptno
where e.deptno = (select deptno from dept where dname = 'SALES');

select DEPTNO, ENAME, JOB
FROM EMP
WHERE DEPTNO IN(SELECT DEPTNO
                      FROM DEPT
                      WHERE DNAME='SALES');
--9. 'KING'���� �����ϴ� ��� ����� �̸��� �޿��� ����϶�
--king �� ����� ��� (mgr �����Ͱ� king ���)
select ENAME, SAL
from emp
where mgr = (select empno from emp where ename = 'KING');

SELECT ENAME, SAL
FROM EMP
WHERE MGR=(SELECT EMPNO
                FROM EMP
                WHERE ENAME='KING');

--10. �ڽ��� �޿��� ��� �޿����� ����, �̸��� 'S'�� ����
-- ����� ������ �μ����� �ٹ��ϴ� ��� ����� �����ȣ, �̸�,
-- �޿��� ����϶�.

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
                   
--11. Ŀ�̼��� �޴� ����� �μ���ȣ, ������ ���� �����
-- �̸�, ����, �μ���ȣ�� ����϶�.
select ename, sal, empno
from emp
where deptno in(select deptno from emp where comm is not null) and sal in(select sal from emp where comm is not null);

--12. 30�� �μ� ������ ���ް� Ŀ�̼��� ���� ����
-- ������� �̸�, ����, Ŀ�̼��� ����϶�.
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

