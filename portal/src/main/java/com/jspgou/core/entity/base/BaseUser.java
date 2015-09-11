package com.jspgou.core.entity.base;

import com.jspgou.core.entity.User;

import java.io.Serializable;
import java.util.Date;

/**
 * This is an object that contains data related to the jo_authentication table.
 * Do not modify this class because it will be overwritten if the configuration file
 * related to this class is modified.
 *
 * @hibernate.class
 *  table="jo_authentication"
 * This class should preserve.
 * @preserve
*/

public abstract class BaseUser implements Serializable{

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
    public static String REF = "User";
    public static String PROP_LOGIN_COUNT = "loginCount";
    public static String PROP_LAST_LOGIN_IP = "lastLoginIp";
    public static String PROP_CREATE_TIME = "createTime";
    public static String PROP_RESET_KEY = "resetKey";
    public static String PROP_LAST_LOGIN_TIME = "lastLoginTime";
    public static String PROP_RESET_PWD = "resetPwd";
    public static String PROP_PASSWORD = "password";
    public static String PROP_EMAIL = "email";
    public static String PROP_CURRENT_LOGIN_TIME = "currentLoginTime";
    public static String PROP_CURRENT_LOGIN_IP = "currentLoginIp";
    public static String PROP_REGISTER_IP = "registerIp";
    public static String PROP_ID = "id";
    public static String PROP_USERNAME = "username";
    public static String PROP_CHANNEL_ID = "channelId";
    public static String PROP_COMMERCE_ID = "commerceId";
    public static String PROP_CHANNEL_NAME = "channelName";
    public static String PROP_COMMERCE_NAME = "commerceName";
    public static String PROP_STORE_FRONT = "storeFront";

    
	// constructors
	public BaseUser() {
        initialize();
    }

	/**
	 * Constructor for primary key
	 */
    public BaseUser(Long id){
        this.setId(id);
        initialize();
    }

	/**
	 * Constructor for required fields
	 */
    public BaseUser(Long id, 
    		        String username, 
    		        String password, 
    		        Date createTime, 
    		        Long loginCount


    ){
        this.setId(id);
        this.setUsername(username);
        this.setPassword(password);
        this.setCreateTime(createTime);
        this.setLoginCount(loginCount);

        initialize();
    }

    protected void initialize() {}
    
	private int hashCode = Integer.MIN_VALUE;

	// primary key
    private Long id;
    
	// fields
    private String username;
    private String email;
    private String password;
    private Date createTime;
    private Long loginCount;
    private String registerIp;
    private Date lastLoginTime;
    private String lastLoginIp;
    private Date currentLoginTime;
    private String currentLoginIp;
    private String resetKey;
    private String resetPwd;
    private String channelId;
    private String commerceId;
    private String channelName;
    private String commerceName;
    private String storeFront;
    private String phone;
    private String sex;
    private String userStatus;
    private String origin;
    private String userIdMove;
    private String cmbcUserId;
    private String uuid;


    public Long getId(){
        return id;
    }

    public void setId(Long id){
        this.id = id;
        this.hashCode = Integer.MIN_VALUE;
    }

    public String getUsername(){
        return username;
    }

    public void setUsername(String username){
        this.username = username;
    }

    public String getEmail(){
        return email;
    }

    public void setEmail(String email){
        this.email = email;
    }

    public String getPassword(){
        return password;
    }

    public void setPassword(String password){
        this.password = password;
    }

    public Date getCreateTime(){
        return createTime;
    }

    public void setCreateTime(Date createTime){
        this.createTime = createTime;
    }

    public Long getLoginCount(){
        return loginCount;
    }

    public void setLoginCount(Long loginCount){
        this.loginCount = loginCount;
    }

    public String getRegisterIp(){
        return registerIp;
    }

    public void setRegisterIp(String registerIp){
        this.registerIp = registerIp;
    }

    public Date getLastLoginTime(){
        return lastLoginTime;
    }

    public void setLastLoginTime(Date lastLoginTime){
        this.lastLoginTime = lastLoginTime;
    }

    public String getLastLoginIp(){
        return lastLoginIp;
    }

    public void setLastLoginIp(String lastLoginIp){
        this.lastLoginIp = lastLoginIp;
    }

    public Date getCurrentLoginTime(){
        return currentLoginTime;
    }

    public void setCurrentLoginTime(Date currentLoginTime){
        this.currentLoginTime = currentLoginTime;
    }

    public String getCurrentLoginIp(){
        return currentLoginIp;
    }

    public void setCurrentLoginIp(String currentLoginIp){
        this.currentLoginIp = currentLoginIp;
    }

    public String getResetKey(){
        return resetKey;
    }

    public void setResetKey(String resetKey) {
       this.resetKey = resetKey;
    }

    public String getResetPwd(){
        return resetPwd;
    }

    public void setResetPwd(String resetPwd){
        this.resetPwd = resetPwd;
    }

    public String getChannelId() {
        return channelId;
    }

    public void setChannelId(String channelId) {
        this.channelId = channelId;
    }

    public String getCommerceId() {
        return commerceId;
    }

    public void setCommerceId(String commerceId) {
        this.commerceId = commerceId;
    }

    public String getChannelName() {
        return channelName;
    }

    public void setChannelName(String channelName) {
        this.channelName = channelName;
    }

    public String getCommerceName() {
        return commerceName;
    }

    public void setCommerceName(String commerceName) {
        this.commerceName = commerceName;
    }


    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getUserStatus() {
        return userStatus;
    }

    public void setUserStatus(String userStatus) {
        this.userStatus = userStatus;
    }

    public String getOrigin() {
        return origin;
    }

    public void setOrigin(String origin) {
        this.origin = origin;
    }

    public String getUserIdMove() {
        return userIdMove;
    }

    public void setUserIdMove(String userIdMove) {
        this.userIdMove = userIdMove;
    }

    public String getCmbcUserId() {
        return cmbcUserId;
    }

    public void setCmbcUserId(String cmbcUserId) {
        this.cmbcUserId = cmbcUserId;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public String getStoreFront() {
        return storeFront;
    }

    public void setStoreFront(String storeFront) {
        this.storeFront = storeFront;
    }

    public boolean equals(Object obj){
        if(null == obj)  return false;
        if(!(obj instanceof User))  return false;
        else{
             User user = (User)obj;
             if(null == this.getId() || null == user.getId())  return false;
             else return (this.getId().equals(user.getId()));
        }
    }

    public int hashCode() {
        if(Integer.MIN_VALUE == this.hashCode){
            if(null == this.getId()) return super.hashCode();
            else{
                String hashStr = this.getClass().getName()+":"+this.getId().hashCode();
                this.hashCode = hashStr.hashCode();
            }
        }
        return this.hashCode;
    }

    public String toString(){
        return super.toString();
    }

}
