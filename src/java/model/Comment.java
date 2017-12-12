/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author manhtran
 */
public class Comment {
    private long comment_id;
    private long media_id;
    private long user_id;
    private String user_name;
    private String avatar;
    private String content;

    public Comment() {
    }

    public Comment(long comment_id, long media_id, long user_id, String user_name, String avatar, String content) {
        this.comment_id = comment_id;
        this.media_id = media_id;
        this.user_id = user_id;
        this.user_name = user_name;
        this.avatar = avatar;
        this.content = content;
    }

    public long getComment_id() {
        return comment_id;
    }

    public void setComment_id(long comment_id) {
        this.comment_id = comment_id;
    }

    public long getMedia_id() {
        return media_id;
    }

    public void setMedia_id(long media_id) {
        this.media_id = media_id;
    }

    public long getUser_id() {
        return user_id;
    }

    public void setUser_id(long user_id) {
        this.user_id = user_id;
    }

    public String getUser_name() {
        return user_name;
    }

    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    
    
}
