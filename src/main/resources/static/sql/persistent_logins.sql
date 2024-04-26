create table persistent_logins(
	username	varchar2(64),
	series		varchar2(64), --기기, 브라우저별 쿠키를 구분할 고유 값
	token		varchar2(64), --브라우저가 가지고 있는 쿠키의 값을 검증할 인증값
	last_used	timestamp -- 가장 최신 자동 로그인 시간
);