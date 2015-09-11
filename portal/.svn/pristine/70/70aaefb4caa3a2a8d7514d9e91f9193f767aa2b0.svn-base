package com.ifunpay.portal.util;

import org.apache.shiro.crypto.hash.Sha256Hash;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.util.ByteSource;

/**
 * 登录组件。
 */
public class UserSecurity  {

	private String hashAlgorithmName = Sha256Hash.ALGORITHM_NAME;
	private String salt = Sha256Hash.ALGORITHM_NAME;


	/**
	 * 检查密码是否正确。
	 * 
	 * @param password
	 *            原密码
	 * @param hashedPassword
	 *            加密后的密码
	 * @return 如果密码正确返回true，否则返回false。
	 */
	public Boolean checkPassword(String password, String hashedPassword) {
		return encryptPassword(password).equals(hashedPassword);
	}

	/**
	 * 加密。
	 * 
	 * @param password
	 *            待加密的密码
	 * @return 返回加密后的密码。
	 */
	public String encryptPassword(String password) {
		return new SimpleHash(hashAlgorithmName, password, getSaltByteSource())
				.toBase64();
	}



	private ByteSource getSaltByteSource() {
		return ByteSource.Util.bytes(salt);
	}

	public String getHashAlgorithmName() {
		return hashAlgorithmName;
	}

	public void setHashAlgorithmName(String hashAlgorithmName) {
		this.hashAlgorithmName = hashAlgorithmName;
	}

	public String getSalt() {
		return salt;
	}

	public void setSalt(String salt) {
		this.salt = salt;
	}

//    public static void main(String[] args) {
//        UserSecurity userSecurity = new UserSecurity();
//        String ss = userSecurity.encryptPassword("123456");
//        System.out.println(ss);
//       boolean aa =userSecurity.checkPassword("123456",ss);
//        System.out.println(aa);
//
//    }
}
