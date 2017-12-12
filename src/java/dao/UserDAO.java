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
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.User;

/**
 *
 * @author manhtran
 */
public class UserDAO {
    public ArrayList<User> getListUsers(){
         
            Connection connection;
        try {
            connection = DBConnection.getConnection();
             String sql = "SELECT * FROM users";
            PreparedStatement ps = connection.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            ArrayList<User> list = new ArrayList<>();
            while(rs.next()){
                User user = new User();
                user.setUser_id(rs.getLong("user_id"));
                user.setUser_name(rs.getString("user_name"));
                user.setUser_email(rs.getString("user_email"));
                user.setUser_password(rs.getString("user_password"));
                list.add(user);
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
           
        return null;
    }
    public boolean insertToUserTest(User user){
        Connection connection;
        try {
            connection = DBConnection.getConnection();
            String sql = "INSERT INTO users_test VALUES (?,?,?,?)";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setLong(1, user.getUser_id());
            ps.setString(2, user.getUser_name());
            ps.setString(3, user.getUser_email());
            ps.setString(4, user.getUser_password());
            ps.executeUpdate();
            connection.close();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;      
    }
    
    public User getUserFromUsersTest(long user_id){
        try {
            Connection connection = DBConnection.getConnection();
            String sql = "SELECT * FROM users_test WHERE user_id = '"+user_id+"'";
            PreparedStatement ps = connection.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                User user = new User();
                user.setUser_id(rs.getLong("user_id"));
                user.setUser_name(rs.getString("user_name"));
                user.setUser_email(rs.getString("user_email"));
                user.setUser_password(rs.getString("user_password"));
                connection.close();
                return user;
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
        
    }
    
    public boolean insertToUser(User user){
        Connection connection;
        try {
            connection = DBConnection.getConnection();
            String sql = "INSERT INTO users VALUES (?,?,?,?)";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setLong(1, user.getUser_id());
            ps.setString(2, user.getUser_name());
            ps.setString(3, user.getUser_email());
            ps.setString(4, user.getUser_password());
            ps.executeUpdate();
            connection.close();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;      
    }
    
    public User getUserFromUsers(long user_id){
        try {
            Connection connection = DBConnection.getConnection();
            String sql = "SELECT * FROM users WHERE user_id = '"+user_id+"'";
            PreparedStatement ps = connection.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                User user = new User();
                user.setUser_id(rs.getLong("user_id"));
                user.setUser_name(rs.getString("user_name"));
                user.setUser_email(rs.getString("user_email"));
                user.setUser_password(rs.getString("user_password"));
                connection.close();
                return user;
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
        
    }
    
    public boolean removeUserFromUsersTest(long user_id){
        try {
            Connection connection = DBConnection.getConnection();
            String sql = "DELETE FROM users_test WHERE user_id='"+user_id+"'";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.executeUpdate();
            connection.close();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    public User getUserFromUsersByName_Password(String user_name, String user_password){
        try {
            Connection connection = DBConnection.getConnection();
            String sql = "SELECT * FROM users WHERE user_name='"+user_name+"' AND user_password='"+user_password+"'";
            PreparedStatement ps = connection.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                User user = new User();
                user.setUser_id(rs.getLong("user_id"));
                user.setUser_name(rs.getString("user_name"));
                user.setUser_email(rs.getString("user_email"));
                user.setUser_password(rs.getString("user_password"));
                return user;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public boolean checkUserName(String user_name){
        try {
            Connection connection = DBConnection.getConnection();
            String sql = "SELECT * FROM users WHERE user_name = '"+user_name+"'";
            PreparedStatement ps = connection.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                connection.close();
                return true;
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
        
    }
    
    public boolean checkEmail(String user_email){
        try {
            Connection connection = DBConnection.getConnection();
            String sql = "SELECT * FROM users WHERE user_email = '"+user_email+"'";
            PreparedStatement ps = connection.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                connection.close();
                return true;
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
        
    }
    
    public ArrayList<User> getSuggestedPeople(long user_id){

            FollowerDAO followerDAO = new FollowerDAO();
            UserDAO userDAO = new UserDAO();
            ArrayList<User> listUser = userDAO.getListUsers();
            ArrayList<User> listFollowing = followerDAO.getListFollowing(user_id);
            ArrayList<User> listUnFollowing = new ArrayList<>();
             ArrayList<String> listName = new ArrayList<>();
             for(User user : listFollowing){
                 listName.add(user.getUser_name());
             }
            for(User user : listUser){
                if((!listName.contains(user.getUser_name())) && (user.getUser_id() != user_id)){
                    listUnFollowing.add(user);
                    if(listUnFollowing.size() > 5){
                        break;
                    }
                }
            }
        
        return listUnFollowing; 
     }
    
    public static void main(String[] args) {
        UserDAO userDAO = new UserDAO();
        ArrayList<User> list = userDAO.getSuggestedPeople(1510683229478l);
        for(User u : list){
            System.out.println(u.getUser_name());
        }
    }
    
}
