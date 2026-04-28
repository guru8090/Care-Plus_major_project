package com.user.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import com.dao.UserDao;
import com.Db.DBConnection;
import com.entity.User;

@WebServlet("/UserLogin")
public class UserLogin extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email    = request.getParameter("email");
        String password = request.getParameter("password");

        UserDao dao = new UserDao(DBConnection.getConnection());
        User u = dao.login(email, password);

        HttpSession session = request.getSession();
        if (u != null) {
            session.setAttribute("userObj", u);
            response.sendRedirect("index.jsp");
        } else {
            session.setAttribute("errorMsg", "Invalid email or password.");
            response.sendRedirect("user_login.jsp");
        }
    }
}
