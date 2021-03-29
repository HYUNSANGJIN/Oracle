/*
-- ���� ���̺� , ���� �÷���
--�л� ���� ���̺�
--�й��� �����ʹ� �ߺ��ǰų� NULL ���� ����ϸ� �ȵȴ�
--�̸� NULL ���� ������� �ʴ´�
--����
--����
--���� ���� �÷��� ���� Ÿ���̰� NULL ���� ���
--���� �Է����� ������ default�� 0���� ���´�
--���� ,��� �÷��� �����÷�����(�����÷�) �����Ѵ�
--�а��ڵ�� �а� ���̺� �а��ڵ带 �����Ѵ�
--�й� , �̸� , ���� , ���� , ���� , ���� , ��� , �а��ڵ�

--�а� ���̺�
--�а��ڵ� �����ʹ� �ߺ��ǰų� NULL ���� ����ϸ� �ȵȴ�,
--�а��� �� null���� ������� �ʴ´�
--�а��ڵ� , �а���
?
--���� ������ insert ..
--�׸��� select �����
--�й�, �̸�, ����, ��� , �а��ڵ� , �а��� �� ����ϼ���

*/
-- �л� ���̺� ����
create table student(
    studentno number(10) not null UNIQUE,
    name varchar2(20) not null,
    korean number(6) DEFAULT 0,
    english number(6)DEFAULT 0,
    math number(6)DEFAULT 0,
    sum number(10) GENERATED ALWAYS as (korean + english + math) VIRTUAL,
    avg number(10) GENERATED ALWAYS as ((korean + english + math) / 3) VIRTUAL,
    departmentno number(10)
);


-- �а� ���̺� ����
create table department(
    departmentno number(10),
    departmentname varchar2(20)
);

-- �а� ���̺� �а��ڵ� primary key �Է�
alter table department
add constraint pk_deprtment_departmentno primary key(departmentno);

-- �а� ���̺� �а��ڵ�� null ��� ����
alter table department
modify departmentno not null;

-- �а� ���̺� �а����� null ��� ����
alter table department
modify departmentname not null;

-- �л����̺� �а��ڵ�� �а����̺��� �а��ڵ带 �����Ѵ�.
alter table student
add constraint fk_student_departmentno foreign key(departmentno) references department(departmentno) ;

-- ���� ���� Ȯ��
select * from user_constraints where table_name='STUDENT';
select * from user_constraints where table_name='DEPARTMENT';


select * from student;
select * from department;

-- department �� �Է�
insert into department(departmentno,departmentname) values(10,'IT������');
insert into department(departmentno,departmentname) values(20,'BIT��');
insert into department(departmentno,departmentname) values(30,'������');
commit;

-- student �� �Է�
insert into student(studentno,name,departmentno) values(1,'�Ƚ���',10);
insert into student(studentno,name,korean,english,math,departmentno) values(2,'�̵���',80,90,100,10);
insert into student(studentno,name,korean,english,math,departmentno) values(3,'����',90,75,95,20);
insert into student(studentno,name,korean,english,math,departmentno) values(4,'�̺���',50,65,80,30);
insert into student(studentno,name,korean,english,math,departmentno) values(5,'������',70,85,100,30);
insert into student(studentno,name,korean,english,math,departmentno) values(6,'�Ѽ���',99,86,53,10);
commit;


--select �����
--�й�, �̸�, ����, ��� , �а��ڵ� , �а��� �� ����ϼ���
select s.studentno as "�й�", s.name as "�̸�", s.sum as "����", s.avg as "���", 
d.departmentno as "�а��ڵ�", d.departmentname as "�а���"
from student s join department d
on s.departmentno = d.departmentno;



