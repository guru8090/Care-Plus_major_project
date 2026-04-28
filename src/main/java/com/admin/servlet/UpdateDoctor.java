package com.admin.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import com.dao.DoctorDao;
import com.Db.DBConnection;
import com.entity.Doctor;

@WebServlet("/UpdateDoctor")
public class UpdateDoctor extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("adminObj") == null) { response.sendRedirect("admin_login.jsp"); return; }

        Doctor d = new Doctor();
        d.setId(Integer.parseInt(request.getParameter("id")));
        d.setFullName(request.getParameter("fullname"));
        d.setDob(request.getParameter("dob"));
        d.setQualification(request.getParameter("qualification"));
        d.setEmail(request.getParameter("email"));
        d.setSpec(request.getParameter("specialist"));
        d.setMobno(request.getParameter("mobno"));
        d.setPassword(request.getParameter("password"));
        d.setStatus(request.getParameter("status"));
        d.setExperience(request.getParameter("experience"));
        d.setConsultationFee(request.getParameter("consultationFee"));
        d.setBio(request.getParameter("bio"));
        d.setAvailability(request.getParameter("availability"));

        DoctorDao dao = new DoctorDao(DBConnection.getConnection());
        boolean f = dao.updateDoctor(d);
        if (f) {
            session.setAttribute("succMag", "Doctor updated successfully!");
        } else {
            session.setAttribute("errorMsg", "Failed to update doctor.");
        }
        response.sendRedirect("admin/view_doctor.jsp");
    }
}
