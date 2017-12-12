<%-- 
    Document   : view
    Created on : Dec 2, 2017, 9:01:25 PM
    Author     : manhtran
--%>

<%@page import="model.User"%>
<%@page import="dao.ProfileDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Comment"%>
<%@page import="dao.CommentDAO"%>
<%@page import="dao.LikeDAO"%>
<%@page import="model.Media"%>
<%@page import="dao.MediaDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View</title>
        
        <!--google font-->
        <link href="https://fonts.googleapis.com/css?family=Lato:100,300,300i,400,400i" rel="stylesheet">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/fetch/2.0.1/fetch.min.js"></script>
         <link rel="stylesheet" href="css/view.css">
    </head>
    <body>
        <%
            MediaDAO mediaDAO = new MediaDAO();
            LikeDAO likeDAO = new LikeDAO();
            CommentDAO commentDAO = new CommentDAO();
            ProfileDAO profileDAO = new ProfileDAO();
            long media_id = Long.parseLong(request.getParameter("id"));
            Media media = mediaDAO.getMediaById(media_id);
            ArrayList<Comment> listComments = commentDAO.getListCommentByMediaId(media_id);
            //get cookies
            long user_id = 0;
            String user_name = "";
            Cookie[] cookies = request.getCookies();
            if(cookies !=null){
            for(Cookie cookie : cookies){
                    if(cookie.getName().equals("user_id")){
                        user_id = Long.parseLong(cookie.getValue());
                    }
                    if(cookie.getName().equals("user_name")){
                        user_name = cookie.getValue();
                    } 
            }
            }
            // set icon for like button
            String icon;
            if(user_name == ""){
                  icon = "img/unlike.png";
            } else{
                if(likeDAO.checkLikeUser(user_id, media_id)){
                   icon = "img/like.png";
                } else{
                   icon = "img/unlike.png";
                        }
                    }
            
            
        %>
        <div id="view">
            <div id="img"><img src=<%= media.getMedia_url() %>></div>
            <div id="comments">
                <div id="icon"><img src =<%= icon %> id="like" width="25px" height="23px" style="cursor: pointer;">&nbsp;&nbsp;&nbsp;
                    <span id="like_quantity"><%=media.getMedia_like() %></span>
                    <div id="listLikeUsers">
                        <%
                            for(User user : likeDAO.getLikeUsers(media_id)){
                        %>
                        <a href="home.jsp?id=<%=user.getUser_id() %>"><%=user.getUser_name() %></a>
                        <%}%>
                    </div>
                </div>
                <div class="user-comments" >
                    <div id="content">
                        <%
                            for(Comment comment : listComments){
                        %>
                    <div class="div-comment">
                        <div class="img-user"><img src=<%=comment.getAvatar() %>></div>
                        <div>
                        <a class="username" href="home.jsp?id=<%=comment.getUser_id() %>"><%= comment.getUser_name() %></a>
                        <p class="comment"><%= comment.getContent() %></p>
                        </div>
                    </div>
                    <% } %>
                    </div>
                    <div style="margin: 20px; padding: 10px;">
                        <form>
                        <input type="text" name="comments" placeholder="add your comment" size="50px">
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <script>
           
              $(document).ready(()=>{
                   'use strict';
                  if(<%=user_id %> === 0){
                      $('input').hide();
                  }
                  // for like button
                  $('#like').click(() => {
                          if(<%=user_id %> === 0){
                             alert("Please login to continue"); 
                          } else{
                             $.ajax({
                                type: 'POST',
                                data: {media_id: <%=media_id %>, user_id: <%= user_id %>},
                                url: '/project/page/view/getlike',
                                success: (data)=>{
                                    console.log(data);
                                    $('#like').attr("src", data.icon);
                                    $('#like_quantity').text(data.like_quantity);
                               }
                             });}                        
                        });
                        
                    // for adding comments
                
                    const writeComment = (evt) => {
                        evt.preventDefault();
                        let content = document.querySelector('input').value;
                        const data = {
                            media_id: <%= media_id %>,
                            user_id: <%=user_id %>,
                            user_name: '<%= user_name %>',
                            avatar: '<%=profileDAO.getProfile(user_id).getAvatar() %>' ,
                            content: content
                        };
                        if(content.replace(/\s+/, "") === ""){
                            alert("add your comment");
                        }
                        else{
                            $.ajax({
                                     type: 'POST',
                                     data: data,
                                     url: '/project/page/view/getcomments',
                                     success: (data)=>{
                                         console.log(data);
                                         let html = "";
                                        for( let i = 0; i < data.length; i++){
                                           
                                            html += "<div class='div-comment'>\n\
                                                    \n\ <div class='img-user'><img src="+data[i].avatar+"></div><div>\n\
                                                    <a href='home.jsp?id="+data[i].user_id+"' class='username'>"+data[i].user_name+"</a>\n\
                                                    <p class='comment'>"+data[i].content+"</p>\n\
                                                     </div></div>";
                                        }
                                 
                                        document.querySelector('#content').innerHTML = html;
                                     }
                                });
                             }
                        document.querySelector('input').value = "";
                   
                    };
                    document.querySelector('form').addEventListener('submit', writeComment);
                   
                   });
                                   
                </script>
    </body>
</html>
