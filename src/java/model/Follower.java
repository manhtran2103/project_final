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
public class Follower {
    private long user_id;
    private long follower_id;

    public Follower() {
    }

    public Follower(long user_id, long follower_id) {
        this.user_id = user_id;
        this.follower_id = follower_id;
    }

    public long getUser_id() {
        return user_id;
    }

    public void setUser_id(long user_id) {
        this.user_id = user_id;
    }

    public long getFollower_id() {
        return follower_id;
    }

    public void setFollower_id(long follower_id) {
        this.follower_id = follower_id;
    }
    
    
}
