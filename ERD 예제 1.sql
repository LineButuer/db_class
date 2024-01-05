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
    category_name varchar(20) not null
    );

drop table if exists board;
create table board(
	id bigint auto_increment primary key,
    board_title varchar(50) not null,
    board_writer varchar (30) not null,
    board_contents varchar(500),
    board_hits int,
    board_created_at datetime default now(),
    board_updated_at datetime on update now(),
    board_file_attached int default 0, -- 파일 첨부 여부(없으면 0, 있으면1)
    members_id bigint,
    category_id bigint,
	constraint fk_board foreign key (members_id) references members(id) on delete cascade,
	foreign key (category_id) references category(id) on delete set null
);

drop table if exists board_file;
create table board_file (
	id bigint auto_increment primary key,
    original_file_name varchar(100),
    stored_file_name varchar(100),
    board_id bigint,
    constraint fk_board_file foreign key (board_id) references board(id) on delete set null
);

drop table if exists comments;
create table comments(
	id bigint auto_increment primary key,
    commnets_writer varchar(30) not null,
    comments_contents varchar(200) not null,
    commnet_created_at datetime default now(),
    board_id bigint,
    members_id bigint,
    constraint fk_comments foreign key (board_id) references board(id),
    foreign key (members_id) references members(id)
    );