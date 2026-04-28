package com.dao;

import java.sql.*;
import com.entity.User;

public class UserDao {
    private Connection conn;

    public UserDao(Connection conn) {
        this.conn = conn;
    }

    public boolean userRegister(User u) {
        boolean b = false;
        try {
            String query = "INSERT INTO user_details(full_name, email, password, phone, gender, dob, blood_group, address) VALUES(?,?,?,?,?,?,?,?)";
            PreparedStatement pst = conn.prepareStatement(query);
            pst.setString(1, u.getFullname());
            pst.setString(2, u.getEmail());
            pst.setString(3, u.getPassword());
            pst.setString(4, u.getPhone());
            pst.setString(5, u.getGender());
            pst.setString(6, u.getDob());
            pst.setString(7, u.getBloodGroup());
            pst.setString(8, u.getAddress());
            int rowCount = pst.executeUpdate();
            if (rowCount == 1) b = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return b;
    }

    public User login(String email, String password) {
        User u = null;
        try {
            String query = "SELECT * FROM user_details WHERE email=? AND password=?";
            PreparedStatement pst = conn.prepareStatement(query);
            pst.setString(1, email);
            pst.setString(2, password);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                u = mapUser(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return u;
    }

    public User getUserById(int id) {
        User u = null;
        try {
            String query = "SELECT * FROM user_details WHERE id=?";
            PreparedStatement pst = conn.prepareStatement(query);
            pst.setInt(1, id);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                u = mapUser(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return u;
    }

    public boolean checkOldPassword(int userId, String oldPassword) {
        boolean f = false;
        try {
            String query = "SELECT * FROM user_details WHERE id=? AND password=?";
            PreparedStatement pst = conn.prepareStatement(query);
            pst.setInt(1, userId);
            pst.setString(2, oldPassword);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) f = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    public boolean changePassword(int userId, String newPassword) {
        boolean f = false;
        try {
            String query = "UPDATE user_details SET password=? WHERE id=?";
            PreparedStatement pst = conn.prepareStatement(query);
            pst.setString(1, newPassword);
            pst.setInt(2, userId);
            int rowCount = pst.executeUpdate();
            if (rowCount == 1) f = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    public boolean updateProfile(User u) {
        boolean f = false;
        try {
            String query = "UPDATE user_details SET full_name=?, phone=?, gender=?, dob=?, blood_group=?, address=? WHERE id=?";
            PreparedStatement pst = conn.prepareStatement(query);
            pst.setString(1, u.getFullname());
            pst.setString(2, u.getPhone());
            pst.setString(3, u.getGender());
            pst.setString(4, u.getDob());
            pst.setString(5, u.getBloodGroup());
            pst.setString(6, u.getAddress());
            pst.setInt(7, u.getId());
            int rowCount = pst.executeUpdate();
            if (rowCount == 1) f = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    public boolean checkEmailExists(String email) {
        try {
            String query = "SELECT id FROM user_details WHERE email=?";
            PreparedStatement pst = conn.prepareStatement(query);
            pst.setString(1, email);
            ResultSet rs = pst.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    private User mapUser(ResultSet rs) throws SQLException {
        User u = new User();
        u.setId(rs.getInt("id"));
        u.setFullname(rs.getString("full_name"));
        u.setEmail(rs.getString("email"));
        u.setPassword(rs.getString("password"));
        try { u.setPhone(rs.getString("phone")); } catch (Exception ignored) {}
        try { u.setGender(rs.getString("gender")); } catch (Exception ignored) {}
        try { u.setDob(rs.getString("dob")); } catch (Exception ignored) {}
        try { u.setBloodGroup(rs.getString("blood_group")); } catch (Exception ignored) {}
        try { u.setAddress(rs.getString("address")); } catch (Exception ignored) {}
        return u;
    }
}
