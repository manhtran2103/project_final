<%-- 
    Document   : register
    Created on : Nov 13, 2017, 9:35:24 PM
    Author     : manhtran
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <link href="https://fonts.googleapis.com/css?family=Lato:100,300,300i,400,400i" rel="stylesheet">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/fetch/2.0.1/fetch.min.js"></script>
        <link rel="stylesheet" href="css/register.css">
    </head>
    <body>
        <!--navbar-->
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
        <!--content-->

            <div id="login-box">
            <div class="left">
              <h1>Sign up</h1>
               <form method="POST" action="RegisterServlet">
                   
              <input id="user_name" type="text" name="user_name" placeholder="Username" required  >
              <span id="user-result"></span>
              <input type="email" id="user_email" name="user_email" placeholder="E-mail" required >
               <span id="email-result"></span>
              <input type="password" name="user_password" placeholder="Password" required />
              <input id="submit" type="submit" name="signup_submit" value="Sign me up" />
              <p id="message"></p>
               </form>
            </div>

            <div class="right">
              <span class="loginwith">Sign in with<br />social network</span>

              <button class="social-signin facebook">Log in with facebook</button>
              <button class="social-signin twitter">Log in with Twitter</button>
              <button class="social-signin google">Log in with Google+</button>
            </div>
            <div class="or">OR</div>
          </div>

        <!--footer-->
        <div id="footer">
        <footer>
            <small>
                Media App  by  NoName  Team
            </small>
            <nav>
                <ul>
                 
                    <li><a href="#">Contact</a></li>
                    <li><a href="#">News</a></li>
                </ul>
            </nav>
        </footer>
        </div>
        <script src="js/register.js"></script>
    </body>
</html>
