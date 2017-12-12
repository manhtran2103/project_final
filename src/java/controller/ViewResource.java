/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.CommentDAO;
import dao.FollowerDAO;
import dao.LikeDAO;
import dao.MediaDAO;
import dao.ProfileDAO;
import dao.UserDAO;
import java.util.ArrayList;
import java.util.Date;
import javax.json.Json;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.UriInfo;
import javax.ws.rs.Produces;
import javax.ws.rs.Consumes;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;

import javax.ws.rs.Path;
import javax.ws.rs.PUT;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import model.Comment;
import model.FollowResponse;
import model.Follower;
import model.Like;
import model.Media;
import model.Profile;
import org.jboss.weld.context.http.HttpRequestContext;

/**
 * REST Web Service
 *
 * @author manhtran
 */
@Path("view")
public class ViewResource {

    @Context
    private UriInfo context;
    private MediaDAO mediaDAO = new MediaDAO();
    private LikeDAO likeDAO = new LikeDAO();
    private CommentDAO commentDAO = new CommentDAO();
    private UserDAO userDAO = new UserDAO();
    private FollowerDAO followerDAO = new FollowerDAO();
    private ProfileDAO profileDAO = new ProfileDAO();

   
    public ViewResource() {
    }

    
    @GET
    @Produces(MediaType.TEXT_PLAIN)
    public String getXml() {
        return "Back to your home page";
    }
    
    @POST
    @Produces(MediaType.APPLICATION_JSON)
    @Path("getlike")
    public Like getView(@FormParam("media_id") long media_id, @FormParam("user_id") long user_id) {
        String icon;
        int like_quantity;
        if(likeDAO.checkLikeUser(user_id, media_id)){
            likeDAO.removeLikeUser(user_id, media_id);
            likeDAO.updateUnLike(media_id);
            icon = "img/unlike.png";
            like_quantity = likeDAO.getTotalLike(media_id);
        } else{
            likeDAO.insertLikeUser(user_id, media_id);
            likeDAO.updateLike(media_id);
            icon = "img/like.png";
            like_quantity = likeDAO.getTotalLike(media_id);
        }
        if(like_quantity < 0){
            like_quantity = 0;
        }
        return new Like(icon, like_quantity);
    }
    
    @POST
    @Produces(MediaType.APPLICATION_JSON)
    @Path("getcomments")
    public ArrayList<Comment> getComments(@FormParam("media_id") long media_id, 
            @FormParam("user_id") long user_id,
            @FormParam("user_name") String user_name,
            @FormParam("avatar") String avatar,
            @FormParam("content") String content) {
        commentDAO.insertToComments(new Comment(1l, media_id, user_id, user_name, avatar ,content));      
        ArrayList<Comment> list = commentDAO.getListCommentByMediaId(media_id);
        return list;
    }
    
    @POST 
    @Produces(MediaType.TEXT_PLAIN)
    @Path("checkusername")
    
    public String checkUserName(@FormParam("user_name") String user_name){
        if(userDAO.checkUserName(user_name)){
            return "<img src=\"img/not-available.png\" />";
        } else{
            return "<img src=\"img/available.png\" />";
        }
    }
    
    @POST 
    @Produces(MediaType.TEXT_PLAIN)
    @Path("checkemail")
    public String checkEmail(@FormParam("user_email") String user_email){
        if(userDAO.checkEmail(user_email)){
            return "<img src=\"img/not-available.png\" />";
        } else{
            return "<img src=\"img/available.png\" />";
        }
    }
    
    @POST 
    @Produces(MediaType.APPLICATION_JSON)
    @Path("follow")
    public FollowResponse follow(@FormParam("user_id") long user_id, @FormParam("follower_id") long follower_id){
        String background, color, html;
        if(followerDAO.checkFollower(user_id, follower_id)){
            followerDAO.removeFollower(user_id, follower_id);
            background = "#1fa1e2";
            color = "white";
            html = "<span>+</span> Follow";
            
        }else{
            followerDAO.insertToFollowers(new Follower(user_id, follower_id));
            background = "#c9cbcc";
            color = "black";
            html = "Followed";
        }
        int follower = followerDAO.getNumberFollowers(user_id);
        return new FollowResponse(follower, background, color, html);
    }
    
    @POST 
    @Produces(MediaType.APPLICATION_JSON)
    @Path("saveprofile")
    public Profile save(@FormParam("user_id") long user_id,
            @FormParam("name") String name,
            @FormParam("gender") String gender,
            @FormParam("description") String description,
            @FormParam("avatar") String avatar){
            profileDAO.updateProfile(new Profile(user_id, name, gender, description, avatar));
      
        return profileDAO.getProfile(user_id);
    }
            
}
