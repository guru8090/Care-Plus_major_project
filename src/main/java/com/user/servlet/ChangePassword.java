package com.user.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import com.dao.UserDao;
import com.Db.DBConnection;
import com.entity.User;

@WebServlet("/ChangePassword")
public class ChangePassword extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User userObj = (User) session.getAttribute("userObj");
        if (userObj == null) { response.sendRedirect("user_login.jsp"); return; }

        String oldPass = request.getParameter("oldPassword");
        String newPass = request.getParameter("newPassword");

        UserDao dao = new UserDao(DBConnection.getConnection());
        if (dao.checkOldPassword(userObj.getId(), oldPass)) {
            boolean f = dao.changePassword(userObj.getId(), newPass);
            if (f) {
                session.setAttribute("succMsg", "Password changed successfully!");
            } else {
                session.setAttribute("errorMsg", "Failed to change password.");
            }
        } else {
            session.setAttribute("errorMsg", "Incorrect old password.");
        }
        response.sendRedirect("change_password.jsp");
    }
}
