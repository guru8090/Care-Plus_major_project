package com.doctor.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import com.dao.DoctorDao;
import com.Db.DBConnection;
import com.entity.Doctor;

@WebServlet("/DoctorChangePassword")
public class DoctorChangePassword extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Doctor doctorObj = (Doctor) session.getAttribute("doctorObj");
        if (doctorObj == null) { response.sendRedirect("doctor_login.jsp"); return; }

        String oldPass = request.getParameter("oldPassword");
        String newPass = request.getParameter("newPassword");

        DoctorDao dao = new DoctorDao(DBConnection.getConnection());
        if (dao.checkOldPassword(doctorObj.getId(), oldPass)) {
            boolean f = dao.changePassword(doctorObj.getId(), newPass);
            session.setAttribute(f ? "succMsg" : "errorMsg",
                f ? "Password changed successfully!" : "Failed to change password.");
        } else {
            session.setAttribute("errorMsg", "Incorrect old password.");
        }
        response.sendRedirect("doctor/change_password.jsp");
    }
}
