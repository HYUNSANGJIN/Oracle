---------------------------------------------------------------------------------------------------------
-- ������ ���� ( DML )
-- ����Ŭ.pdf ( 10 �� 168 page )
-- �ݵ�� �ϱ�
-- INSERT, UPDATE , DELETE 

/*
����Ŭ ����
DDL ( ������ ���Ǿ� ) : [create, alter , drop, truncate] , rename , modify
DML ( ������ ���۾� ) : insert, update , delete
DQL ( ������ ���Ǿ� ) : select
DCL ( ������ ����� ) : ������ : grant , revoke 
TCL ( Ʈ����� ) : commit , rollback , savepoint

DML �۾� ( insert, update, delete )
-- A ���¿��� B��� ���� ��ü
---------------------------------------------------
-- A ���� ( 1000 ) ��� : update ���� set �ݾ� -
- > 900
-- B ���� ( 1000 ) �Ա� : update ���� set �ݾ� +
- > 1100
---------------------------------------------------
-- A ���¿��� ��� B ���� �Ա� [�ϳ��� ������ ������ ���������]
-- �Ѵ� ������ �ƴϸ� �Ѵ� ����
-- Ʈ����� : �ϳ��� ������ ����
-- ó�� ��� -> commit , rollback
*/

-- desc emp (�⺻����)

-- ���� ���� ( ���� ���� ������ ������ �ִ� ���̺� ��� )
select * from tab;

-- create table �̸� ... ������ ������ ���� �Ұ� ( ������ �ִ��� ������ Ȯ���ϴ� ��� )  select * from tab;

select * from tab where tname='BOARD';

select * from col where tname = 'EMP'; 

-----------------------------------------------------------
-- 1. insert

create table temp(
    id number primary key, -- ���� ( null ��(x), �ߺ�(x) )
    name nvarchar2(20)
);

-- 1. ���� �Ϲ����� INSERT �۾�
insert into temp(id,name) values(100,'ȫ�浿');

select * from temp;

commit; -- �� �ݿ�

-- 2. �÷� ����� ���� ���� - ���߿��� ��� x ( �������� �������� )
insert into temp
values(200,'������');

select * from temp;

rollback;

-- 3. ���� ( id �÷��� PK )
insert into temp(name)
values ('������');
-- ORA-00001: unique constraint (BITUSER.SYS_C007003) violated  
-- ORA-01400: cannot insert NULL into ("BITUSER"."TEMP"."ID")
-- DB �� ���Ἲ�� �߿�� �Ѵ�.
------------------------------------------------------------------------
-- TIP)
-- �Ϲ����� SQL ���� ���α׷����� ��Ұ� ����
-- PL-SQL ( ����, ��� )

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
-- ���߽� sample ������ �ְ� test ���ϸ� �̷� ��� ���

create table temp3(
    memberid number(3) not null, -- ���� 3�ڸ� null �� ����
    name varchar(10), 
    regdate date default sysdate -- �ʱⰪ�� ����(�⺻��) (insert �ڵ� �ý��� ��¥)
);

select sysdate from dual;
--alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';

insert into temp3(memberid, name, regdate)
values(100,'ȫ�浿','2021-03-04');

select * from temp3;
commit;

insert into temp3(memberid, name) values (200,'������');

select * from temp3;
commit;

insert into temp3(memberid)
values (300);

select * from temp3;
commit;

/*
insert into temp3(name)
values('����');
ORA-01400: cannot insert NULL into ("BITUSER"."TEMP3"."MEMBERID")
*/

----------------------------------------------------------------------
-- TIP) 
-- 1. �뷮 ������ insert �ϱ�
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

-- �䱸����
-- temp4 �� �ִ� ��� �����͸� temp5�� �ְ� �ʹ�.
-- insert into ���̺��(�÷�����Ʈ) values 
-- insert into ���̺��(�÷�����Ʈ) select ��;

insert into temp5(num) select id from temp4;
-- �뷮 insert
select * from temp5;
commit;

--2. �뷮 insert 
-- ���̺��� ���� ��Ȳ���� >> [���̺� ����(���� : ��Ű��) + ������ ����]
-- �� ���� ������ ���簡 �ȵȴ�. ( pk .. fk )
-- ������ ������ ���� + ������ ����
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

-- ����
-- Ʋ(��Ű��) ������ �����ϰ� �����ʹ� �����ϰ� ���� �ʾƿ�
create table copyemp3
as 
    select * from emp where 1=2; -- where 1=1 ���� ����

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

-- subquery Ȱ��
update copyemp
set sal = (select sum(sal) from emp);

select * from copyemp;
rollback;

-- �������� �÷� ������Ʈ ����
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
-- ������ (SQL) >> CRUD ( Create(insete) , Read(select) , Update , Delete )
-- APP(JAVA) - JDBC API - Oracle

-- CRUD 
-- ��ü��ȸ , ������ȸ , ���� , ���� , ����  => ������ => �ڹ��ڵ忡�� �۾�
-- JAVA�ڵ忡���� �Լ��� ����� 
-- ��ü��ȸ  - public List<Emp> getEmpAllList() { select * from emp )
-- ������ȸ  - public Emp getEmpListByEmpno(int empno) { select * from emp where empno = empno }
-- ����     - public int insertEmp(Emp emp){ insert into emp(...) values ( ..... ) }
 
--------------------------------------------------------------------------------
-- DDL�۾�  ( create, alter , drop ( rename ) )  : ���̺��� �����, �����ϰ�, �����ϴ� �۾� 
-- ����Ŭ.pdf( 9��_ ���̺� ����  ( 138 page )
select * from board;

-- ���̺� ����
drop table board;
-- ORA-00942: table or view does not exist

create table board(
    boardid number,
    title nvarchar2(50),
    content nvarchar2(2000),
    regdate date
);

desc board;

-- TIP (������ȸ)
select * from user_tables where lower(table_name) = 'board';
select * from user_constraints where lower(table_name) = 'board';
----------

-- Oracle 11g >> ���� �÷� ( ���� �÷� )
-- �л��� ���� ���̺� : ���� , ���� , ���� , ����
-- ����, ����, ���� �����͸� insert�� �ϸ� �ڵ����� ���� �����Ͱ� ����� ���� �ʹ�.

create table vtable(
    no1 number,
    no2 number,
    no3 number GENERATED ALWAYS as (no1 + no2) VIRTUAL
);

insert into vtable(no1, no2) values(100,50);

select * from vtable;

insert into vtable(no1, no2) values(10,80);

------ ���� �÷��� ���� �������� �ϸ� ���� �߻� --------------
insert into vtable(no1, no2, no3) values(10,80,90);
-- SQL ����: ORA-54013: INSERT operation disallowed on virtual columns

select * from user_tab_columns where table_name = 'VTABLE';

--�ǹ�����  Ȱ���ϴ� �ڵ�
--��ǰ���� (�԰���) �б⺰ ������ (4�б�)
--�԰��� : 2019-03-01 >> 1�б�

create table vtable2( 
  no number , --����
  p_code char(4), --��ǰ�ڵ� (A001 , B002)
  p_date char(8), --�԰���(20190303)
  p_qty number,   --����
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
-- DDL ���̺� ����� ���� ����

-- 1. ���̺� �����ϱ�
create table temp6(id number);

-- 2. ���̺��� �̹� �����ߴµ� �÷��� �ϳ� �߰��ϰ� �ʹ�. ( add )
--   �������̺� �߰�.
alter table temp6
add ename varchar2(20);

select * from temp6;

-- 3. ���� ���̺� �ִ� �÷��� �̸��� �߸� ǥ�� ( ename -> username )
--   �������̺� �ִ� ���� �÷��� �̸��� ����(rename)
alter table temp6 
rename column enmae to username;

select * from temp6;


-- 4. �⺻ ���̺� �ִ� ���� �÷��� Ÿ�� ���� ���� ( modify )
alter table temp6
modify(username varchar2(2000));

desc temp6;

-- 5. �⺻ ���̺� �ִ� ���� �÷� ����
alter table temp6
drop column username;

select * from temp6;

-- 6. ���̺� ��ü�� �ʿ� ��������
--   6.1 delete : �����͸� ����.
-- ���̺��� ó�� ����� ó�� ũ�Ⱑ �־����� >> �����͸� ������ ������ ũ�� ��ŭ ���̺� ũ�� ����
-- EX) ó�� ���̺��� ����� 1M >> ������ 10���� ������ >> 100M ���� >> delete 10���� ���� >> ������ ���� >> ���̺��� ũ��� �״��.

-- ���̺� ������ ���� [������ ũ��]�� ���� �� ������ ?
-- truncate ( ���� where ��� �Ұ� ) 
truncate table temp6;


-- 7. ���̺� ���� drop
drop table temp6;

--------------------------------------------------------------------------------
-- ������ ���Ἲ ���� ������ ���� 
-- ���̺� ���� �����ϱ�
-- Oracle.pdf (page.144)

-- ������ ���Ἲ Ȯ��
-- insert, update �� ���ؼ� ���Ἲ�� Ȯ�� (����)
/*         �� �� �� �� �� ��
    PRIMARY KEY(PK) : �����ϰ� ���̺��� ������ �ĺ�(NOT NULL �� UNIQUE ������ ����)
                      - where empno = 7788 >> �����Ͱ� 1���̶�� ���� ���� >> ���� ���� >> ��ȸ ( ���������� index )
                      - ���� : ���ο� �����Ͱ� ���ų�, �����͸� ���� �� ��� ���ո� �ϴ�.
                      - ���̺�� 1�� ( �������� �÷��� ��� 1�� )
                      
    FOREIGN KEY(FK) : ���� ������ �� ������ �ܷ�Ű ���踦 �����ϰ� �����մϴ�.
                      - ���̺�� ���̺���� ���踦 ���� ( �������� )
    
    UNIQUE key(UK)  : ���̺��� ��� ���� �����ϰ� �ϴ� ���� ���� ��(NULL �� ���)
                     - ���ϰ� .. null�� ��� >> not null unique �Ѵ�
                     - �÷��� ���� ��ŭ (10��)
                     
    NOT NULL(NN)    : ���� NULL ���� ������ �� �����ϴ�.
    
    CHECK(CK)       : ���̾�� �ϴ� ������ ������(��κ� ���� ��Ģ�� ����)
                       - ���� ���� ���� ���� �Է¹ްڴ� ( gender : �÷��� �� �Ǵ� �� �����͸� �Է� ) 
                       - where gender in ('��','��')
                       - gender in ('��','��') ��������
*/

-- ������ ����� ���� 
-- 1. ( create table ... �ȿ��� ���� )
-- 2. ���̺��� �� ����� ���� �߰� ( alter table ... add constraint ... ) ���� ��� >> �𵨸� ��


-- TIP)
-- ���� ���� Ȯ��
select * from user_constraints where table_name='EMP';

create table temp7 (
    --id number primary key -- �ȵǿ� ( �������� �ʴ´� ) -- ���� �̸� �ڵ����� (���� ���� ) ��ƴ�
    id number constraint pk_temp7_id primary key , -- ������ ǥ�� ( �̸� ���� )
    name varchar2(20) not null,
    addr varchar2(50)
    );
    
select * from user_constraints where table_name='TEMP7';

--ORA-01400: cannot insert NULL into ("BITUSER"."TEMP7"."ID")
insert into temp7(name, addr) values('ȫ�浿','����� ������');
------------------------------------------------------------

insert into temp7(id,name,addr) values(10,'ȫ�浿','����� ������');

select * from temp7;
commit;

--ORA-00001: unique constraint (BITUSER.PK_TEMP7_ID) violated
insert into temp7(id,name,addr) values(10,'�ƹ���','����� ������');
-------------------------------------------------------------

-- 1. primary key ( ���̺� ����� �� �� ������ ? > 1�� )
--   �������� ��� 1��
-- create teble member(ename, age) << �ΰ��� �÷��� ��� �ϳ��� ����Ű 
-- where ename = ... and age = .... and num = ....  (�Ѱ��� �����ͷ� ����)


create table temp8(
    id number constraint pk_temp8_id primary key,
    name nvarchar2(30) not null,
    jumin nchar(6) constraint uk_temp8_jumin unique, -- �ߺ��� �Ұ��� null �� ���� 
    addr nvarchar2(1000)
);

select * from user_constraints where table_name='TEMP8';

insert into temp8(id,name,jumin,addr)
values(10,'ȫ�浿','123456','��⵵');
commit;


--ORA-00001: unique constraint (BITUSER.UK_TEMP8_JUMIN) violated
insert into temp8(id,name,addr)
values(20,'������','����');
-----------------------------------------------------------------

select * from temp8; -- unique ������ null ���
--    jumin nchar(6) not null constraint uk_temp8_jumin unique -- null(x)

insert into temp8(id,name,addr)
values(30,'�ƹ���','������');
-- null �ߺ� üũ�� ���� �ʴ´�.

select * from temp8;
commit;
-------------------------------------------------------------------
-- ���̺��� ���� �� ���� �ɱ�
create table temp9 (id number);

-- ���� ���̺� ���� �߰�
-- ���� ( ���� �߰��ɶ� ���̺� ������ �˻� ) >> �ߺ� ������ >> �ߺ� ������ ���� >> ���� �߰�

alter table temp9
add constraint pk_temp9_id primary key(id);
-- add constraint pk_temp9_id primary key(id, num); ����Ű

select * from user_constraints where table_name='TEMP9';


alter table temp9
add ename varchar2(50);

-- not null �߰�

alter table temp9
modify(ename not null);

select * from user_constraints where table_name='TEMP9';
------------------------------------------------------------------
-- [Check ����]
-- where ���ǰ� ������ ������ ���� >> where gender in ( '��' , '��')

create table temp10(
    id number constraint pk_temp10_id primary key,
    name varchar2(20) not null,
    jumin char(6) constraint uk_temp10_jumin unique,
    addr varchar2(20),
    age number constraint ck_temp10_age check(age >= 19)
    -- ���� where age >= 19
);

select * from user_constraints where table_name='TEMP10';

insert into temp10(id, name, jumin, addr, age)
values(100,'ȫ�浿','12345','�����',25);


select * from temp10;
commit;

--ORA-02290: check constraint (BITUSER.CK_TEMP10_AGE) violated
insert into temp10(id, name, jumin, addr, age)
values(200,'������','12345','�����',18);
---------------------------------------------------------------
-- ���� ���� : ���̺�� ���̺���� ���� 
create table c_emp
as
    select empno, ename, deptno from emp where 1=2;


select * from c_emp;

create table c_dept
as 
    select deptno, dname from dept where 1=2;
    
select * from c_dept;

-- ���� ( A ���̺� �ִ� ��� �÷��� �����ʹ� B ���̺� �÷��� �����͸� �ްڴ� )
-- c_emp ���̺� �ִ� deptno �÷��� �����ʹ� c_dept ���̺� �ִ� deptno �÷��� �����͸� �����ϰڴ�.
-- �����ϰڴ� ( fk ) 

alter table c_emp
add constraint fk_e_emp_deptno foreign key(deptno) references c_dept(deptno);
-- ORA-02270: no matching unique or primary key for this column-list 
-- c_dept�� deptno �� ���� primary key �� �ƴϱ� ������ ��� �Ұ��� .
-- �����ϱ����� c_dept >> deptno �÷��� ���� 
alter table c_dept
add constraint pk_c_dept_deptno primary key(deptno);  -- �ſ�Ȯ��
-- >> 
alter table c_emp
add constraint fk_e_emp_deptno foreign key(deptno) references c_dept(deptno);


-- ����
insert into c_dept(deptno,dname) values (100,'�λ���');
insert into c_dept(deptno,dname) values (200,'������');
insert into c_dept(deptno,dname) values (300,'ȸ����');
commit;

select * from c_dept;

-- ���Ի�� �Ի�
insert into c_emp(empno, ename) values(100,'ȫ�浿'); -- deptno
-- deptno fk �־ not null ���� ������ null ���

select * from c_emp;
-- ���� : ���Ի���� �μ��� ������ ���� �� �ִ�


--ORA-02291: integrity constraint (BITUSER.FK_E_EMP_DEPTNO) violated - parent key not found
insert into c_emp(empno, ename,deptno) values(100,'ȫ�浿',50);
----------------------------------------------------------------

insert into c_emp(empno, ename,deptno) values(100,'ȫ�浿',100);

select * from c_emp;
commit;
---------------------------------------------------------------
-- ������
-- ���̺� ( �θ� , �ڽ� )
-- c_emp, c_dept [deptno] �÷��� �������� ...
-- �θ� : (master) PK�� ������ �ִ� ���̺��� �θ�..  c_dept
-- �ڽ� : (detail) FK�� ������ �ִ� ���̺��� �ڽ�..  c_cmp

-- c_dept ���� 100�̶�� �����͸� ������ �� ������� ?
delete from c_dept where deptno = 100; -- 100�̶�� �����͸� �ڽ� �ʿ��� ��� �ϰ� �־ ���� �Ұ���.
-- ORA-02292: integrity constraint (BITUSER.FK_E_EMP_DEPTNO) violated - child record found
-- �����ϰ������ ���� �ڽ� �� �����͸� ������ �� �θ��� ������ ���� ����.
delete from c_dept where deptno = 200; -- �ڽ����̺� �ʿ��� �����͸� ���� ���� �ʱ� ������ ���� ����

commit;

/*
(column datatype [CONSTRAINT constraint_name]       
REFERENCES table_ name (column1[,column2,..] [ON DELETE CASCADE]) 

column datatype, . . . . . . . , 
[CONSTRAINT constraint_name] FOREIGN KEY (column1[,column2,..])        
REFERENCES table_name  (column1[,column2,..] [ON DELETE CASCADE]) 
*/
-- [ON DELETE CASCADE]  �θ����̺�� ������ ���� �ϰڴ�
-- 300 ���� �� �ֳ���?  �� 
-- delete from c_dept where detpno=300;
-- �����ϴ� �ڽ� ������ ���� ����
-- delete from c_emp where deptno=300; ���� ����

alter table c_emp
add constraint fk_emp_deptno foreign key(deptno) references c_dept(deptno) 
ON DELETE CASCADE;

-- MS-SQL
-- on delete cascade
-- on update cascade






