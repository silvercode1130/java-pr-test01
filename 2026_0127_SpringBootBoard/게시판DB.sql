
-- 일련번호 관리
create sequence seq_board_b_idx;

-- 테이블
create table board(
	b_idx		int,						-- 일련번호
	b_subject	varchar2(500) not null,		-- 제목
	b_content	clob not null,				-- 내용
	b_ip		varchar2(100) not null,		-- ip
	b_readhit	int,						-- 조회수
	b_regdate	date,						-- 등록일자
	b_moddate	date,						-- 수정일자
	mem_idx		int,						-- 회원번호
	mem_id		varchar2(100) not null,		-- 회원아이디
	b_ref		int,						-- 참조글 번호
	b_step		int,						-- 글순서
	b_depth		int,						-- 글깊이(답글)
	b_use		char(1) default 'y',			-- 사용유무
	mem_name	varchar2(100)
);

-- 기본키
alter table board
	add constraint pk_board_b_idx primary key(b_idx);

-- 사용 유무 check 제약
alter table board
	add constraint ck_board_b_use check(b_use in ('y','n'));
	
-- name 컬럼 추가+fk 참조 추가
alter table board
	add mem_name varchar2(100);
alter table board
	add constraint fk_board_mem_name
	foreign key(mem_name) references member(mem_name);
	
-- name 값 채워주기
UPDATE board b
SET mem_name = (
  SELECT m.mem_name
  FROM member m
  WHERE m.mem_idx = b.mem_idx
);

SELECT column_name, data_type, nullable
FROM user_tab_columns
WHERE table_name = 'BOARD';

	
update board set b_use='Y'
	
-- Foreign key 제약
alter table board
	add constraint fk_board_mem_idx
	foreign key(mem_idx) references member(mem_idx);
	-- on delete cascade -- 부모키가 삭제되면 자식도 삭제해라
	-- on update cascade -- 부모키가 업데이트되면 자식도 업데이트해라
	
select * from member;
select * from board;

delete from board where b_subject like '%img%';

-- sample data
-- 새글쓰기
insert into board values(
	seq_board_b_idx.nextVal,
	'아싸 1빠',
	'1빠ㅋㅋㅋ',
	'172.30.1.28',
	0,
	sysdate,
	sysdate,
	1,
	'일길동',
	seq_board_b_idx.currVal,
	0,
	0,
	'y',
	'일길동'
);

insert into board values(
	seq_board_b_idx.nextVal,
	'등수놀이 금지',
	'공지 안 읽나 언제적 등수놀이임',
	'172.30.1.77',
	0,
	sysdate,
	sysdate,
	3,
	'김관리',
	1,
	1,
	1,
	'y',
	'김관리',
);

insert into board values(
	seq_board_b_idx.nextVal,
	'ㅈㅅ합니다 몰랐네요',
	'글은 삭제하겠습니다',
	'172.30.1.28',
	0,
	sysdate,
	sysdate,
	1,
	'일길동',
	1,
	2,
	2,
	'y',
	'일길동'
);

select * from board order by b_ref desc, b_step asc;

*/