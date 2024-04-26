conn system/1234
create user boot3 identified by 1234;
grant resource, connect, dba to boot3;
conn boot3/1234

drop table member cascade constraints purge;
-- 1. index.jsp에서 시작합니다.
-- 2. 관리자 계정 admin, 비번 1234를 만듭니다.
-- 3. 사용자 계정을 3개 만듭니다.

create table member(
	id		 	varchar2(12),
	password 	varchar2(60), -- 암호화를 하면 password가 60자 필요합니다.
	name	 	varchar2(15),
	age		 	number(2),
	gender	 	varchar2(3),  
	email	 	varchar2(30), 
	auth   		varchar2(50) not null, -- 회원의 권한을 저장하는 곳으로 기본값은 'ROLE_MEMBER' 입니다.
	PRIMARY KEY(id)
);

update MEMBER 
set    auth='ROLE_ADMIN'
where  id='admin';



