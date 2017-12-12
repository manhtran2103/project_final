
package dao;

import Data_Connection.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Follower;
import model.User;

/**
 *
 * @author manhtran
 */
public class FollowerDAO {
    public boolean insertToFollowers(Follower follower){
        try {
            Connection connection = DBConnection.getConnection();
            String sql = "INSERT INTO followers VALUES(?,?)";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setLong(1, follower.getUser_id());
            ps.setLong(2, follower.getFollower_id());
            ps.executeUpdate();
            connection.close();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(FollowerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    public boolean checkFollower(long user_id, long follower_id){
        Connection connection;
        try {
            connection = DBConnection.getConnection();
             String sql = "SELECT * FROM followers WHERE user_id = '"+user_id+"' AND follower_id = '"+follower_id+"'";
            PreparedStatement ps = connection.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                connection.close();
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(FollowerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
           
          return false;
    }
    
     public boolean removeFollower(long user_id, long follower_id){
        Connection connection;
        try {
            connection = DBConnection.getConnection();
             String sql = "DELETE FROM followers WHERE user_id = '"+user_id+"' AND follower_id = '"+follower_id+"'";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.executeUpdate();
            connection.close();
                return true;
            
        } catch (SQLException ex) {
            Logger.getLogger(FollowerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
           
          return false;
    }
    
    public int getNumberFollowers(long user_id){
         Connection connection;
        try {
            connection = DBConnection.getConnection();
             String sql = "SELECT COUNT(*) FROM followers WHERE user_id ='"+user_id+"'";
            PreparedStatement ps = connection.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                return rs.getInt("COUNT(*)");
            }
        } catch (SQLException ex) {
            Logger.getLogger(FollowerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }
    
     public int getNumberFollowing(long follower_id){
         Connection connection;
        try {
            connection = DBConnection.getConnection();
             String sql = "SELECT COUNT(*) FROM followers WHERE follower_id ='"+follower_id+"'";
            PreparedStatement ps = connection.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                return rs.getInt("COUNT(*)");
            }
        } catch (SQLException ex) {
            Logger.getLogger(FollowerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }
     
     public ArrayList<User> getListFollowers(long user_id){
             Connection connection;
        try {
            connection = DBConnection.getConnection();
             String sql = "SELECT * FROM followers, users "
                     + "WHERE users.user_id=followers.follower_id AND  followers.user_id='"+user_id+"'";
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
            Logger.getLogger(FollowerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
           
        return null;
         
     }
     
     public ArrayList<User> getListFollowing(long follower_id){
             Connection connection;
        try {
            connection = DBConnection.getConnection();
             String sql = "SELECT * FROM followers, users "
                     + "WHERE users.user_id=followers.user_id AND  followers.follower_id='"+follower_id+"'";
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
            Logger.getLogger(FollowerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
           
        return null;
         
     }
    public static void main(String[] args) {
        FollowerDAO followerDAO = new FollowerDAO();
        for(User user : followerDAO.getListFollowers(1510683229478l)){
            System.out.println(user.getUser_id());
        }
    }
}
