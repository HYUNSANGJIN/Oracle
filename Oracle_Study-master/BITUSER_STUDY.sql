/*
-- 영문 테이블 , 영문 컬럼명
--학생 성적 테이블
--학번의 데이터는 중복되거나 NULL 값을 허용하면 안된다
--이름 NULL 값을 허용하지 않는다
--국어
--영어
--수학 점수 컬럼은 숫자 타입이고 NULL 값을 허용
--값을 입력하지 않으면 default로 0값을 갖는다
--총점 ,평균 컬럼은 가상컬럼으로(조합컬럼) 생성한다
--학과코드는 학과 테이블에 학과코드를 참조한다
--학번 , 이름 , 국어 , 영어 , 수학 , 총점 , 평균 , 학과코드

--학과 테이블
--학과코드 데이터는 중복되거나 NULL 값을 허용하면 안된다,
--학과명 은 null값을 허락하지 않는다
--학과코드 , 학과명
?
--샘플 데이터 insert ..
--그리고 select 결과는
--학번, 이름, 총점, 평균 , 학과코드 , 학과명 을 출력하세요

*/
-- 학생 테이블 생성
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


-- 학과 테이블 생성
create table department(
    departmentno number(10),
    departmentname varchar2(20)
);

-- 학과 테이블 학과코드 primary key 입력
alter table department
add constraint pk_deprtment_departmentno primary key(departmentno);

-- 학과 테이블 학과코드는 null 허용 안함
alter table department
modify departmentno not null;

-- 학과 테이블 학과명은 null 허용 안함
alter table department
modify departmentname not null;

-- 학생테이블에 학과코드는 학과테이블의 학과코드를 참조한다.
alter table student
add constraint fk_student_departmentno foreign key(departmentno) references department(departmentno) ;

-- 제약 정보 확인
select * from user_constraints where table_name='STUDENT';
select * from user_constraints where table_name='DEPARTMENT';


select * from student;
select * from department;

-- department 값 입력
insert into department(departmentno,departmentname) values(10,'IT정보과');
insert into department(departmentno,departmentname) values(20,'BIT과');
insert into department(departmentno,departmentname) values(30,'국문과');
commit;

-- student 값 입력
insert into student(studentno,name,departmentno) values(1,'안승주',10);
insert into student(studentno,name,korean,english,math,departmentno) values(2,'이동근',80,90,100,10);
insert into student(studentno,name,korean,english,math,departmentno) values(3,'김대업',90,75,95,20);
insert into student(studentno,name,korean,english,math,departmentno) values(4,'이보희',50,65,80,30);
insert into student(studentno,name,korean,english,math,departmentno) values(5,'김진아',70,85,100,30);
insert into student(studentno,name,korean,english,math,departmentno) values(6,'한석희',99,86,53,10);
commit;


--select 결과는
--학번, 이름, 총점, 평균 , 학과코드 , 학과명 을 출력하세요
select s.studentno as "학번", s.name as "이름", s.sum as "총점", s.avg as "평균", 
d.departmentno as "학과코드", d.departmentname as "학과명"
from student s join department d
on s.departmentno = d.departmentno;



