/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.ProfileDAO;
import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Profile;
import model.User;
import tools.MD5;
import tools.SendMail;

/**
 *
 * @author manhtran
 */
public class RegisterServlet extends HttpServlet {

    UserDAO userDAO = new UserDAO();
    ProfileDAO profileDAO = new ProfileDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String id = request.getParameter("id");
        String url = "";
        User user = null;
        User user_test = userDAO.getUserFromUsersTest(Long.parseLong(id));
        long user_id = new Date().getTime();
        HttpSession session = request.getSession();
        if(user_test != null){
            userDAO.insertToUser(new User(user_id, user_test.getUser_name(), user_test.getUser_email(), user_test.getUser_password()));
            profileDAO.insertToProfile(new Profile(user_id, user_test.getUser_name(), "NA", "NA", "img/user.png"));
            userDAO.removeUserFromUsersTest(Long.parseLong(id));
            url = "/project/index.jsp";
        } else{
            url = "/project/register.jsp";
        }
        user = userDAO.getUserFromUsers(user_id);
        Cookie loginID = new Cookie("user_id", user.getUser_id() + "");
        Cookie loginName = new Cookie("user_name", user.getUser_name());
        loginID.setMaxAge(30*60);
        loginName.setMaxAge(30*60);
        response.addCookie(loginID);
        response.addCookie(loginName);
        session.setAttribute("user", user);
//        RequestDispatcher rd = getServletContext().getRequestDispatcher(url);
//        rd.forward(request, response);
        response.sendRedirect(url);
    }

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       PrintWriter out = response.getWriter();
       String user_name = request.getParameter("user_name");
       String user_email = request.getParameter("user_email");
       String user_password = request.getParameter("user_password");
       String command = request.getParameter("register");
       //String url = "/project/index.jsp";
       long user_id = new Date().getTime();
       String content="http://10.114.34.141:8080/project/RegisterServlet?id="+user_id+"  \nclick here to active account";
       userDAO.insertToUserTest(new User(user_id, user_name, user_email, MD5.encryption(user_password)));
       SendMail.sendMail(user_email, "Confirmation Account" , content);
       out.print("check your email to finish the registation");
       //response.sendRedirect(url);
    }

   
}
