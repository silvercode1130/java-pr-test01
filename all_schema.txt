-- 0. 코드 테이블
CREATE TABLE role (
    role_idx    NUMBER        PRIMARY KEY,
    role_name   VARCHAR2(20)  NOT NULL           -- user / doctor / admin
);

CREATE TABLE grade (
    grade_idx             NUMBER        PRIMARY KEY,
    grade_name            VARCHAR2(20)  NOT NULL, -- basic / silver / gold / vip
    grade_discount_rate   NUMBER(5,2)   NOT NULL  -- 0.05, 0.10, 0.20
);

-- 1. 회원
CREATE TABLE member (
    mem_idx        NUMBER         PRIMARY KEY,
    mem_id         VARCHAR2(50)   UNIQUE NOT NULL,
    mem_pwd        VARCHAR2(100)  NOT NULL,
    mem_name       VARCHAR2(50),
    mem_tel        VARCHAR2(20),
    mem_email      VARCHAR2(100),
    mem_ip		   VARCHAR2(100)  NOT NULL,
    mem_role_idx   NUMBER         NOT NULL,
    mem_grade_idx  NUMBER         NOT NULL,
    mem_bday       DATE,
    mem_regdate    DATE           DEFAULT SYSDATE,
    mem_is_deleted CHAR(1) 		  DEFAULT 'N',
    mem_deldate	   DATE,
    CONSTRAINT fk_member_role
        FOREIGN KEY (mem_role_idx)  REFERENCES role(role_idx),
    CONSTRAINT fk_member_grade
        FOREIGN KEY (mem_grade_idx) REFERENCES grade(grade_idx),
    CONSTRAINT ck_mem_is_deleted
    	CHECK (mem_is_deleted IN ('Y','N'))
);

CREATE TABLE member_profile (
    mem_idx        NUMBER        PRIMARY KEY,
    mem_nickname   VARCHAR2(50),
    mem_intro      VARCHAR2(255),
    mem_img        VARCHAR2(255),
    CONSTRAINT fk_profile_member
        FOREIGN KEY (mem_idx) REFERENCES member(mem_idx)
        ON DELETE CASCADE
);

CREATE TABLE member_addr (
    addr_idx          NUMBER        PRIMARY KEY,
    mem_idx           NUMBER        NOT NULL,
    mem_zipcode       VARCHAR2(10),
    mem_addr          VARCHAR2(255),
    mem_addr_detail   VARCHAR2(255),
    CONSTRAINT fk_addr_member
        FOREIGN KEY (mem_idx) REFERENCES member(mem_idx)
        ON DELETE CASCADE
);

-- 2. 반려동물
CREATE TABLE pet (
    pet_idx      NUMBER        PRIMARY KEY,
    mem_idx      NUMBER        NOT NULL,
    pet_name     VARCHAR2(50)  NOT NULL,
    is_primary   CHAR(1)       DEFAULT 'N',
    pet_species  VARCHAR2(50),
    pet_gender   VARCHAR2(10),
    pet_breed    VARCHAR2(50),
    pet_age      NUMBER(3),
    pet_bday     DATE,
    CONSTRAINT fk_pet_member
        FOREIGN KEY (mem_idx) REFERENCES member(mem_idx)
        ON DELETE CASCADE,
	CONSTRAINT ck_is_primary
		CHECK (is_primary IN ('Y','N'))
);

-- 3. 상품 / 장바구니
CREATE TABLE item_type (
    item_type_idx		NUMBER        PRIMARY KEY,
    item_type_category	VARCHAR2(50)  NOT NULL		-- 사료, 간식, 장난감, 가구 등
);

CREATE TABLE item (
    item_idx            NUMBER          PRIMARY KEY,
    item_name           VARCHAR2(200)   NOT NULL,
    item_origin_price   NUMBER(10)      NOT NULL,
    item_now_price   	NUMBER(10)		NOT NULL,
    item_stock          NUMBER          DEFAULT 0,
    item_type_idx		NUMBER			NOT NULL,
    item_for			VARCHAR2(20)  	DEFAULT 'GENERAL',	-- DOG / CAT / GENERAL
    item_is_sale		VARCHAR2(10)	DEFAULT 'N',
    item_brand			VARCHAR2(50)	DEFAULT '기타',
    item_thumbnail_img  VARCHAR2(255),
    item_detail_img     VARCHAR2(255),
    item_regdate        DATE            DEFAULT SYSDATE,
    item_moddate        DATE,
    CONSTRAINT fk_item_item_type
        FOREIGN KEY (item_type_idx) REFERENCES item_type(item_type_idx),
	CONSTRAINT ck_item_for
		CHECK (item_for IN ('DOG','CAT','GENERAL')),
    CONSTRAINT ck_item_is_sale
    	CHECK (item_is_sale IN ('Y','N'))
);

CREATE TABLE cart (
    cart_idx      NUMBER   PRIMARY KEY,
    mem_idx       NUMBER   NOT NULL,
    cart_regdate  DATE     DEFAULT SYSDATE,
    CONSTRAINT fk_cart_member
        FOREIGN KEY (mem_idx) REFERENCES member(mem_idx)
        ON DELETE CASCADE
);

CREATE TABLE cart_item (
    cart_item_idx       NUMBER   PRIMARY KEY,
    cart_idx            NUMBER   NOT NULL,
    item_idx            NUMBER   NOT NULL,
    cart_item_quantity  NUMBER   DEFAULT 1,
    CONSTRAINT fk_cart_item_cart
        FOREIGN KEY (cart_idx) REFERENCES cart(cart_idx)
        ON DELETE CASCADE,
    CONSTRAINT fk_cart_item_item
        FOREIGN KEY (item_idx) REFERENCES item(item_idx)
);

-- 4. 주문
CREATE TABLE orders_status (
    orders_status_idx   NUMBER        PRIMARY KEY,
    orders_status_name  VARCHAR2(20)  NOT NULL  -- 결제됨 / 취소됨 / 배송중 ...
);

CREATE TABLE orders (
    orders_idx              NUMBER        PRIMARY KEY,
    mem_idx                NUMBER        NOT NULL,
    orders_total_price      NUMBER(10)    NOT NULL,
    orders_grade_discount   NUMBER(10,2)  DEFAULT 0,  -- 금액 기준으로 잡음
    orders_coupon_discount  NUMBER(10,2)  DEFAULT 0,
    orders_status_idx       NUMBER        NOT NULL,
    orders_regdate          DATE          DEFAULT SYSDATE,
    CONSTRAINT fk_orders_member
        FOREIGN KEY (mem_idx) REFERENCES member(mem_idx)
        ON DELETE CASCADE,
    CONSTRAINT fk_orders_status
        FOREIGN KEY (orders_status_idx) REFERENCES orders_status(orders_status_idx)
);

CREATE TABLE orders_item (
    orders_item_idx       NUMBER     PRIMARY KEY,
    orders_idx            NUMBER     NOT NULL,
    item_idx              NUMBER     NOT NULL,
    orders_item_quantity  NUMBER     DEFAULT 1,
    orders_price_at       NUMBER(10) NOT NULL,
    CONSTRAINT fk_orders_item_orders
        FOREIGN KEY (orders_idx) REFERENCES orders(orders_idx)
        ON DELETE CASCADE,
    CONSTRAINT fk_orders_item_item
        FOREIGN KEY (item_idx)  REFERENCES item(item_idx)
);

-- 5. 커뮤니티
CREATE TABLE board_type (
    board_type_idx    NUMBER         PRIMARY KEY,
    board_type_code   VARCHAR2(50)   UNIQUE NOT NULL,
    board_type_name   VARCHAR2(100)  NOT NULL,
    board_can_comment CHAR(1)        DEFAULT 'Y' CHECK (board_can_comment IN ('Y','N')),
    board_min_role    NUMBER         NOT NULL
);

CREATE TABLE board (
    board_idx      	  NUMBER          PRIMARY KEY,
    mem_idx        	  NUMBER          NOT NULL,
    board_title       VARCHAR2(200)   NOT NULL,
    board_content  	  CLOB,
    board_ip       	  VARCHAR2(40)	  NOT NULL,
    board_tag		  VARCHAR2(40)	  DEFAULT 'NONE',	-- DOG / CAT / NONE
    board_readhit	  NUMBER		  DEFAULT 0,
    board_type_idx 	  NUMBER		  NOT NULL,
    board_regdate  	  DATE            DEFAULT SYSDATE,
    board_moddate  	  DATE,
    board_is_deleted  CHAR(1) 		  DEFAULT 'N',
    board_deldate	  DATE,
    CONSTRAINT fk_board_member
        FOREIGN KEY (mem_idx) REFERENCES member(mem_idx)
        ON DELETE CASCADE,
    CONSTRAINT fk_board_board_type
        FOREIGN KEY (board_type_idx) REFERENCES board_type(board_type_idx),
    CONSTRAINT ck_board_is_deleted
    	CHECK (board_is_deleted IN ('Y','N')),
    CONSTRAINT ck_board_tag
    	CHECK (board_tag IN ('DOG','CAT','NONE'))
);

CREATE TABLE board_file (
    file_idx            NUMBER          PRIMARY KEY,
    board_idx           NUMBER          NOT NULL,
    file_original_name  VARCHAR2(255),
    file_saved_name     VARCHAR2(255),
    file_path           VARCHAR2(500),
    file_size           NUMBER,
    file_type           VARCHAR2(50),
    file_regdate        DATE            DEFAULT SYSDATE,
    CONSTRAINT fk_board_file_board
        FOREIGN KEY (board_idx) REFERENCES board(board_idx)
        ON DELETE CASCADE
);

CREATE TABLE reply (
    reply_idx         NUMBER          PRIMARY KEY,
    board_idx         NUMBER          NOT NULL,
    mem_idx           NUMBER          NOT NULL,
    reply_content     VARCHAR2(1000),
    reply_ip          VARCHAR2(40),
    reply_regdate     DATE            DEFAULT SYSDATE,
    reply_moddate     DATE,
    reply_is_deleted  CHAR(1) 		  DEFAULT 'N',
    reply_deldate	  DATE,
    reply_ref		  NUMBER,
    reply_step		  NUMBER,
    reply_depth		  NUMBER,
    CONSTRAINT fk_reply_board
        FOREIGN KEY (board_idx) REFERENCES board(board_idx)
        ON DELETE CASCADE,
    CONSTRAINT fk_reply_member
        FOREIGN KEY (mem_idx)  REFERENCES member(mem_idx),
    CONSTRAINT ck_reply_is_deleted
    	CHECK (reply_is_deleted IN ('Y','N'))   
);

-- 1) role 코드
INSERT INTO role (role_idx, role_name) VALUES (1, 'user');
INSERT INTO role (role_idx, role_name) VALUES (2, 'doctor');
INSERT INTO role (role_idx, role_name) VALUES (3, 'admin');

-- 2) grade 코드
INSERT INTO grade (grade_idx, grade_name, grade_discount_rate) VALUES (1, 'basic', 0.00);
INSERT INTO grade (grade_idx, grade_name, grade_discount_rate) VALUES (2, 'silver', 0.05);
INSERT INTO grade (grade_idx, grade_name, grade_discount_rate) VALUES (3, 'gold', 0.10);
INSERT INTO grade (grade_idx, grade_name, grade_discount_rate) VALUES (4, 'vip', 0.20);

-- 3) item_type 코드
INSERT INTO item_type (item_type_idx, item_type_category) VALUES (1,'일반');
INSERT INTO item_type (item_type_idx, item_type_category) VALUES (2,'사료');
INSERT INTO item_type (item_type_idx, item_type_category) VALUES (3,'간식');
INSERT INTO item_type (item_type_idx, item_type_category) VALUES (4,'장난감');
INSERT INTO item_type (item_type_idx, item_type_category) VALUES (5,'위생용품');
INSERT INTO item_type (item_type_idx, item_type_category) VALUES (6,'배변용품');
INSERT INTO item_type (item_type_idx, item_type_category) VALUES (7,'의류');
INSERT INTO item_type (item_type_idx, item_type_category) VALUES (8,'방석/쿠션');
INSERT INTO item_type (item_type_idx, item_type_category) VALUES (9,'야외활동');
INSERT INTO item_type (item_type_idx, item_type_category) VALUES (10,'하우스/이동장');

-- 4) orders_status 코드
INSERT INTO orders_status (orders_status_idx, orders_status_name) VALUES (1, '결제대기');
INSERT INTO orders_status (orders_status_idx, orders_status_name) VALUES (2, '결제완료');
INSERT INTO orders_status (orders_status_idx, orders_status_name) VALUES (3, '배송중');
INSERT INTO orders_status (orders_status_idx, orders_status_name) VALUES (4, '배송완료');
INSERT INTO orders_status (orders_status_idx, orders_status_name) VALUES (5, '취소됨');
INSERT INTO orders_status (orders_status_idx, orders_status_name) VALUES (6, '환불완료');

-- 5) board_type 코드
-- 공지사항: 관리자만 글쓰기, 댓글 X
INSERT INTO board_type (
  board_type_idx, board_type_code, board_type_name,
  board_can_comment, board_min_role
) VALUES (
  1, 'NOTICE', '공지사항', 'N', 3
);

-- 이벤트: 관리자만 글쓰기, 댓글 X
INSERT INTO board_type (
  board_type_idx, board_type_code, board_type_name,
  board_can_comment, board_min_role
) VALUES (
  2, 'EVENT', '이벤트', 'N', 3
);

-- 연구소: 수의사 이상 글쓰기, 댓글 X
INSERT INTO board_type (
  board_type_idx, board_type_code, board_type_name,
  board_can_comment, board_min_role
) VALUES (
  3, 'LAB', '연구소', 'N', 2
);

-- QnA: 유저 이상 글쓰기, 댓글은 나중에 로직으로 수의사 이상 처리
INSERT INTO board_type (
  board_type_idx, board_type_code, board_type_name,
  board_can_comment, board_min_role
) VALUES (
  4, 'QNA', 'QnA', 'Y', 1
);

-- 자유게시판: 유저 모두 글/댓글 가능
INSERT INTO board_type (
  board_type_idx, board_type_code, board_type_name,
  board_can_comment, board_min_role
) VALUES (
  5, 'FREE', '자유게시판', 'Y', 1
);

-- 시퀀스 관리
CREATE SEQUENCE seq_mem_idx START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_pet_idx START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_item_idx START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_cart_idx START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_cart_item_idx START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_orders_idx START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_orders_item_idx START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_board_idx START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_board_file_idx START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_reply_idx START WITH 1 INCREMENT BY 1;