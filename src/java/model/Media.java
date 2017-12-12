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
public class Media {
  private long media_id;
  private long user_id;
  private int type_id;
  private String media_url;
  private int media_like;

    public Media() {
    }

    public Media(long media_id, long user_id, int type_id, String media_url, int media_like) {
        this.media_id = media_id;
        this.user_id = user_id;
        this.type_id = type_id;
        this.media_url = media_url;
        this.media_like = media_like;
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

    public int getType_id() {
        return type_id;
    }

    public void setType_id(int type_id) {
        this.type_id = type_id;
    }

    public String getMedia_url() {
        return media_url;
    }

    public void setMedia_url(String media_url) {
        this.media_url = media_url;
    }

    public int getMedia_like() {
        return media_like;
    }

    public void setMedia_like(int media_like) {
        this.media_like = media_like;
    }

    
  
}
