package com.user.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import com.dao.AppointmentDao;
import com.Db.DBConnection;
import com.entity.Appointment;
import com.entity.User;

@WebServlet("/AppointmentServlet")
public class AppointmentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User userObj = (User) session.getAttribute("userObj");
        if (userObj == null) {
            response.sendRedirect("user_login.jsp");
            return;
        }

        String doctorIdStr      = request.getParameter("doctorId");
        String appointmentDate  = request.getParameter("appointmentDate");

        // ── FIX 3: validate doctor was actually selected ──────────────
        if (doctorIdStr == null || doctorIdStr.trim().isEmpty()) {
            session.setAttribute("errorMsg", "Please select a specialist and a doctor before confirming.");
            response.sendRedirect("user_appointment.jsp");
            return;
        }

        int doctorId;
        try {
            doctorId = Integer.parseInt(doctorIdStr.trim());
        } catch (NumberFormatException e) {
            session.setAttribute("errorMsg", "Invalid doctor selection. Please try again.");
            response.sendRedirect("user_appointment.jsp");
            return;
        }

        AppointmentDao dao = new AppointmentDao(DBConnection.getConnection());

        // ── FIX 3: one appointment per user per doctor per date ───────
        if (dao.isDuplicateAppointment(userObj.getId(), doctorId, appointmentDate)) {
            session.setAttribute("errorMsg",
                "You already have a Pending or Confirmed appointment with this doctor on " +
                appointmentDate + ". Please choose a different date or doctor.");
            response.sendRedirect("user_appointment.jsp");
            return;
        }

        Appointment ap = new Appointment();
        ap.setUserId(userObj.getId());
        ap.setFullName(request.getParameter("fullname"));
        ap.setGender(request.getParameter("gender"));
        ap.setAge(request.getParameter("age"));
        ap.setAppointmentDate(appointmentDate);
        ap.setAppointmentTime(request.getParameter("appointmentTime"));
        ap.setEmail(request.getParameter("email"));
        ap.setPhNo(request.getParameter("phno"));
        ap.setDiseases(request.getParameter("diseases"));
        ap.setDoctorId(doctorId);
        ap.setAddress(request.getParameter("address"));
        ap.setPriority(request.getParameter("priority"));

        boolean f = dao.addAppointment(ap);
        if (f) {
            session.setAttribute("succMsg",
                "Appointment booked successfully! Status: Pending. Your doctor will confirm soon.");
        } else {
            session.setAttribute("errorMsg",
                "Failed to book appointment. Please try again.");
        }
        response.sendRedirect("view_appointment.jsp");
    }
}
