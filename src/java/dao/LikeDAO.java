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
import model.User;

/**
 *
 * @author manhtran
 */
public class LikeDAO {
    
    public int getTotalLike(long media_id){
        int toltal = 0;
        try {
            Connection connection = DBConnection.getConnection();
            String sql = "SELECT media_like FROM media WHERE media_id = '"+media_id+"'";
            PreparedStatement ps = connection.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                toltal = rs.getInt("media_like");
                connection.close();
            }
        } catch (SQLException ex) {
            Logger.getLogger(LikeDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return toltal;
    }
    
    public boolean updateLike(long media_id){
        try {
            Connection connection = DBConnection.getConnection();
            String sql = "UPDATE media SET media_like=(?) WHERE media_id = '"+media_id+"'";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setLong(1, getTotalLike(media_id) + 1);
            ps.executeUpdate();
            connection.close();
            return true;
            
        } catch (SQLException ex) {
            Logger.getLogger(LikeDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
     public boolean updateUnLike(long media_id){
        try {
            Connection connection = DBConnection.getConnection();
            String sql = "UPDATE media SET media_like=(?) WHERE media_id = '"+media_id+"'";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setLong(1, getTotalLike(media_id) - 1);
            ps.executeUpdate();
            connection.close();
            return true;
            
        } catch (SQLException ex) {
            Logger.getLogger(LikeDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
     
     public boolean checkLikeUser(long user_id, long media_id){
         Connection connection;
        try {
            connection = DBConnection.getConnection();
            String sql = "SELECT * FROM like_users WHERE user_id='"+user_id+"' AND media_id='"+media_id+"'";
            PreparedStatement ps = connection.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                return true;
            } else{
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(LikeDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
     }
     
     public boolean removeLikeUser(long user_id, long media_id){
         try {
            Connection connection = DBConnection.getConnection();
            String sql = "DELETE FROM like_users WHERE user_id='"+user_id+"' AND media_id ='"+media_id+"'";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.executeUpdate();
            connection.close();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
     }
     
     public boolean insertLikeUser(long user_id, long media_id){
         try {
            Connection connection = DBConnection.getConnection();
            String sql = "INSERT INTO like_users VALUES('"+user_id+"','"+media_id+"')";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.executeUpdate();
            connection.close();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
     }
     
     public ArrayList<User> getLikeUsers(long media_id){
             Connection connection;
        try {
            connection = DBConnection.getConnection();
             String sql = "SELECT * FROM like_users, users "
                     + "WHERE users.user_id=like_users.user_id AND  like_users.media_id='"+media_id+"'";
            PreparedStatement ps = connection.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            ArrayList<User> list = new ArrayList<>();
            while(rs.next()){
                User user = new User();
                user.setUser_id(rs.getLong("users.user_id"));
                user.setUser_name(rs.getString("users.user_name"));
                user.setUser_email(rs.getString("users.user_email"));
                user.setUser_password(rs.getString("users.user_password"));
                list.add(user);
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(LikeDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
           
        return null;
         
     }
    
    public static void main(String[] args) {
        LikeDAO likeDao = new LikeDAO();
        for(User user : likeDao.getLikeUsers(1512659532280l)){
            System.out.println(user.getUser_name());
        }
    }
}
