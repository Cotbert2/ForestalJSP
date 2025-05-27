package edu.espe.cotbert.forestal.domain.model.security;

/**
 *
 * @author mateo
 */
public class UserAuthModel {

    private String uuidUsers;
    private String emailUsers;
    private String phoneUsers;
    private String firstNameUsers;
    private String lastNameUsers;
    private String roleUsers;
    private String password;

    public UserAuthModel(String uuidUsers, String emailUsers, String phoneUsers, String firstNameUsers, String lastNameUsers, String roleUsers) {
        this.uuidUsers = uuidUsers;
        this.emailUsers = emailUsers;
        this.phoneUsers = phoneUsers;
        this.firstNameUsers = firstNameUsers;
        this.lastNameUsers = lastNameUsers;
        this.roleUsers = roleUsers;
    }
    
    public UserAuthModel(String uuidUsers, String emailUsers, String phoneUsers, String firstNameUsers, String lastNameUsers, String roleUsers, String password) {
        this.uuidUsers = uuidUsers;
        this.emailUsers = emailUsers;
        this.phoneUsers = phoneUsers;
        this.firstNameUsers = firstNameUsers;
        this.lastNameUsers = lastNameUsers;
        this.roleUsers = roleUsers;
        this.password = password;
    }

    public UserAuthModel(String emailUsers, String phoneUsers, String firstNameUsers, String lastNameUsers, String roleUsers) {
        this.emailUsers = emailUsers;
        this.phoneUsers = phoneUsers;
        this.firstNameUsers = firstNameUsers;
        this.lastNameUsers = lastNameUsers;
        this.roleUsers = roleUsers;
    }

    public String getUuidUsers() {
        return uuidUsers;
    }

    public String getEmailUsers() {
        return emailUsers;
    }

    public String getPhoneUsers() {
        return phoneUsers;
    }

    public String getFirstNameUsers() {
        return firstNameUsers;
    }

    public String getLastNameUsers() {
        return lastNameUsers;
    }

    public String getRoleUsers() {
        return roleUsers;
    }

    public void setUuidUsers(String uuidUsers) {
        this.uuidUsers = uuidUsers;
    }

    public void setEmailUsers(String emailUsers) {
        this.emailUsers = emailUsers;
    }

    public void setPhoneUsers(String phoneUsers) {
        this.phoneUsers = phoneUsers;
    }

    public void setFirstNameUsers(String firstNameUsers) {
        this.firstNameUsers = firstNameUsers;
    }

    public void setLastNameUsers(String lastNameUsers) {
        this.lastNameUsers = lastNameUsers;
    }

    public void setRoleUsers(String roleUsers) {
        this.roleUsers = roleUsers;
    }

    public String getPassword() {
        return password;
    }
}
