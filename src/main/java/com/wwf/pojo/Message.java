package com.wwf.pojo;

/**
 * @author wwf
 * @date 2021/6/1
 */
public class Message {
    private Integer id;
    private String text;
    private String name;

    public Message() {
    }

    public Message(Integer id, String text, String name) {
        this.id = id;
        this.text = text;
        this.name = name;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "Message{" +
                "id=" + id +
                ", text='" + text + '\'' +
                ", name='" + name + '\'' +
                '}';
    }
}
