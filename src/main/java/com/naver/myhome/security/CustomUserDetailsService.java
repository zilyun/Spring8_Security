package com.naver.myhome.security;

import java.util.ArrayList;
import java.util.Collection;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

import com.naver.myhome.domain.Member;
import com.naver.myhome.mybatis.mapper.MemberMapper;

/*
 * 1. UserDetails 인터페이스는 Security에서 사용자의 정보를 담는 인터페이스입니다.
 * 
 * 2. userDetailsService 인터페이스는 DB에서 유저 정보를 불러오는 loadUserByUsername()가 존재합니다.
 * 	  이를 구현하는 클래스는 DB에서 유저의 정보를 가져와서 UserDetails 타입으로 리턴해 주는 작업을 합니다.
 * 
 * 3. UserDetails 인터페이스를 구현한 클래스는 실제로 사용자의 정보와 사용자가 가진 권한의 정보를 처리해서 반환하게 됩니다.
 * 	 	예) UserDetails user = new User(username, user.getPassword(), roles);
 * 
 * */
@Component
public class CustomUserDetailsService implements UserDetailsService {

	private static final Logger logger
		= LoggerFactory.getLogger(CustomUserDetailsService.class);
	
	@Autowired
	private MemberMapper dao;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		logger.info("username은 로그인 시 입력한 값 : " + username);
		Member users = dao.isId(username);
		 
		if (users==null) {
			logger.info("username " + username + "not found");
			
			throw new UsernameNotFoundException("username" + username + " not found");
		}
		
		//GrantedAuthority : 인증 개체에 부여된 권한을 나타내기 위한 인터페이스로 이를 구현한 구현체는 
		// 					 생성자에 권한을 문자열로 넣어주면 됩니다. 
		//SimpleGrantedAuthority : GrantedAuthority의 구현체입니다.
		Collection<SimpleGrantedAuthority> roles = new ArrayList<SimpleGrantedAuthority>();
		
		roles.add(new SimpleGrantedAuthority(users.getAuth()));
		
		UserDetails user = new User(username, users.getPassword(), roles);
		
		return user;
	}

}
