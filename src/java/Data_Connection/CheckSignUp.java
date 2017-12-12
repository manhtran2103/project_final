/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Data_Connection;

import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author manhtran
 */
public class CheckSignUp extends HttpServlet {
    
    UserDAO userDAO = new UserDAO();
            
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
    }

  
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            //check username
            String user_name = request.getParameter("user_name");
            String user_email = request.getParameter("user_email");
            if(user_name != null){
                if (userDAO.checkUserName(user_name)) {
                    response.getWriter().write("<img src=\"img/not-available.png\" />");
                } else {
                    response.getWriter().write("<img src=\"img/available.png\" />");
                }
            }
            // check eamail
            if(user_email != null){
                if (userDAO.checkEmail(user_email)) {
                    response.getWriter().write("<img src=\"img/not-available.png\" />");
                } else {
                    response.getWriter().write("<img src=\"img/available.png\" />");
                }
            }
        
    }

}
