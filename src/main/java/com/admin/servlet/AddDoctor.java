package com.admin.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import com.dao.DoctorDao;
import com.Db.DBConnection;
import com.entity.Doctor;

@WebServlet("/AddDoctor")
public class AddDoctor extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("adminObj") == null) { response.sendRedirect("admin_login.jsp"); return; }

        Doctor d = new Doctor();
        d.setFullName(request.getParameter("fullname"));
        d.setDob(request.getParameter("dob"));
        d.setQualification(request.getParameter("qualification"));
        d.setEmail(request.getParameter("email"));
        d.setSpec(request.getParameter("specialist"));
        d.setMobno(request.getParameter("mobno"));
        d.setPassword(request.getParameter("password"));
        d.setExperience(request.getParameter("experience"));
        d.setConsultationFee(request.getParameter("consultationFee"));
        d.setBio(request.getParameter("bio"));
        d.setAvailability(request.getParameter("availability"));

        DoctorDao dao = new DoctorDao(DBConnection.getConnection());
        boolean f = dao.registerDoctor(d);
        if (f) {
            session.setAttribute("succMag", "Doctor added successfully!");
        } else {
            session.setAttribute("errorMsg", "Failed to add doctor.");
        }
        response.sendRedirect("admin/doctor.jsp");
    }
}
