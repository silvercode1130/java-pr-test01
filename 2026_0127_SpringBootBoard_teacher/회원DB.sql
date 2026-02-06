/*

-- 일련번호관리 객체
create sequence seq_member_mem_idx

-- 테이블 생성
create table member
(
	mem_idx		int,								-- 회원번호
	mem_name	varchar2(200) not null,				-- 회원명
	mem_id		varchar2(200) not null,				-- 아이디
	mem_pwd		varchar2(200) not null,				-- 비밀번호
	mem_email	varchar2(200) not null,				-- 이메일
	mem_tel		varchar2(200) not null,				-- 전화번호
	mem_zipcode varchar2(100) not null,				-- 우편번호
	mem_addr	varchar2(500) not null,				-- 주소
	mem_ip		varchar2(100) not null,				-- 아이피
	mem_regdate date          default sysdate,		-- 가입일자
	mem_role	varchar2(100) default 'ROLE_USER' 	-- 등급
)

-- 기본키
alter table member
   add constraint pk_member_mem_idx  primary key(mem_idx) ;

-- mem_id unique제약
alter table member
   add constraint unique_member_mem_id  unique(mem_id) ; 

--  mem_role 제약 : ROLE_USER or ROLE_ADMIN
alter table member
   add constraint ck_member_mem_role  check( mem_role in('ROLE_USER','ROLE_ADMIN') ) ;

-- sample data

-- JDBC용 insert
insert into member values(seq_member_mem_idx.nextVal,?,?,?,?,?,?,?,?,sysdate,default)

-- JDBC용 update
update member set mem_name=?,mem_pwd=?,mem_email=?,mem_tel=?,
                  mem_zipcode=?,mem_addr=?,mem_ip=?,mem_role=?  
                  where mem_idx=?


insert into member values(seq_member_mem_idx.nextVal,
                          '일길동',
                          'one',
                          '1234',
                          'one@ymca.com',
                          '010-111-1234',
                          '12345',
                          '대구광역시 중구 상서동',
                          '172.168.32.111',
                          default,
                          default
                         ) ;
                         
insert into member values(seq_member_mem_idx.nextVal,
                          '김관리',
                          'admin',
                          '1234',
                          'admin@ymca.com',
                          '010-555-1234',
                          '12345',
                          '대구광역시 중구 상서동',
                          '172.168.32.111',
                          default,
                          'ROLE_ADMIN'
                         ) ;                         
                         
select * from member







*/