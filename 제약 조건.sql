-- 제약 조건
-- id, member_email, member_password 컬럼이 있는 테이블
drop table if exists member1; -- 보통 테이블 만들면 drop도 같이 써줌
create table member1(
	id bigint,
	member_email varchar(20),
    member_password varchar(20)
);
insert into member1(id, member_email, member_password) values(1, 'aa@aa.com', '1234');
-- 모든 컬럼에 값을 다 넣을 때는 컬럼이름 생략 가능
insert into member1 values(2, 'bb@bb.com', '1234');
-- 특정 컬럼만 값을 넣을 때는
insert into member1 values(3, 'cc@cc.com', '1234');
insert into member1(id, member_email) value(3, 'cc@cc.com');
select * from member1;
insert into member1 values(4, 'dd@dd.com', null);

-- not null
drop table if exists member2;
create table member2(
	id bigint not null,
	member_email varchar(20),
    member_password varchar(20)
    );
    select * from member2;
    insert into member2(id, member_email, member_password) values(1, 'aa@aa.com', '1234');
    -- id를 제외하고 나머지 값만 입력
    insert into member2(member_email, member_password) values('bb@bb.com', '1234');
    insert into member2(id, member_email, member_password) values(null, 'cc@cc.com', '1234');
    insert into member2(id, member_email, member_password) values(4, null, '1234');
    
drop table if exists member3;
create table member3(
	id bigint not null unique,
	member_email varchar(20) not null,
    member_password varchar(20) not null
    );
    select *from member3;
    insert into member3(id, member_email, member_password) values(1, 'aa@aa.com', '1234');
    insert into member3(id, member_email, member_password) values(1, 'bb@bb.com', '1234');
    insert into member3(id, member_email, member_password) values(2, 'aa@aa.com', null);
    
drop table if exists member4;
create table member4(
	id bigint not null unique,
	member_email varchar(20) not null,
    member_password varchar(20) not null,
    created_at datetime
    );
    select *from member4;
    insert into member4(id, member_email, member_password, created_at) 
			values(2, 'dd@aa.com', '1234', now());
	insert into member4(id, member_email, member_password, created_at) values(3, 'dd@aa.com', '1234');
    insert into member4(id, member_email, member_password, created_at) values(4, 'fd@aa.com', '1234');
    
drop table if exists member5;
create table member5(
	id bigint not null unique,
	member_email varchar(20) not null,
    member_password varchar(20) not null,
    created_at datetime default now()
    );
    select *from member5;
    insert into member5(id, member_email, member_password, created_at)
			values(1, 'aa@aa.com', '1234', now());
	-- default로 지정한 컬럼은 따로 값을 주지 않아도 갑이 default로 지정한 값으로 저장됨.
    insert into member5(id, member_email, member_password)
			values(1, 'aa@aa.com', '1234');
            
-- primary key
drop table if exists member6;
create table member6(
	id bigint primary key,
	member_email varchar(20) not null unique,
    member_password varchar(20) not null,
    created_at datetime default now()
    );
    select * from member6;
insert into member6(id, member_email, member_password)values(1, 'aa@aa.com', '1234');
insert into member6(id, member_email, member_password)
			values(2, 'bb@aa.com', '1234');


-- 자동 번호 저장하기             
drop table if exists member7;
create table member7(
	id bigint ,
	member_email varchar(20) not null unique,
    member_password varchar(20) not null,
    created_at datetime default now(),
    constraint pk_member7 primary key(id)
    );
    
    
-- 자동 번호 적용하기(auto_increment는 pk 컬럼에만 지정 가능)
drop table if exists member8;
create table member8(
	id bigint auto_increment ,
	member_email varchar(20) not null unique,
    member_password varchar(20) not null,
    created_at datetime default now(),
    constraint pk_member7 primary key(id)
    );
select * from member8;
-- auto_incremanet를 지정하면 값을 따로 주지 않아도 됨.
insert into member8(member_email, member_password)values('aa@aa.com', '1234');
insert into member8(member_email, member_password)values('bb@bb.com', '1234');

-- 참조관계
drop table if exists parent1;
create table parent1(
	id bigint primary key,
    p1 varchar(10),
    p2 varchar(20)
);

drop table if exists child1;
create table child1(
	id bigint primary key,
    c1 varchar(10),
    c2 varchar(20),
    p_id bigint, -- 참조할 컬럼
    -- 외래키 지정(p_id 컬럼을 parent1 테이블의 id 컬럼을 참조하도록 함)
    constraint fk_child1 foreign key(p_id) references parent1(id)
    );
    
    insert into parent1(id, p1, p2) values(1, 'aa', 'aa');
    insert into parent1(id, p1, p2) values(2, 'bb', 'bb');
    insert into parent1(id, p1, p2) values(3, 'cc', 'cc');
    insert into parent1(id, p1, p2) values(4, 'dd', 'dd');
    select * from parent1;
    
    insert into child1(id, c1, c2, p_id) values(1, 'aaa', 'aaa', 1);
    -- 부모 id 컬럼에 없는 값을 p_id에 저장
    insert into child1(id, c1, c2, p_id) values(2, 'bbb', 'bbb', 2);
    insert into child1(id, c1, c2, p_id) values(3, 'ccc', 'ccc', 3);
    select * from child1;
    
    -- 부모 테이블의 데이터 삭제. 테이블 삭제 하는 게 아님
    -- id = 2인 데이터 한 줄을 삭제
    -- 자식 테이블에 id=2인 데이터를 참조하는 부분이 있기 때문에 삭제 불가 
    delete from parent1 where id = 2;
    -- 자식 테이블에 id=4인 데이터를 참조하는 부분이 없기 때문에 삭제 가능
    delete from parent1 where id = 4;
    -- 자식 테이블의 부모 id=2를 참조하는 데이터 삭제
    delete from child1 where id =2;
    


drop table if exists parent2;
create table parent2(
	id bigint primary key,
    p1 varchar(10),
    p2 varchar(20)
);

drop table if exists child2;
create table child2(
	id bigint primary key,
    c1 varchar(10),
    c2 varchar(20),
    p_id bigint, -- 참조할 컬럼
    -- 외래키 지정(p_id 컬럼을 parent1 테이블의 id 컬럼을 참조하도록 함)
    constraint fk_child2 foreign key(p_id) references parent2(id) on delete cascade -- 부모 데이터 삭제 시 자식 데이터도 삭제
    );
    
    
    insert into parent2(id, p1, p2) values(1, 'aa', 'aa');
    insert into parent2(id, p1, p2) values(2, 'bb', 'bb');
    insert into parent2(id, p1, p2) values(3, 'cc', 'cc');
    insert into parent2(id, p1, p2) values(4, 'dd', 'dd');
    select * from parent2;
    
    insert into child2(id, c1, c2, p_id) values(1, 'aaa', 'aaa', 1);
    -- 부모 id 컬럼에 없는 값을 p_id에 저장
    insert into child2(id, c1, c2, p_id) values(2, 'bbb', 'bbb', 2);
    insert into child2(id, c1, c2, p_id) values(3, 'ccc', 'ccc', 3);
    select * from child2;
    
    delete from parent2 where id =3;
    
drop table if exists parent3;
create table parent3(
	id bigint primary key,
    p1 varchar(10),
    p2 varchar(20)
);

drop table if exists child3;
create table child3(
	id bigint primary key,
    c1 varchar(10),
    c2 varchar(20),
    p_id bigint, -- 참조할 컬럼
    -- 외래키 지정(p_id 컬럼을 parent1 테이블의 id 컬럼을 참조하도록 함)
    constraint fk_child3 foreign key(p_id) references parent3(id) on delete set null -- 부모 데이터 삭제 시 해당 자식 테이블 데이터만 사라짐
    );
    
    insert into parent3(id, p1, p2) values(1, 'aa', 'aa');
    insert into parent3(id, p1, p2) values(2, 'bb', 'bb');
    insert into parent3(id, p1, p2) values(3, 'cc', 'cc');
    insert into parent3(id, p1, p2) values(4, 'dd', 'dd');
    select * from parent3;
	delete from parent3 where id = 1;
    insert into child3(id, c1, c2, p_id) values(1, 'aaa', 'aaa', 1);
    insert into child3(id, c1, c2, p_id) values(2, 'bbb', 'bbb', 2);
    insert into child3(id, c1, c2, p_id) values(3, 'ccc', 'ccc', 3);
    insert into child3(id, c1, c2, p_id) values(4, 'ccc', 'ccc', 4);
    select * from child3;
    
    
