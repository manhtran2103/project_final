<%-- 
    Document   : login
    Created on : Nov 13, 2017, 9:35:11 PM
    Author     : manhtran
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <meta name="viewport" content="width = device-width, initial-scale=1.0, user-scalable=yes">
        
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <link href="https://fonts.googleapis.com/css?family=Lato:100,300,300i,400,400i" rel="stylesheet">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script src="http://code.jquery.com/jquery-latest.js" type="text/javascript"></script>
        <link rel="stylesheet" href="css/login.css">
       <script src="js/main.js"></script>
       <script src="js/login.css"></script>
      
    </head>
    <body>
        <%
            String error = (String) session.getAttribute("error");
        %>
        <nav role="navigation" class="navbar navbar-inverse navbar-fixed-top">
               <div class="container-fluid">
                   <div class="navbar-header">
                       <a class="navbar-brand" href="index.jsp" style="margin-left: 70px; color:white"> Media</a>
                       <button type="button" class="navbar-toggle" data-target="#navbarCollapse" data-toggle="collapse">
                           <span class="sr-only">Menu</span>
                           <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                       </button>
                   </div>
                   <div class="navbar-collapse collapse" id="navbarCollapse">
                   <form class="nav navbar-nav navbar-right">
                       <li><a>Help</a></li>
                       <li><a>About</a></li>
                   </form>
               </div>
               </div>
        </nav>
        <!---->
        <center style="
                margin: auto;
                margin-top: 30px;
                border: 1px solid #D2D2D3; 
                width: 400px; height: 490px;
                padding-top: 20px;">
        
         <form method="POST" action="LogInServlet">
             <img src="img/login.jpg" width="90px" height="70px">
             <div class="form-group" style="width: 350px;">
            <label>Username</label>
            <input type="text" name="user_name" class="form-control input-md" required>
             </div>
             <div class="form-group" style="width: 350px;">
            <label>Password</label>
            <input type="password" name="user_password" class="form-control input-md" required>
            </div>
             <% if(error != null) { %>
            <p style="color: red"><%=error %></p>
            <% }  %>
            <br>
            <p>Do not have an account. <a href="register.jsp">Sign up now!</a></p><br>
            <button class="btn btn-primary" type="submit" style="width: 200px;">Log In</button>
        </form>
    </center>
            <footer class="footer">
            <div class="container">
            <small>
                Media App by NoName Team
            </small>
            <nav>
                <ul>
                   
                    <li><a href="#">Contact</a></li>
                    <li><a href="#">News</a></li>
                </ul>
            </nav>
            </div>
        </footer>
    </body>
</html>
