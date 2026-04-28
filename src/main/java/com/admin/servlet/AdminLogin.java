package com.admin.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;

@WebServlet("/AdminLogin")
public class AdminLogin extends HttpServlet {
    private static final String ADMIN_EMAIL = "admin@careplus.com";
    private static final String ADMIN_PASSWORD = "admin123";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email    = request.getParameter("email");
        String password = request.getParameter("password");
        HttpSession session = request.getSession();

        if (ADMIN_EMAIL.equals(email) && ADMIN_PASSWORD.equals(password)) {
            session.setAttribute("adminObj", "admin");
            response.sendRedirect("admin/index.jsp");
        } else {
            session.setAttribute("errorMsg", "Invalid admin credentials.");
            response.sendRedirect("admin_login.jsp");
        }
    }
}
