/*

-- 일련번호관리
create sequence seq_board_b_idx

-- 테이블
create table board
(
   b_idx	 int,						-- 일련번호 
   b_subject varchar2(500) not null,	-- 제목
   b_content clob not null,				-- 내용
   b_ip      varchar2(100) not null,	-- 아이피
   b_readhit int,						-- 조회수
   b_regdate date,						-- 등록일자
   b_modifydate date,					-- 수정일자
   mem_idx   int,						-- 회원번호
   mem_name  varchar2(200) not null,	-- 회원명
   b_ref     int,						-- 참조글 번호
   b_step    int,						-- 글순서
   b_depth   int,						-- 글깊이
   b_use     char(1) default 'y'		-- 사용유무
)

-- 기본키
alter table board
   add constraint  pk_board_b_idx  primary key(b_idx) ;

-- 사용유무 check 제약
alter table board
   add constraint  ck_board_b_use  check( b_use in ('y','n') ) ;

-- 외래키(참조키)
alter table board
   add constraint  fk_board_mem_idx  foreign key(mem_idx)
                                     references member(mem_idx) ;
                                     
                                     참고)
                                     on delete cascade -- 부모키가 삭제되면 자식도 삭제해라 
                                     on update cascade -- 부모키가 수정되면 자식도 수정해라 
  
select * from member  
  
-- sample data

-- 새글쓰기
insert into board values(
             seq_board_b_idx.nextVal,
             '내가 1등이다',
             '이번에도 내가 1등이네~~',
             '172.30.1.77',
             0,
             sysdate,
             sysdate,
             1,
             '일길동',
             seq_board_b_idx.currVal,
             0,
             0,
             'y'
) ; 

select * from board
-- 답글쓰기
insert into board values(
             seq_board_b_idx.nextVal,
             '아쉽네 이번에도 놓쳤네',
             '다음에는 내가 1등해야지',
             '172.30.1.77',
             0,
             sysdate,
             sysdate,
             2,
             '김관리',
             1,
             1,
             1,
             'y'
) ; 

insert into board values(
             seq_board_b_idx.nextVal,
             '그래 다음에는 니가 1등해',
             '어림업지...',
             '172.30.1.77',
             0,
             sysdate,
             sysdate,
             1,
             '일길동',
             1,
             2,
             2,
             'y'
) ; 


-- Paging 처리를 위한 SQL

select * from
(
	select 
	  rank() over(order by b_ref desc , b_step asc) as no,
	  b.* ,
	  (select nvl(count(*),0) from comment_tb where b_idx=b.b_idx) as cmt_count	
	  -- 인라인뷰(임시로 만들어서 쓰고 버리는 뷰)
	from (select * from board) b
)
where no between 1 and 5

select nvl(count(*),0) from board

-- 댓글 개수 구하기
select * from comment_tb

select count(*) from comment_tb where b_idx=386

select nvl(count(*),0) from comment_tb where b_idx=386












*/