package com.brave.thebrave.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

@Component
public class AccountUtil {
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;

	public String encodePassword(String password){
		return bCryptPasswordEncoder.encode(password);
	}
	
//	public boolean confirmPasswordEcoded(String password, String db_password){
//		try{
//			if(bCryptPasswordEncoder.matches(password, db_password)){
//				return true;
//			}else{
//				return false;
//			}
//		}catch (Exception e){
//			return false;
//		}
//	}
	
	public boolean confirmPasswordEcoded(String password, String db_password){
        try {
            // matches 변수를 선언하고 bCryptPasswordEncoder의 matches 메소드 결과로 초기화
            boolean matches = bCryptPasswordEncoder.matches(password, db_password);
            
            // 디버깅을 위한 로그 추가
//            System.out.println("Input Password: " + password);
//            System.out.println("DB Password: " + db_password);
//            System.out.println("Password matches: " + matches);
            
            return matches;
        } catch (Exception e) {
            System.out.println("Error in password comparison: " + e.getMessage());
            return false;
        }
    }
}
