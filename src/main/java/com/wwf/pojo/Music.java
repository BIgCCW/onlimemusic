package com.wwf.pojo;

/**
 * @author wwf
 * @date 2021/4/24
 */
public class Music {
    private int id;
    private String src;
    private String title;
    private String name;

    public Music() {
    }

    public Music(int id, String src, String title, String name) {
        this.id = id;
        this.src = src;
        this.title = title;
        this.name = name;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getSrc() {
        return src;
    }

    public void setSrc(String src) {
        this.src = src;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "Music{" +
                "id=" + id +
                ", src='" + src + '\'' +
                ", title='" + title + '\'' +
                ", name='" + name + '\'' +
                '}';
    }
}
