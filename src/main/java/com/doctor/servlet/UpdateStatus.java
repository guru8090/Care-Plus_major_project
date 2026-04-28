package com.doctor.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import com.dao.AppointmentDao;
import com.Db.DBConnection;
import com.entity.Doctor;

@WebServlet("/UpdateStatus")
public class UpdateStatus extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Doctor doctorObj = (Doctor) session.getAttribute("doctorObj");
        if (doctorObj == null) { response.sendRedirect("doctor_login.jsp"); return; }

        int apId    = Integer.parseInt(request.getParameter("apId"));
        String status = request.getParameter("status");
        String notes  = request.getParameter("notes");

        AppointmentDao dao = new AppointmentDao(DBConnection.getConnection());
        dao.updateStatus(apId, doctorObj.getId(), status);
        if (notes != null && !notes.trim().isEmpty()) {
            dao.addDoctorNotes(apId, doctorObj.getId(), notes);
        }
        session.setAttribute("succMsg", "Appointment updated successfully!");
        response.sendRedirect("doctor/patient.jsp");
    }
}
