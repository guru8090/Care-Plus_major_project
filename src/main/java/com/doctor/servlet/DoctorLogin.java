package com.doctor.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import com.dao.DoctorDao;
import com.Db.DBConnection;
import com.entity.Doctor;

@WebServlet("/DoctorLogin")
public class DoctorLogin extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email    = request.getParameter("email");
        String password = request.getParameter("password");

        DoctorDao dao = new DoctorDao(DBConnection.getConnection());
        Doctor d = dao.login(email, password);
        HttpSession session = request.getSession();

        if (d != null) {
            session.setAttribute("doctorObj", d);
            response.sendRedirect("doctor/index.jsp");
        } else {
            session.setAttribute("errorMsg", "Invalid email or password.");
            response.sendRedirect("doctor_login.jsp");
        }
    }
}
