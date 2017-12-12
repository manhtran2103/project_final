/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import Data_Connection.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Media;
import model.User;

/**
 *
 * @author manhtran
 */
public class MediaDAO {
    
    public boolean insertToMedia(Media media){
        try {
            Connection connection = DBConnection.getConnection();
            String sql = "INSERT INTO media VALUES(?,?,?,?,?)";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setLong(1, media.getMedia_id());
            ps.setLong(2, media.getUser_id());
            ps.setInt(3, media.getType_id());
            ps.setString(4, media.getMedia_url());
            ps.setInt(5, 0);
            ps.executeUpdate();
            connection.close();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(MediaDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    public ArrayList<Media> getListMedia(){
        try {
            Connection connection = DBConnection.getConnection();
            String sql = "SELECT * FROM media";
            PreparedStatement ps = connection.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            ArrayList<Media> listMedias = new ArrayList<>();
            while(rs.next()){
                Media media = new Media();
                media.setMedia_id(rs.getLong("media_id"));
                media.setUser_id(rs.getLong("user_id"));
                media.setType_id(rs.getInt("type_id"));
                media.setMedia_url(rs.getString("media_url"));
                media.setMedia_like(rs.getInt("media_like"));
                listMedias.add(media);
            }
            return listMedias;
                 
        } catch (SQLException ex) {
            Logger.getLogger(MediaDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return null;
    }
    
    public ArrayList<Media> getListMediaByUser(long user_id){
        try {
            Connection connection = DBConnection.getConnection();
            String sql = "SELECT * FROM media WHERE user_id = '"+user_id+"'";
            PreparedStatement ps = connection.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            ArrayList<Media> listMedias = new ArrayList<>();
            while(rs.next()){
                Media media = new Media();
                media.setMedia_id(rs.getLong("media_id"));
                media.setUser_id(rs.getLong("user_id"));
                media.setType_id(rs.getInt("type_id"));
                media.setMedia_url(rs.getString("media_url"));
                media.setMedia_like(rs.getInt("media_like"));
                listMedias.add(media);
            }
            return listMedias;
                 
        } catch (SQLException ex) {
            Logger.getLogger(MediaDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return null;
    }
    
     public Media getMediaById(long media_id){
        try {
            Connection connection = DBConnection.getConnection();
            String sql = "SELECT * FROM media WHERE media_id = '"+media_id+"'";
            PreparedStatement ps = connection.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            Media media = new Media();
            if(rs.next()){
                media.setMedia_id(rs.getLong("media_id"));
                media.setUser_id(rs.getLong("user_id"));
                media.setType_id(rs.getInt("type_id"));
                media.setMedia_url(rs.getString("media_url"));
                media.setMedia_like(rs.getInt("media_like"));
               
            }
            return media;
                 
        } catch (SQLException ex) {
            Logger.getLogger(MediaDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return null;
    }
     
     public int getNumberOfMedia(long user_id){
        try {
            Connection connection = DBConnection.getConnection();
            String sql = "SELECT COUNT(*) FROM media WHERE user_id ='"+user_id+"'";
            PreparedStatement ps = connection.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                return rs.getInt("COUNT(*)");
            }
        } catch (SQLException ex) {
            Logger.getLogger(MediaDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
     }
   
    
     
     public ArrayList<Media> getTopMedia(){
        try {
            Connection connection = DBConnection.getConnection();
            String sql = "SELECT * FROM media ORDER BY media_like DESC LIMIT 10";
            PreparedStatement ps = connection.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            ArrayList<Media> listMedias = new ArrayList<>();
            while(rs.next()){
                Media media = new Media();
                media.setMedia_id(rs.getLong("media_id"));
                media.setUser_id(rs.getLong("user_id"));
                media.setType_id(rs.getInt("type_id"));
                media.setMedia_url(rs.getString("media_url"));
                media.setMedia_like(rs.getInt("media_like"));
                listMedias.add(media);
            }
            return listMedias;
                 
        } catch (SQLException ex) {
            Logger.getLogger(MediaDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return null; 
     }
     
     public ArrayList<Media> getNewsFeed(long follower_id){
        try {
            Connection connection = DBConnection.getConnection();
            String sql = "SELECT * FROM media, followers "
                    + "WHERE media.user_id = followers.user_id AND followers.follower_id = '"+follower_id+"' "
                    + "ORDER BY media.media_id DESC";
            PreparedStatement ps = connection.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            ArrayList<Media> listMedias = new ArrayList<>();
            while(rs.next()){
                Media media = new Media();
                media.setMedia_id(rs.getLong("media.media_id"));
                media.setUser_id(rs.getLong("media.user_id"));
                media.setType_id(rs.getInt("media.type_id"));
                media.setMedia_url(rs.getString("media.media_url"));
                media.setMedia_like(rs.getInt("media.media_like"));
                listMedias.add(media);
            }
            return listMedias;
                 
        } catch (SQLException ex) {
            Logger.getLogger(MediaDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return null; 
     }
     
     
     
     public static void main(String[] args) {
        MediaDAO mediaDAO = new MediaDAO();
//        UserDAO userDAO = new UserDAO();
//        for(User user : mediaDAO.getSuggestedPeople(1510785292433l)){
//            System.out.println(user.getUser_name());
//        }
    }
}
