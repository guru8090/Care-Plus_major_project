package com.doctor.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import com.dao.DoctorDao;
import com.Db.DBConnection;
import com.entity.Doctor;

@WebServlet("/DoctorEditProfile")
public class DoctorEditProfile extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Doctor doctorObj = (Doctor) session.getAttribute("doctorObj");
        if (doctorObj == null) { response.sendRedirect("doctor_login.jsp"); return; }

        doctorObj.setFullName(request.getParameter("fullname"));
        doctorObj.setDob(request.getParameter("dob"));
        doctorObj.setQualification(request.getParameter("qualification"));
        doctorObj.setEmail(request.getParameter("email"));
        doctorObj.setSpec(request.getParameter("specialist"));
        doctorObj.setMobno(request.getParameter("mobno"));
        doctorObj.setExperience(request.getParameter("experience"));
        doctorObj.setConsultationFee(request.getParameter("consultationFee"));
        doctorObj.setBio(request.getParameter("bio"));
        doctorObj.setAvailability(request.getParameter("availability"));

        DoctorDao dao = new DoctorDao(DBConnection.getConnection());
        boolean f = dao.editDoctorProfile(doctorObj);
        if (f) {
            session.setAttribute("doctorObj", doctorObj);
            session.setAttribute("succMsg", "Profile updated successfully!");
        } else {
            session.setAttribute("errorMsg", "Failed to update profile.");
        }
        response.sendRedirect("doctor/index.jsp");
    }
}
