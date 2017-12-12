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
import java.util.Calendar;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Follower;
import model.Profile;
import model.User;
import org.apache.derby.client.am.DateTime;

/**
 *
 * @author manhtran
 */
public class ProfileDAO {
    public boolean insertToProfile(Profile profile){
       
            Connection connection;
        try {
            connection = DBConnection.getConnection();
            String sql = "INSERT INTO profile VALUES(?,?,?,?,?)";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setLong(1, profile.getUser_id());
            ps.setString(2, profile.getName());
            ps.setString(3, profile.getGender());
            ps.setString(4, profile.getDescription());
            ps.setString(5, profile.getAvatar());
            ps.executeUpdate();
            connection.close();
            return true;
        
        } catch (SQLException ex) {
            Logger.getLogger(ProfileDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
           
        return false;
    }
    
    public Profile getProfile(long user_id){
       
            Connection connection;
        try {
            connection = DBConnection.getConnection();
            String sql = "SELECT * FROM profile WHERE user_id = '"+user_id+"'";
            PreparedStatement ps = connection.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                Profile profile = new Profile();
                profile.setUser_id(rs.getLong("user_id"));
                profile.setName(rs.getString("name"));
                profile.setGender(rs.getString("gender"));
                profile.setDescription(rs.getString("description"));
                profile.setAvatar(rs.getString("avatar"));
                connection.close();
                return profile;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProfileDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;   
    }
    
    public boolean checkProfile(long user_id){
        try {
            Connection connection = DBConnection.getConnection();
            String sql = "SELECT * FROM profile WHERE user_id = '"+user_id+"'";
            PreparedStatement ps = connection.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                connection.close();
                return true;
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(ProfileDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
        
    }
    
    public boolean updateProfile(Profile profile){
        try {
            Connection connection = DBConnection.getConnection();
            String sql = "UPDATE profile SET name=(?), gender=(?), description=(?), avatar=(?) WHERE user_id = '"+profile.getUser_id()+"'";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, profile.getName());
            ps.setString(2, profile.getGender());
            ps.setString(3, profile.getDescription());
            ps.setString(4, profile.getAvatar());
            ps.executeUpdate();
            connection.close();
            return true;
            
        } catch (SQLException ex) {
            Logger.getLogger(ProfileDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    
    
    
    public static void main(String[] args) {
        
        ProfileDAO profileDAO = new ProfileDAO();
        //System.out.println(profileDAO.updateProfile(new Profile(1510683229478l, "fsgsg", "dfgdfg", "dfgdfg", "dfdsfsdf")));
    }
}
