package com.user.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import com.dao.UserDao;
import com.Db.DBConnection;
import com.entity.User;

@WebServlet("/UserRegister")
public class UserRegister extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fullname = request.getParameter("fullname");
        String email    = request.getParameter("email");
        String password = request.getParameter("password");
        String phone    = request.getParameter("phone");
        String gender   = request.getParameter("gender");
        String dob      = request.getParameter("dob");
        String bloodGroup = request.getParameter("bloodGroup");
        String address  = request.getParameter("address");

        User u = new User();
        u.setFullname(fullname);
        u.setEmail(email);
        u.setPassword(password);
        u.setPhone(phone);
        u.setGender(gender);
        u.setDob(dob);
        u.setBloodGroup(bloodGroup);
        u.setAddress(address);

        UserDao dao = new UserDao(DBConnection.getConnection());

        if (dao.checkEmailExists(email)) {
            HttpSession session = request.getSession();
            session.setAttribute("errorMsg", "Email already registered. Please login.");
            response.sendRedirect("signup.jsp");
            return;
        }

        boolean f = dao.userRegister(u);
        HttpSession session = request.getSession();
        if (f) {
            session.setAttribute("succMsg", "Registration successful! Please login.");
            response.sendRedirect("user_login.jsp");
        } else {
            session.setAttribute("errorMsg", "Registration failed. Please try again.");
            response.sendRedirect("signup.jsp");
        }
    }
}
