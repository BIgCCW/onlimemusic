package com.wwf.pojo;

/**
 * @author wwf
 * @date 2021/5/14
 */
public class User {
    private Integer id;
    private String username;
    private String password;
    private String musicId;
    private String email;
    private String sex;
    private String birthday;
    private String jurisdiction;

    public User(Integer id, String username, String password, String musicId, String email, String sex, String birthday,String jurisdiction) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.musicId = musicId;
        this.email = email;
        this.sex = sex;
        this.birthday = birthday;
        this.jurisdiction = jurisdiction;
    }

    public User() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getMusicId() {
        return musicId;
    }

    public void setMusicId(String musicId) {
        this.musicId = musicId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public String getJurisdiction() {
        return jurisdiction;
    }

    public void setJurisdiction(String jurisdiction) {
        this.jurisdiction = jurisdiction;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", musicId='" + musicId + '\'' +
                ", email='" + email + '\'' +
                ", sex='" + sex + '\'' +
                ", birthday='" + birthday + '\'' +
                ", jurisdiction='" + jurisdiction + '\'' +
                '}';
    }
}
