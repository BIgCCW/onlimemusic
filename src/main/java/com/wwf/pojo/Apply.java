package com.wwf.pojo;

/**
 * @author wwf
 * @date 2021/5/30
 */
public class Apply {
    private Integer id;
    private String username;
    private String password;
    private String jurisdiction;
    private String reason;
    private String operation;

    public Apply(Integer id, String username, String password, String jurisdiction, String reason, String operation) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.jurisdiction = jurisdiction;
        this.reason = reason;
        this.operation = operation;
    }

    public Apply() {
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

    public String getJurisdiction() {
        return jurisdiction;
    }

    public void setJurisdiction(String jurisdiction) {
        this.jurisdiction = jurisdiction;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getOperation() {
        return operation;
    }

    public void setOperation(String operation) {
        this.operation = operation;
    }

    @Override
    public String toString() {
        return "Apply{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", jurisdiction='" + jurisdiction + '\'' +
                ", reason='" + reason + '\'' +
                ", operation='" + operation + '\'' +
                '}';
    }
}
