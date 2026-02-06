/*

-- 일련번호 관리객체
create sequence seq_comment_tb_cmt_idx

-- 테이블생성
drop table comment_tb
create table comment_tb
(
   cmt_idx		int,				-- 일련번호
   cmt_content  varchar2(2000),		-- 내용
   cmt_ip		varchar2(100),		-- 아이피
   cmt_regdate	date,				-- 작성일자
   b_idx		int,				-- 게시글번호
   mem_idx		int,				-- 회원번호
   mem_name		varchar2(200)		-- 회원명
)

-- 기본키
alter table comment_tb
   add constraint  pk_comment_tb_cmt_idx  primary key(cmt_idx);

-- 참조키
alter table comment_tb
   add constraint  fk_comment_tb_b_idx  foreign key(b_idx)
                                        references board(b_idx);
                                        
alter table comment_tb
   add constraint  fk_comment_tb_mem_idx foreign key(mem_idx)
                                         references member(mem_idx);                                     














*/