package com.doctor.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;

@WebServlet("/DoctorLogout")
public class DoctorLogout extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.removeAttribute("doctorObj");
            session.invalidate();
        }
        response.sendRedirect("doctor_login.jsp");
    }
}
