use db_dbclass;

drop table tbl_vote_202005;
create table tbl_vote_202005(
    v_jumin char(13) not null primary key,
    v_name varchar(20),
    m_no char(1), 
    v_time char(4),
    v_area char(20),
    v_confirm char(1)
    );
select * from tbl_vote_202005;    
-- 투표이력 데이터 저장
insert into tbl_vote_202005 values ('99010110001', '김유권', '1', '0930', '제1투표장', 'N');
insert into tbl_vote_202005 values ('89010120002', '이유권', '2', '0930', '제1투표장', 'N');
insert into tbl_vote_202005 values ('69010110003', '박유권', '3', '0930', '제1투표장', 'Y');
insert into tbl_vote_202005 values ('59010120004', '홍유권', '4', '0930', '제1투표장', 'Y');
insert into tbl_vote_202005 values ('79010110005', '조유권', '5', '0930', '제1투표장', 'Y');
insert into tbl_vote_202005 values ('89010120006', '최유권', '1', '0930', '제1투표장', 'Y');
insert into tbl_vote_202005 values ('59010110007', '지유권', '1', '0930', '제1투표장', 'Y');
insert into tbl_vote_202005 values ('49010120008', '장유권', '3', '0930', '제1투표장', 'Y');
insert into tbl_vote_202005 values ('79010110009', '정유권', '3', '0930', '제1투표장', 'Y');
insert into tbl_vote_202005 values ('89010120010', '강유권', '4', '0930', '제1투표장', 'Y');
insert into tbl_vote_202005 values ('99010110011', '신유권', '5', '0930', '제1투표장', 'Y');
insert into tbl_vote_202005 values ('79010120012', '오유권', '1', '1330', '제1투표장', 'Y');
insert into tbl_vote_202005 values ('69010110013', '현유권', '4', '1330', '제2투표장', 'Y');
insert into tbl_vote_202005 values ('89010110014', '왕유권', '2', '1330', '제2투표장', 'Y');
insert into tbl_vote_202005 values ('99010110015', '유유권', '3', '1330', '제2투표장', 'Y');
insert into tbl_vote_202005 values ('79010110016', '한유권', '2', '1330', '제2투표장', 'Y');
insert into tbl_vote_202005 values ('89010110017', '문유권', '4', '1330', '제2투표장', 'Y');
insert into tbl_vote_202005 values ('99010110018', '양유권', '2', '1330', '제2투표장', 'Y');
insert into tbl_vote_202005 values ('99010110019', '구유권', '4', '1330', '제2투표장', 'Y');
insert into tbl_vote_202005 values ('79010110020', '황유권', '5', '1330', '제2투표장', 'Y');
insert into tbl_vote_202005 values ('69010110021', '배유권', '3', '1330', '제2투표장', 'Y');
insert into tbl_vote_202005 values ('79010110022', '전유권', '3', '1330', '제2투표장', 'Y');
insert into tbl_vote_202005 values ('99010110023', '고유권', '1', '1330', '제2투표장', 'Y');
insert into tbl_vote_202005 values ('59010110024', '권유권', '3', '1330', '제2투표장', 'Y');

-- 후보자 테이블 생성
drop table if exists tbl_member_202005;
create table tbl_member_202005(
    m_no char(1) not null primary key,
    m_name varchar(20),
    p_code char(2),
    p_school char(1),
    m_jumin char(13),
    m_city varchar(20)
    );
select * from tbl_member_202005;    
-- 후보자 데이터 저장
insert into tbl_member_202005 values ('1', '김후보', 'P1', '1', '6603011999991', '수선화동');
insert into tbl_member_202005 values ('2', '이후보', 'P2', '3', '5503011999992', '민들래동');
insert into tbl_member_202005 values ('3', '박후보', 'P3', '2', '7703011999993', '나팔꽃동');
insert into tbl_member_202005 values ('4', '조후보', 'P4', '2', '8803011999994', '진달래동');
insert into tbl_member_202005 values ('5', '최후보', 'P5', '3', '9903011999995', '개나리동');

-- concat(): 문자열을 이어 붙일 때
-- substr(): 문자열의 특정 범위를 잘라낼 때
-- 주민번호: 240109-3123123
select m.m_no as '후보번호', m.m_name as '후보이름' , p.p_name as '소속정당',
		case when p_school = 1 then '고졸'
			 when p_school = 2 then '학사'
             when p_school = 3 then '석사'
             else '없음'
             end as '학력',
             concat(substr(m_jumin, 1, 6), '-', substr(m_jumin , 6, 7)) as '주민번호', m_city as '지역구',
             concat(p.p_tel1, '-', p.p_tel2, '-', p.p_tel3) as '대표전화'
             from tbl_member_202005 m, tbl_party_202005 p where m.p_code = p.p_code;

-- 생년월일
select concat(
				case when substr(v_jumin, 7, 1) in ('1', '2') then '19'
					 when substr(v_jumin, 7, 1) in ('3', '4') then '20'
				end, 
				substr(v_jumin, 1, 2), '년 ', substr(v_jumin, 3, 2), '월 ', substr(v_jumin, 5,2), '일') as '생년월일' from tbl_vote_202005;
-- 만나이 => 현재 년도 - 태어난 년도
select now() from dual; -- 현재 시간을 알려줌
-- 현재 시간에서 년도만
select date_format(now(), '%Y') from dual;
-- 뺄셈에 활용하기 위해 형변환
select cast(date_format(now(), '%Y') as unsigned) from dual;
-- 만나이 계산
select concat(
				'만',
				cast(date_format(now(), '%Y') as unsigned) -- 현재 년도를 만듦 
				-
				concat(
                case when substr(v_jumin, 7, 1) in ('1', '2') then '19'
					 when substr(v_jumin, 7, 1) in ('3', '4') then '20'
				end,
                substr(v_jumin, 1, 2)
                ),
             '세'   
			) as '나이'
		from tbl_vote_202005;
        
-- 성별 맞추기

select v_name as '성명',  concat(
				case when substr(v_jumin, 7, 1) in ('1', '2') then '19'
					 when substr(v_jumin, 7, 1) in ('3', '4') then '20'
				end, 
				substr(v_jumin, 1, 2), '년 ', substr(v_jumin, 3, 2), '월 ', substr(v_jumin, 5,2), '일') as '생년월일' ,
                concat(
							'만',
							cast(date_format(now(), '%Y') as unsigned) -- 현재 년도를 만듦 
							-
							concat(
									case when substr(v_jumin, 7, 1) in ('1', '2') then '19'
										when substr(v_jumin, 7, 1) in ('3', '4') then '20'
										end,
									substr(v_jumin, 1, 2)
							),
						'세'   
					) as '나이',
                case 
					when substr(v_jumin, 7, 1) in (1, 3) then '남'
					when substr(v_jumin, 7, 1) in (2, 4) then '여'
                    end as '성별',m_no as 후보번호 ,
                    concat( substr(v_time, 1, 2), ':', substr(v_time, 3,4)) as '투표시간',
                    case 
			when v_confirm = 'Y' then '확인'
            when v_confirm = 'N' then '미확인'
            end as '유권자확인'
	 from tbl_vote_202005;
        
-- 시간 생성
select concat( substr(v_time, 1, 2), ':', substr(v_time, 3,4)) as '투표시간' from tbl_vote_202005;

-- 유권자 확인 
select case 
			when v_confirm = 'Y' then '확인'
            when v_confirm = 'Y' then '확인'
            end as '유권자확인'
		from tbl_vote_202005;
        
        
select m.m_no as '후보번호', m_name as '성명', count(v.m_no) as '총득표건수'
	from tbl_member_202005 m, tbl_vote_202005 v 
		where m.m_no = v.m_no and v.v_confirm = 'Y'
			group by v.m_no order by count(v.m_no) desc , m.m_name asc ;
		
        
-- 정당 테이블 생성
drop table tbl_party_202005;
create table tbl_party_202005(
    p_code char(2) not null primary key,
    p_name varchar(20),
    p_indate date,
    p_reader varchar(20),
    p_tel1 char(3),
    p_tel2 char(4),
    p_tel3 char(4)
    );
select * from tbl_party_202005;
-- 정당 데이터 저장    
insert into tbl_party_202005 values ('P1', 'A정당', '2010-01-01', '위대표', '02', '1111', '0001');
insert into tbl_party_202005 values ('P2', 'B정당', '2010-02-01', '명대표', '02', '1111', '0002');
insert into tbl_party_202005 values ('P3', 'C정당', '2010-03-01', '기대표', '02', '1111', '0003');
insert into tbl_party_202005 values ('P4', 'D정당', '2010-04-01', '옥대표', '02', '1111', '0004');
insert into tbl_party_202005 values ('P5', 'E정당', '2010-05-01', '임대표', '02', '1111', '0005');
