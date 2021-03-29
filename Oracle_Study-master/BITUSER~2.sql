--------------------------------2021-03-08����----------------------------------
alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';

select * from emp;
select * from dept;
select * from salgrade;

-- view ��ü ( ���� ���̺� )
-- ����Ŭ.PDF ( 192page )

-- view ��ü ( create )
-- create view ���̸� as [ select ���� ]
-- view �� ���̺� ó�� ��� ������ ( ���� ���̺� ) : �����͸� ������ ���� �ʴ�
-- view �޸𸮻󿡸� �����ϴ� �������̺�
-- ( subquery -> in line view -> from ( select deptno avg(sal) from ... )

-- view ���� ���̺�
-- ���� : �Ϲ� ���̺�� ���� ���� ( select , where ...
-- ��, view �� �� �ִ� �����Ϳ� ���ؼ��� ��밡��.
-- DML ( insert, update, delete ) -> view �� ���ؼ� �������̺� ���� DML ����  

-- bituser ���� ���� ( SYSTEM ������ ���ؼ� ��ȯ �ο� )
-- SYSTEM >> GRANT CREATE ANY VIEW TO "BITUSER" WITH ADMIN OPTION; ����

create view v_001
as select empno, ename from emp;

select * from v_001; -- view�� ������ �ִ� sql ������ ����

-- VIEW ��� ���� 
-- 1. �������� ���� : JOIN, SUBQUERY >> view ���� ���ϰ� ��밡�� >> ���� ���������� ��������.
-- 2. ������ �ܼ�ȭ ( ���� ) : ������ ������ �̸� �����ΰ� ��� ����
-- 3. ������ ���ȼ� >> Ư�� �÷��� ���� 

-- ����
create view v_002
as 
    select e.empno, e.ename, e.deptno, d.dname 
    from emp e join dept d
    on e.deptno = d.deptno;

select * from v_002;
select * from v_002 where deptno = 20;

-- �� �������̺� (������) ���� ���̺��ε� (�÷����� ����)

create view v_003
as 
    select deptno, avg(sal) as avg -- �÷��� ��Ī ���� �ƴϸ� "" �Ⱥ��̴°� ���ϴ�.
    from emp 
    group by deptno;


select deptno, avg from v_003;

/*
CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW view_name [(alias[,alias,...])]
AS Subquery
[WITH CHECK OPTION [CONSTRAINT constraint ]]
[WITH READ ONLY]

OR REPLACE                          �̹� �����Ѵٸ� �ٽ� �����Ѵ�.
FORCE Base Table                    ������ ������� VIEW �� �����.
NOFORCE                             �⺻ ���̺��� ������ ��쿡�� VIEW �� �����Ѵ�.
view_name VIEW �� �̸�
Alias Subquery �� ���� ���õ� ���� ���� Column ���� �ȴ�.
Subquery SELECT ������ ����Ѵ�.
WITH CHECK OPTION VIEW        �� ���� �׼��� �� �� �ִ� �ุ�� �Է�,���ŵ� �� �ִ�.
Constraint CHECK OPTON        ���� ���ǿ� ���� ������ �̸��̴�.
WITH READ ONLY �� VIEW        ���� DML �� ����� �� ���� �Ѵ�.
*/
create or replace view v_004 -- ������ ����� ������ ������
as 
    select avg(sal) as avgsal from emp;
    

select * from v_004;    
    
create or replace view v_004 
as 
    select round(avg(sal),0) as avgsal from emp;
    
select * from v_004;

-- view ���� ���̺� DML �۾� ���� ( insert, update, delete )
-- ��, view ���ؼ� �� �� �ִ� �����͸� DML ���� ... �ܼ� ���̺� ����
-- �ܼ� view ( ���̺� 1�� ) >> DML ���� >> �� �� ������ ��������
-- ���� view ( ���̺� 1�� �̻� ) >> join, subquery >> DML �Ұ�

select * from v_001;

-- 30�� �μ� ������� ����, �̸�, ������ ��� view �� ����µ�
-- ������ �÷����� ����, ����̸�, �������� alias�� �ְ� ������
-- 300���� ���� ����鸸 �����ϵ��� �϶�.

create or replace view v_emp
as
    select  job as ����, ename as ����̸�, sal as ����
    from emp
    where sal >= 300 and deptno = 30;

select * from v_emp;

-- �μ��� ��տ����� ��� view �� �����, ��տ����� 2000�̻���
-- �μ��� ����ϵ��� �϶�
-- from ���� -> where
-- group by ���� -> having

create view v_emp2
as
    select deptno as �μ���ȣ, avg(sal) as ��տ���
    from emp
    group by deptno
    having avg(sal) >= 2000;

select * from v_emp2;



-- ����
select v."�μ���ȣ", v."��տ���", d.dname
from v_emp2 v join dept d
on v."�μ���ȣ" = d.deptno;

-------------------------------------------------------------------------------
-- ������ �������� SQL 
-- 11�� SEQUENCE (����Ŭ.pdf 185 page )
-- ���� �����ϱ� ( ä���ϱ� )

/*
sequence_name SEQUENCE �� �̸��Դϴ�.
INCREMENT BY n ���� ���� n ���� SEQUENCE ��ȣ ������ ������ ����.
�� ���� �����Ǹ� SEQUENCE �� 1 �� ����.

START WITH n �����ϱ� ���� ù��° SEQUENCE �� ����.
�� ���� �����Ǹ� SEQUENCE �� 1 �� ����.

MAXVALUE n SEQUENCE �� ������ �� �ִ� �ִ� ���� ����.
NOMAXVALUE ���������� 10^27 �ִ밪�� ����������-1 �� �ּҰ��� ����.
MINVALUE n �ּ� SEQUENCE ���� ����.
NOMINVALUE ���������� 1 �� ����������-(10^26)�� �ּҰ��� ����.
CYCLE | NOCYCLE �ִ� �Ǵ� �ּҰ��� ������ �Ŀ� ��� ���� ������ ���� ���θ�
����. NOCYCLE �� ����Ʈ.
CACHE | NOCACHE �󸶳� ���� ���� �޸𸮿� ����Ŭ ������ �̸� �Ҵ��ϰ� ����
�ϴ°��� ����. ����Ʈ�� ����Ŭ ������ 20 �� CACHE
*/

-- WHY " WEB SITE : �Խ��� >> key ( �ĺ��� ) >> ���� ( 1, 2, 3 ... )

drop table board;

create table board(
    boardid number constraint pk_board_boardid primary key,
    title nvarchar2(50)
    );

select * from board;
-- boardid (pk : not null, unique , ���������� index �ڵ� ���� )
-- �Խ��ǿ� ���� ����
-- insert into board(boardid,title) values();
-- boardid �÷��� �����ʹ� ó�� ���� ���� 1 �̶�� ���� insert 
-- �� ���� �ۺ��ʹ� 2, 3, 4 ... �������� �����Ͱ� insert �Ǵ� ��Ģ
/*
insert into board(boardid, title)
values(number, 'ó����') -- 1;

insert into board(boardid, title)
values( , '�ι�°') -- 2;
*/
select count(boardid + 1) from board;

insert into board(boardid,title) values((select count(boardid + 1) from board),'ó����');

insert into board(boardid,title) values((select count(boardid + 1) from board),'�ι�°��');

select * from board;
commit;

-- ������ : DML �����߻�

-- �ٸ� ��� 
insert into board(boardid,title) values((select nvl(max(boardid + 1),0) from board),'ó����');

insert into board(boardid,title) values((select nvl(max(boardid + 1),0) from board),'�ι�°');

insert into board(boardid,title) values((select nvl(max(boardid + 1),0) from board),'����°');

commit;

delete from board where boardid = 1;

insert into board(boardid,title) values((select nvl(max(boardid + 1),0) from board),'�׹�°');

select * from board;
commit;

-------------------------------------------------------------------------------
-- sequence ��ȣ ���� : �ߺ����� ���� �������� ���� ���� ( ���� ��ü )
------------------------------------------------------------------------------
create sequence board_num;

select * from user_sequences;

/*
 NEXTVAL �� CURRVAL �ǻ翭
 - Ư¡ -
 1) NEXTVAL �� ���� ��� ������ SEQUENCE ���� ��ȯ �Ѵ�.
 2) SEQUENCE �� ������ �� ����, �ٸ� ����ڿ��� ������ ������ ���� ��ȯ�Ѵ�.
 3) CURRVAL �� ���� SEQUENCE ���� ��´�.
 4) CURRVAL �� �����Ǳ� ���� NEXTVAL �� ���Ǿ�� �Ѵ�.
*/

-- ��ȣ ����
select board_num.NEXTVAL from dual; -- ä��

-- ������� ä���� ��ȣ Ȯ��
select board_num.CURRVAL from dual; -- 

-- �Խ���
-- �Խ��� ���Ǵ� ä����
create table kboard(
    num number constraint pk_kboard_num primary key,
    title nvarchar2(50)
    );

create sequence kboard_num;

insert into kboard values(kboard_num.NEXTVAL, 'ó���̴�');

insert into kboard values(kboard_num.NEXTVAL, '���̴�');

insert into kboard values(kboard_num.NEXTVAL, '���̴�');

commit;

select kboard_num.currval from dual;

delete from kboard where num = 1;
commit;

insert into kboard values(kboard_num.NEXTVAL, '���̴�');

select * from kboard;
commit;

---------------------------------------------------------------------------
-- 1. sequence ��ü�� ���̺� ���ӵ��� �ʴ´� ( �ϳ��� �������� �������� ���̺��� ��밡�� )
-- sequence ���� >> A ���̺�, B ���̺��� ��� ���� 

-- �� ����Ʈ ( �Խ��� 10�� )
-- ��ǰ�Խ���, ������ �Խ���, ȸ�� �Խ��� ....
-- �䱸����
-- sequence 10�� ���� ���� ���
-- or  sequence 1���� ���� 10�����̺��� ��밡��


-- TIP)
-- MS-SQL : create table board(boardid int identity(1,1), title varchar(20));
-- insert into board(title) values('�氡') >> boardid �ڵ� 1 > 2 > 3 ....
-- ���̺� ���� ....
-- MS-SQL : 2012 ���� ( sequence ) 

-- MY-SQL : create table board(boardid int auto_increment, title varchar2(20);

-- MYsql ���� ������� ���ļ� open source ���� >> mariadb ( ���� ���� )
-- https://mariadb.com/kb/en/create-sequence/  >>  sequencce��ü ����

------------------------------------------------------------------------------
-- �ɼ�
create sequence seq_num
start with 10  -- ���� �� 
increment by 2; -- ���� �ϴ� ��

select seq_num.NEXTVAL from dual;

select seq_num.currval from dual;

-- �Խ��� �� 100��

/*
num,   title,   content
1
2
3
...
100
*/
-- �Ϲ������� �Խ��� �ֽű� ( ���� ���߿� �� ���� ) ȭ�鿡 ���� ���
select * from kboard order by num desc; -- �ϹݰԽ��� ù ����
------------------------------------------------------------------------------- 
-- ������ 
-- rownum �ǻ� �÷� : ���� ���������� �����ϴ� �÷��� �ƴϰ� ������ ����
-- rownum : ������ ���̺� �÷��� �������� ������ ���������� �� ��ȣ�� �ο��� �� �ִ� �÷�

select * from emp;
select rownum as ����, empno, ename from emp;
-- select �� ����� ������ �ο�

-- Top-n ( ���ĵ� �������� ������ � ���� )
-- ���̺��� ���ǿ� �´� ����(TOP) ���ڵ� n �� ( row ) n�� ����
-- TIP
-- MS_SQL ( top Ű���� ) 
-- select top 10, * from emp order by sal desc;

-- oracle top n (x)
-- rownum : ������ �ο� Ư�� ������ ����ؼ� top ���� ����

-- 1. ������ ������ ���� ( ���� )
-- 2. ���ĵ� �����͸� �������� rownum �����ϰ� ������ �ɾ ������ ����

-- 1�ܰ�
select  *
from (      select *
            from emp
            order by sal desc
      ) e;

-- 2�ܰ�

select  rownum as num , e.*
from (      select *
            from emp
            order by sal desc
      ) e;

-- 3�ܰ� ( �޿��� ���� �޴� ��� 5�� ) top n 
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
-- top n ( �Խ��� ����¡ ó�� )
-- 1000 ��
-- �� ȭ�鿡 100�� ������ �ѹ��� ������� �ʾƿ�
-- 10�Ǿ� �� ȭ�鿡 

-- pagesize = 10 ( �� ȭ�鿡  ( ������ ) ������ �� �ִ� row �Ǽ� 
-- page ���� >> 10��

-- 1page , 2page ..... 10 page ( 1page Ŭ�� >> select 1 ~ 10 java ���� )
--                             ( 2page Ŭ�� >> select 11 ~ 20 java ���� )

-- <a href = ' page.jsp?'>10</a> 10page ( 91 ~ 100 )
----------------------------------------------------------------------------
-- HR ���� --
-- ����� ���� ������ ����(����)
select * from employees; -- 107 ��

-- 1�ܰ� ( ���� ������ ����� )
select * from employees order by employee_id asc;

-- 2�ܰ� ( ���� �����Ϳ� ���� �ο��ϱ�
select rownum as num, e.*
from (
    select * from employees order by employee_id asc
     ) e 
where rownum <= 50; -- ���������� ������ rownum ���

-- 3�ܰ�
select *
from (
            select rownum as num, e.*
            from (
                select * from employees order by employee_id asc
                 ) e 
            where rownum <= 50
      ) n 
where num >= 41;

-- 107��
-- pagesize = 10
-- [1] [2] [3] [4] [5] [6] [7] [8] [9] [10] [11]
-- [1] >> 1~ 10
-- [2] >> 11~ 20
-- ....
-- [5] >> 41 ~ 50 �����͸� �����ִ� ����

-- 1�� ������ Ŭ�� ( 1 ~ 10 )
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
-- servlet & jsp ���� �ٽ�

select rownum as num, e.*
from (
    select * from employees order by employee_id asc
) e
where rownum between 1 and 10;
---------------------------------SQL END---------------------------------------
