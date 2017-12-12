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
public class Like_User {
    private long user_id;
    private long media_id;

    public Like_User() {
    }

    public Like_User(long user_id, long media_id) {
        this.user_id = user_id;
        this.media_id = media_id;
    }

    public long getUser_id() {
        return user_id;
    }

    public void setUser_id(long user_id) {
        this.user_id = user_id;
    }

    public long getMedia_id() {
        return media_id;
    }

    public void setMedia_id(long media_id) {
        this.media_id = media_id;
    }
    
    
}
