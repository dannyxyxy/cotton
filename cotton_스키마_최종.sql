
-----------------  상품 관리 스키마 -----------------

-- 1. 객체 삭제
    -- 1-1. 상품가격, 상품이미지, 상품, 카테고리, 관심상품, 장바구니 테이블 삭제
    DROP Table goods_price CASCADE CONSTRAINTS;
    DROP Table goods_image CASCADE CONSTRAINTS;
    DROP Table goods CASCADE CONSTRAINTS;
    DROP Table category CASCADE CONSTRAINTS;
    DROP Table wish CASCADE CONSTRAINTS;
    DROP Table cart CASCADE CONSTRAINTS;
    
    -- 1-2. 상품가격, 상품이미지, 상품, 카테고리, 관심상품, 장바구니 시퀀스 삭제   
    DROP SEQUENCE goods_price_seq;
    DROP SEQUENCE goods_image_seq;
    DROP SEQUENCE goods_seq;
    DROP SEQUENCE wish_seq;
    DROP SEQUENCE cart_seq;
     
    
--2.객체 세팅(table, sequence 생성)
    --2-1.Category Table (카테고리)
    CREATE TABLE category (
        cate_code1 NUMBER(3),                       -- 카테고리 코드
        cate_name VARCHAR2(30) not null,            -- 카테고리 이름
        CONSTRAINT category_pk PRIMARY KEY (cate_code1)
    );
    
    --2-2.Goods Table (상품)
    CREATE TABLE goods(
        goods_no NUMBER PRIMARY KEY,                -- 상품 번호
        goods_name VARCHAR2(300) not null,          -- 상품 이름
        company VARCHAR2(60),                       -- 제조사
        goods_code VARCHAR2(10) NOT NULL UNIQUE,    -- 상품 코드
        image_name VARCHAR2(300) not null,          -- 상품 이미지 파일 경로
        content VARCHAR2(2000),                     -- 상품 정보(내용)
        cate_code1 NUMBER(3) not null,              -- 카테고리 코드
        CONSTRAINT goods_fk FOREIGN KEY (cate_code1) REFERENCES category(cate_code1) -- catgory 테이블에서 카테고리 코드 사용 
    );
    
    --2-3.goods_image Table(상품이미지)
    CREATE TABLE goods_image(
        goods_img_no NUMBER PRIMARY KEY,          -- 상품 이미지 번호
        goods_img_name VARCHAR2(300) not null,    -- 상품 이미지 경로
        goods_no NUMBER REFERENCES goods(goods_no) on DELETE CASCADE NOT NULL  -- goods 테이블에서 상품번호 사용 
    );
    
    --2-4.Price Table(상품가격)
    CREATE TABLE goods_price(
        goods_price_no NUMBER PRIMARY KEY,        -- 상품 가격 번호
        price NUMBER(9) not null,                 -- 상품 가격
        sale_price NUMBER(9) not null,            -- 할인 가격     
        discount_rate NUMBER(3) default 0,        -- 할인율
        delivary_charge VARCHAR2(60) default 0,   -- 배송비  
        goods_no NUMBER REFERENCES goods(goods_no) on DELETE CASCADE NOT NULL  -- goods 테이블에서 상품번호 사용
    );
    
    --2-5.wish Table(관심 상품)    
    CREATE TABLE wish (
        wish_no NUMBER PRIMARY KEY,               -- 관심 상품 항목 번호
        total NUMBER(9),                          -- 총 수량
        id VARCHAR2(255),                         -- 사용자 ID
        goods_no NUMBER REFERENCES goods(goods_no) on DELETE CASCADE NOT NULL  -- goods 테이블에서 상품번호 사용
    );
    
     --2-5.cart Table(장바구니)    
    CREATE TABLE cart (
        cart_no NUMBER PRIMARY KEY,               -- 장바구니 항목 번호
        total NUMBER(9),                          -- 총 수량
        total_price NUMBER(9),                    -- 총 가격
        quantity NUMBER(9), --갯수증가감소에 필요한 필드
        goods_no NUMBER REFERENCES goods(goods_no) ON DELETE CASCADE NOT NULL, -- goods 테이블에서 상품번호 사용
        id VARCHAR(50) NOT NULL                   -- 사용자 ID
    );
    
    --sequence 생성
    create SEQUENCE goods_seq;
    create SEQUENCE goods_image_seq;
    create SEQUENCE goods_price_seq;
    create SEQUENCE wish_seq;
    create SEQUENCE cart_seq;
    
--3.샘플 데이터 추가
    --3-1.category data / NVL(A,B) : A가 null이면 B로 적용된다. 대분류입력 --> 카테고리 샘플 데이터
    insert into category(cate_code1, cate_name) values((select NVL(max(cate_code1),0)+1 from category),'의자');
    insert into category(cate_code1, cate_name) values((select NVL(max(cate_code1),0)+1 from category),'소품');
    insert into category(cate_code1, cate_name) values((select NVL(max(cate_code1),0)+1 from category),'침구');
    insert into category(cate_code1, cate_name) values((select NVL(max(cate_code1),0)+1 from category),'테이블');
    insert into category(cate_code1, cate_name) values((select NVL(max(cate_code1),0)+1 from category),'수납');
    insert into category(cate_code1, cate_name) values((select NVL(max(cate_code1),0)+1 from category),'커튼');
    insert into category(cate_code1, cate_name) values((select NVL(max(cate_code1),0)+1 from category),'러그');
    insert into category(cate_code1, cate_name) values((select NVL(max(cate_code1),0)+1 from category),'조명');
    commit;
    select * from category;

    -- 3-2. goods table --> 상품 샘플 데이터
    insert into goods(goods_no, goods_name, company, goods_code, image_name, content, cate_code1) values (goods_seq.nextval, 
    '아스크볼 Askvol','IKEA','C001','/upload/goods/bed02.png','이케아에서 자신있게 출시한 스웨덴 스타일의 침대입니다.','3');
    commit;
    select * from goods;
    
    -- 3-3. goods_image table --> 상품 이미지 샘플 데이터
    insert into goods_image(goods_img_no, goods_img_name, goods_no) values(goods_image_seq.nextval, '/upload/goods/bed02.png',1);
    commit;
    select * from goods_image;
    
    -- 3-4. goods_price table  --> 상품 가격 샘플 데이터
    insert into goods_price(goods_price_no, price, sale_price, discount_rate, delivary_charge, goods_no)
    values (goods_price_seq.nextval, '300000', '270000', '10', '배송무료(설치비용별도)',1);
    commit;
    select * from goods_price;
    
    
    
-----------------  회원 관리 스키마 -----------------    

-- 1. 객체 삭제
    -- 회원등급, 회원정보 테이블 삭제
    drop table member CASCADE CONSTRAINTS PURGE;
    drop table grade CASCADE CONSTRAINTS PURGE;
    
    -- 회원등급, 회원정보 시퀀스 삭제
    DROP SEQUENCE grade_seq;
    DROP SEQUENCE member_seq;

-- 2. 객체 세팅 (table, sequence 생성)
    -- 2-1. grade table (회원 등급) 
    create table grade (
        gradeNo number(1) primary key,          -- 회원 번호
        gradeName VARCHAR2(21) not null         -- 회원 등급
    );
    
    -- 2-2. member table (회원 정보)
    CREATE TABLE member (
        id VARCHAR2(20) PRIMARY KEY,            -- 아이디
        pw VARCHAR2(20) NOT NULL,               -- 비밀번호
        name VARCHAR2(30) NOT NULL,             -- 이름
        gender VARCHAR2(6) NOT NULL,            -- 성별    
        birth DATE NOT NULL,                    -- 생년월일
        tel VARCHAR2(13),                       -- 전화번호
        email VARCHAR2(50) NOT NULL,            -- 이메일
        address VARCHAR2(300),                  -- 주소
        status VARCHAR2(6) DEFAULT '정상',       -- 회원상태
        photo VARCHAR2(300),                    -- 프로필 이미지 파일 경로
        regDate DATE DEFAULT SYSDATE,           -- 회원가입 날짜
        gradeNo NUMBER(1) DEFAULT 1,            -- 회원 번호
        CONSTRAINT fk_member_grade FOREIGN KEY (gradeNo) REFERENCES grade(gradeNo)  -- grade 테이블에서 회원등급 사용
    );

    --sequence 생성
    create SEQUENCE grade_seq;
    create SEQUENCE member_seq;
    
-- 3. 샘플 데이터 추가
    -- 3-1. grade Table --> 회원 등급 샘플 데이터
    insert into grade values (1, '일반회원');
    insert into grade values (9, '관리자'); 
    commit;
    select * from grade;
    
    -- 3-2. member Table --> 회원 정보 샘플 데이터
    insert into member (id, pw, name, gender, birth, email, address, gradeNo, photo, regDate) 
    values ('admin', 'admin', '관리자', '여자', '1975-04-23', 'admin@naver.com', '은평구', 9, '/upload/member/profile.png', sysDate);    
    insert into member (id, pw, name, gender, birth, email, address, gradeNo, photo, regDate )  
    values ('test1', 'test1', '테스트', '남자', '2000-01-01', 'test1@naver.com', '일산동구' , 1, '/upload/member/profile.png', sysDate);    
    commit;
    select * from member;
    
    
    
-----------------  이벤트 게시판 스키마 -----------------    
--1. 객체 삭제
    -- 1-1. 이벤트 테이블 삭제
    drop table event cascade CONSTRAINTS;
    
    -- 1-2. 이벤트 시퀀스 삭제
    drop SEQUENCE event_seq;
    
--2. 객체 세팅 (table, sequence 생성)    
    -- 2-1. event Table (이벤트)
    create table event(
        eno number primary key,                 -- 이벤트 번호 
        title varchar2(300) not null,           -- 이벤트 제목
        content varchar2(2000) not null,        -- 이벤트 내용
        startDate date default '2000-01-01',    -- 시작일
        endDate date default '2000-01-01',      -- 종료일
        writeDate date default '2000-01-01',    -- 작성일
        imageName varchar2(300) NOT NULL        -- 이벤트 이미지 파일 경로
    );
    
    -- sequence 생성
    create SEQUENCE event_seq;

-- 3. 샘플 데이터 추가
    -- event Table --> 이벤트 샘플 데이터 추가
    insert into event(eno, title, content, startDate, endDate, writeDate, imageName) 
    values(event_seq.nextval, '이벤트', '새로 시작한 이벤트', '2000-01-01', '2000-01-01', '2000-01-01', '/upload/event/bed01.png');
    commit;    
    select * from event;
    
 
 -----------------  고객문의 게시판 스키마 -----------------     
--1. 객체 삭제
    -- 1-1. 고객문의 테이블 삭제
    drop table qna CASCADE CONSTRAINTS PURGE;
    
    -- 1-2. 고객문의 시퀀스 삭제
    drop SEQUENCE qna_seq;
    
-- 2. 객체 세팅(table, sequence 생성)
    --2-1. qna Table (고객문의)
    CREATE TABLE qna (
        no NUMBER PRIMARY KEY,                      -- 문의 번호
        id VARCHAR2(20) NOT NULL,                   -- 로그인 아이디
        title VARCHAR2(300) NOT NULL,               -- 문의 재목
        content VARCHAR2(2000) NOT NULL,            -- 문의 내용   
        replyContent VARCHAR2(2000),                -- 답변 내용
        goods_code VARCHAR2(10) NOT NULL,           -- 상품 코드 
        writeDate DATE DEFAULT SYSDATE,             -- 작성일
        replyDate DATE DEFAULT SYSDATE,             -- 답변일
        qna_image_name VARCHAR2(300),               -- 문의 이미지 파일 경로
        CONSTRAINT fk_qna_member FOREIGN KEY (id) REFERENCES member(id) ON DELETE CASCADE,                  -- member 테이블에서 회원 아이디 사용
        CONSTRAINT fk_qna_goods FOREIGN KEY (goods_code) REFERENCES goods(goods_code) ON DELETE CASCADE     -- goods 테이블에서 상품 코드 사용
    );
    
    
    -- 시퀀스 생성
    create SEQUENCE qna_seq;
    
-- 3. 샘플 데이터 추가
    -- qna Table --> 샘플 데이터 추가  
    INSERT INTO qna(no, id, title, content, replyContent, goods_code, writeDate, replyDate)
    VALUES (qna_seq.nextval, 'admin', '상품 문의 제목', '상품에 대한 문의 내용입니다.', '상품에 대한 답변 내용입니다.', 'C001', SYSDATE, SYSDATE);   
    insert into qna(no, id, title, content, replyContent, goods_code, writeDate, replyDate)
    values(qna_seq.nextval, 'test1', '테스트문의2. 제목', '문의사항 테스트 중입니다.내용2','1','C001',  SYSDATE, SYSDATE);
    commit;

-----------------  리뷰 게시판 스키마 -----------------  
--1. 객체 삭제
    -- 1-1. 리뷰, 리뷰 좋아요 테이블 삭제
    DROP TABLE review cascade constraints purge;
    DROP TABLE review_likes CASCADE CONSTRAINTS PURGE;
  
    -- 1-2. 리뷰 시퀀스 삭제 
    drop sequence review_seq;
    
    -- 필요한 경우 기존 제약 조건을 개별적으로 삭제
    -- DROP CONSTRAINT fk_review_rno;
    -- DROP CONSTRAINT fk_user_id;
    
    
-- 2. 객체 세팅 (table, sequence 생성)
    -- 2-1. review Table (리뷰)
    CREATE TABLE review (
        rno NUMBER PRIMARY KEY,                                 -- 리뷰 번호
        goods_no NUMBER REFERENCES goods(goods_no) NOT NULL,    -- 상품 번호 
        title VARCHAR2(300) NOT NULL,                           -- 리뷰 제목
        content VARCHAR2(2000) NOT NULL,                        -- 리뷰 내용
        id VARCHAR2(30) REFERENCES member(id) NOT NULL,         -- 작성자 아이디
        writeDate DATE DEFAULT sysdate,                         -- 작성일
        likeCount NUMBER DEFAULT 0,                             -- 리뷰 좋아요 개수
        status VARCHAR2(100) DEFAULT 'ACTIVE'                   -- 리뷰 상태 
    );
    

    -- 2-2. review_likes Table (리뷰 좋아요)
    CREATE TABLE review_likes (
        user_id VARCHAR2(30) NOT NULL,               -- 로그인 아이디
        review_rno NUMBER NOT NULL,                  -- 리뷰 번호 
        PRIMARY KEY (user_id, review_rno),           -- 각 사용자당 각 리뷰에 대해 좋아요 1회 제한
        CONSTRAINT fk_review_rno FOREIGN KEY (review_rno) REFERENCES review(rno),   -- review 테이블에서 리뷰 번호 사용
        CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES member(id)           -- member 테이블에서 아이디 사용
    );
    
    -- 시퀀스 생성
    create sequence review_seq;

-- 3. 샘플 데이터 추가
    -- 리뷰 샘플데이터
    -- 리뷰에는 글넘버가 들어갑니다.
    select max(goods_no) from review;
    
    -- review Table --> 리뷰 샘플 데이터 추가
    insert into review(rno, goods_no, title, content, id, writeDate, likeCount, status)
    values (review_seq.nextval, 1, '사진이랑 똑같아요!', '만족합니다.', 'admin', sysdate, 0, '제품평가');        
    insert into review(rno, goods_no, title, content, id, writeDate, likeCount, status)
    values (review_seq.nextval, 2, '괜찮네요', '만족.', 'test1', sysdate, 0, '제품평가'); 
    insert into review(rno, goods_no, title, content, id, writeDate, likeCount, status)
    values (review_seq.nextval, 3, '괜찮네요', '만족.', 'test1', sysdate, 0, '제품평가');       
    commit;    
    select * from review;
    

