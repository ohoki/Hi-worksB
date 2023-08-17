package com.worksb.hi.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.worksb.hi.member.mapper.MemberMapper;
import com.worksb.hi.member.service.MemberVO;

public class CustomUserDetailsService implements UserDetailsService{
	
	@Autowired
	MemberMapper memberMapper;
	
	@Override
	public UserDetails loadUserByUsername(String memberId) throws UsernameNotFoundException {
		MemberVO member = new MemberVO();
		member.setMemberId(memberId);
		
		MemberVO vo = memberMapper.selectMember(member);
		return vo == null ? null : new CustomUser(vo);
	}
}
