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
import model.Comment;
import model.Media;

/**
 *
 * @author manhtran
 */
public class CommentDAO {
    
    public boolean insertToComments(Comment comment){
        try {
            Connection connection = DBConnection.getConnection();
            String sql = "INSERT INTO comments VALUES(null,?,?,?,?,?)";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setLong(1, comment.getMedia_id());
            ps.setLong(2, comment.getUser_id());
            ps.setString(3, comment.getUser_name());
            ps.setString(4, comment.getAvatar());
            ps.setString(5, comment.getContent());          
            ps.executeUpdate();
            connection.close();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(MediaDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    public ArrayList<Comment> getListCommentByMediaId(long media_id){
        try {
            Connection connection = DBConnection.getConnection();
            String sql = "SELECT * FROM comments WHERE media_id = '"+media_id+"'";
            PreparedStatement ps = connection.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            ArrayList<Comment> listComments = new ArrayList<>();
            while(rs.next()){
                Comment comment = new Comment();
                comment.setComment_id(rs.getLong("comment_id"));
                comment.setMedia_id(rs.getLong("media_id"));
                comment.setUser_id(rs.getLong("user_id"));
                comment.setUser_name(rs.getString("user_name"));
                comment.setAvatar(rs.getString("avatar"));
                comment.setContent(rs.getString("content"));
                listComments.add(comment);
               
            }
            return listComments;
                 
        } catch (SQLException ex) {
            Logger.getLogger(MediaDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return null;
    }
    public static void main(String[] args) {
        CommentDAO commentDAO = new CommentDAO();
        System.out.println(commentDAO.insertToComments(new Comment(1l, 223l, 34535l, "ghfh", "fdsgff", "dfsdfdd")));
    }
}
