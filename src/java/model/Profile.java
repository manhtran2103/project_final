/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.util.Date;

/**
 *
 * @author manhtran
 */
public class Profile {
    private long user_id;
    private String name;
    private String gender;
    private String description;
    private String avatar;

    public Profile() {
    }

    public Profile(long user_id, String name, String gender, String description, String avatar) {
        this.user_id = user_id;
        this.name = name;
        this.gender = gender;
        this.description = description;
        this.avatar = avatar;
    }

    public long getUser_id() {
        return user_id;
    }

    public void setUser_id(long user_id) {
        this.user_id = user_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

   
    
    
}
