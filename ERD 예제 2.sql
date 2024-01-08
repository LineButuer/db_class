use db_dbclass;


drop table if exists members;
create table members(
	id bigint auto_increment primary key,
    member_email varchar(30) not null unique,
    member_name varchar(20) not null,
    member_password varchar (20) not null
);
-- 1. 회원가입(임의의 회원3명 가입)
insert members (member_email, member_name, member_password) values ('aaa@aaa.com', '이태양', '1234');
insert members (member_email, member_name, member_password) values ('bbb@bbb.com', '지코', '2345');
insert members (member_email, member_name, member_password) values ('ccc@ccc.com', '김인호', '3456');
select * from members;

-- 2. 이메일 중복체크 
select member_password ,id from members group by member_password having count(*)>1;
select member_email, id from members where member_email = (select member_email from members where member_email);
select member_email from members where member_email = 'aaa@aaa.com';

-- 3. 로그인
select * from members where member_email = 'aaa@aaa.com' and member_password = '1234';
-- 4. 전체 회원 목록 조회 
select * from members;
-- 5. 특정 회원만 조회 
select * from members where id =1; 
-- 6. 내정보 수정하기(6.1, 6.2에 해당하는 쿼리문작성)
select * from members where id =1;
-- 6.1 회원정보 수정화면 요청(회원정보 수정 페이지를 보여준다고 가정했을 때 필요한 쿼리) 
select * from members where id =1;
-- 6.2 회원정보 수정 처리(비밀번호를 변경한다는 상황)
update member set member_password ='4321' where id =1;
-- 7. 회원 삭제 또는 탈퇴 
delete from members where id =4;
drop table if exists good;
create table good(
	id bigint auto_increment primary key,
    comments_id bigint,
    members_id bigint,
    constraint fk_good foreign key (comments_id) references comments(id),
    foreign key (members_id) references members(id)
);

drop table if exists category;
create table category(
	id bigint auto_increment primary key,
    category_name varchar(20) not null unique 
    );

insert into category (category_name) value ('게시판');
insert into category (category_name) value ('공지사항');
insert into category (category_name) value ('가입인사');



drop table if exists board;
create table board(
	id bigint auto_increment primary key,
    board_title varchar(50) not null,
    board_writer varchar (30) not null,
    board_contents varchar(500),
    board_hits int default 0,
    board_created_at datetime default now(),
    board_updated_at datetime on update now(),
    board_file_attached int default 0, -- 파일 첨부 여부(없으면 0, 있으면1)
    members_id bigint,
    category_id bigint,
	constraint fk_board foreign key (members_id) references members(id) on delete cascade,
	constraint fk_board_category foreign key (category_id) references category(id) on delete set null
);
-- 게시판 기능 
-- 1. 게시글 작성(파일첨부 x) 3개 이상 
-- 1번 회원이 자유게시판 글 2개, 공지사항 글 1개 작성 
-- 2번 회원이 자유게시판 글 3개 작성
-- 3번 회원이 가입인사 글 1개 작성 
select * from board;
insert into board (board_title, board_writer, board_contents, board_file_attached, members_id, category_id) values ('hi', '이태양', '항하이', 0,  1, 1);
insert into board (board_title, board_writer, board_contents, board_file_attached, members_id, category_id) values ('hi', '이태양', '항하이', 0,  1, 2);
insert into board (board_title, board_writer, board_contents, board_file_attached, members_id, category_id) values ('hi2', '이재용2', '항하이2', 0, 2, 1);
insert into board (board_title, board_writer, board_contents, board_file_attached, members_id, category_id) values ('hi3', '이재용3', '항하이1', 0, 5, 3);
-- 1.1. 게시글 작성(파일첨부 o)
insert into board (board_title, board_writer, board_contents, board_file_attached, members_id, category_id) values ('hi3', '이재용3', '항하이1', 1, 5, 1);
-- 2.1 전체글 목록 조회
select * from board;
-- 2. 게시글 목록 조회
select * from board where category_id = '1';
-- 2.3 공지사항 목록 조회 
select * from board where category_id = '2';
-- 2.4 목록 조회시 카테고리 이름도 함께 나오게 조회
select *, category_name from board b, category c where c.id = b.category_id and category_id = '2';
-- 3. 2번 게시글 조회 (조회수 처리 필요함)
select * from board b where id = 16;
select * from board b where id =6 ;
update board set board_hits =  board_hits+1 where id =16;
-- 3.1. 파일 첨부된 게시글 조회 (게시글 내용과 파일을 함께)
select * from board  where id =21;
select * from board_file  where board_id =21;
select * from board b, board_file bf where b.id = bf.board_id and b.id =21;
select * from board b, board_file bf where b.id = bf.board_id and board_file_attached =1;
-- 4. 1번 회원이 자유게시판에 첫번째로 작성한 게시글의 제목, 내용 수정
-- 조회를 먼저 하고 수정한는게 좋음
select * from board where members_id =1;
update board set board_title = 'hhi', board_contents = '6번 게시물' where id = 6;
-- 5. 2번 회원이 자유게시판에 첫번째로 작성한 게시글 삭제
delete from board where members_id =2 and id =9 and category_id=1;
drop table if exists board_file;
create table board_file (
	id bigint auto_increment primary key,
    original_file_name varchar(100),
    stored_file_name varchar(100),
    board_id bigint,
    constraint fk_board_file foreign key (board_id) references board(id) on delete cascade
);

insert into board_file (original_file_name, stored_file_name, board_id) values ('1', '1', 21);

drop table if exists comments;
create table comments(
	id bigint auto_increment primary key,
    commnets_writer varchar(30) not null,
    comments_contents varchar(200) not null,
    commnet_created_at datetime default now(),
    board_id bigint,
    members_id bigint,
    constraint fk_comments_board foreign key (board_id) references board(id),
    constraint fk_commnets_members foreign key (members_id) references members(id)
    );