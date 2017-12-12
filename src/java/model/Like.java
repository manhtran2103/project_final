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
public class Like {
    private String icon;
    private int like_quantity;

    public Like() {
    }

    public Like(String icon, int like_quantity) {
        this.icon = icon;
        this.like_quantity = like_quantity;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public int getLike_quantity() {
        return like_quantity;
    }

    public void setLike_quantity(int like_quantity) {
        this.like_quantity = like_quantity;
    }
    
    
    
}
