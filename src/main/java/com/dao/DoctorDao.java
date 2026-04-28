package com.dao;

import java.sql.*;
import java.util.*;
import com.entity.Doctor;

public class DoctorDao {
    private Connection conn;

    public DoctorDao(Connection conn) {
        this.conn = conn;
    }

    public boolean registerDoctor(Doctor d) {
        boolean f = false;
        try {
            String query = "INSERT INTO doctor(full_name,dob,qualification,email,specialist,mobno,password,status,experience,consultation_fee,bio,availability) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)";
            PreparedStatement pst = conn.prepareStatement(query);
            pst.setString(1, d.getFullName());
            pst.setString(2, d.getDob());
            pst.setString(3, d.getQualification());
            pst.setString(4, d.getEmail());
            pst.setString(5, d.getSpec());
            pst.setString(6, d.getMobno());
            pst.setString(7, d.getPassword());
            pst.setString(8, "Active");
            pst.setString(9, d.getExperience() != null ? d.getExperience() : "0");
            pst.setString(10, d.getConsultationFee() != null ? d.getConsultationFee() : "500");
            pst.setString(11, d.getBio() != null ? d.getBio() : "");
            pst.setString(12, d.getAvailability() != null ? d.getAvailability() : "Mon-Sat");
            int rowCount = pst.executeUpdate();
            if (rowCount == 1) f = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    public List<Doctor> getAllDoctor() {
        List<Doctor> list = new ArrayList<>();
        try {
            String query = "SELECT * FROM doctor ORDER BY id DESC";
            PreparedStatement pst = conn.prepareStatement(query);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                list.add(mapDoctor(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Doctor> getDoctorBySpec(String spec) {
        List<Doctor> list = new ArrayList<>();
        try {
            String query = "SELECT * FROM doctor WHERE specialist=? AND status='Active'";
            PreparedStatement pst = conn.prepareStatement(query);
            pst.setString(1, spec);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                list.add(mapDoctor(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Doctor getDoctorById(int id) {
        Doctor d = null;
        try {
            String query = "SELECT * FROM doctor WHERE id=?";
            PreparedStatement pst = conn.prepareStatement(query);
            pst.setInt(1, id);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) d = mapDoctor(rs);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return d;
    }

    public boolean updateDoctor(Doctor d) {
        boolean f = false;
        try {
            String query = "UPDATE doctor SET full_name=?,dob=?,qualification=?,email=?,specialist=?,mobno=?,password=?,status=?,experience=?,consultation_fee=?,bio=?,availability=? WHERE id=?";
            PreparedStatement pst = conn.prepareStatement(query);
            pst.setString(1, d.getFullName());
            pst.setString(2, d.getDob());
            pst.setString(3, d.getQualification());
            pst.setString(4, d.getEmail());
            pst.setString(5, d.getSpec());
            pst.setString(6, d.getMobno());
            pst.setString(7, d.getPassword());
            pst.setString(8, d.getStatus());
            pst.setString(9, d.getExperience());
            pst.setString(10, d.getConsultationFee());
            pst.setString(11, d.getBio());
            pst.setString(12, d.getAvailability());
            pst.setInt(13, d.getId());
            if (pst.executeUpdate() == 1) f = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    public boolean deleteDoctor(int id) {
        boolean f = false;
        try {
            String query = "DELETE FROM doctor WHERE id=?";
            PreparedStatement pst = conn.prepareStatement(query);
            pst.setInt(1, id);
            if (pst.executeUpdate() == 1) f = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    public Doctor login(String email, String password) {
        Doctor d = null;
        try {
            String query = "SELECT * FROM doctor WHERE email=? AND password=?";
            PreparedStatement pst = conn.prepareStatement(query);
            pst.setString(1, email);
            pst.setString(2, password);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) d = mapDoctor(rs);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return d;
    }

    public boolean editDoctorProfile(Doctor d) {
        boolean f = false;
        try {
            String query = "UPDATE doctor SET full_name=?,dob=?,qualification=?,email=?,specialist=?,mobno=?,experience=?,consultation_fee=?,bio=?,availability=? WHERE id=?";
            PreparedStatement pst = conn.prepareStatement(query);
            pst.setString(1, d.getFullName());
            pst.setString(2, d.getDob());
            pst.setString(3, d.getQualification());
            pst.setString(4, d.getEmail());
            pst.setString(5, d.getSpec());
            pst.setString(6, d.getMobno());
            pst.setString(7, d.getExperience());
            pst.setString(8, d.getConsultationFee());
            pst.setString(9, d.getBio());
            pst.setString(10, d.getAvailability());
            pst.setInt(11, d.getId());
            if (pst.executeUpdate() == 1) f = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    public boolean checkOldPassword(int userId, String oldPassword) {
        try {
            PreparedStatement pst = conn.prepareStatement("SELECT * FROM doctor WHERE id=? AND password=?");
            pst.setInt(1, userId);
            pst.setString(2, oldPassword);
            return pst.executeQuery().next();
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    public boolean changePassword(int userId, String newPassword) {
        try {
            PreparedStatement pst = conn.prepareStatement("UPDATE doctor SET password=? WHERE id=?");
            pst.setString(1, newPassword);
            pst.setInt(2, userId);
            return pst.executeUpdate() == 1;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    public int countDoctor() {
        try {
            ResultSet rs = conn.prepareStatement("SELECT COUNT(*) FROM doctor").executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    public int countUser() {
        try {
            ResultSet rs = conn.prepareStatement("SELECT COUNT(*) FROM user_details").executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    public int countAppointment() {
        try {
            ResultSet rs = conn.prepareStatement("SELECT COUNT(*) FROM appointment").executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    public int countSpecialist() {
        try {
            ResultSet rs = conn.prepareStatement("SELECT COUNT(*) FROM specialist").executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    public int countAppointmentByDoctorId(int did) {
        try {
            PreparedStatement pst = conn.prepareStatement("SELECT COUNT(*) FROM appointment WHERE doctor_id=?");
            pst.setInt(1, did);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    public int countTodayAppointments() {
        try {
            ResultSet rs = conn.prepareStatement("SELECT COUNT(*) FROM appointment WHERE appointment_date=CURDATE()").executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    private Doctor mapDoctor(ResultSet rs) throws SQLException {
        Doctor d = new Doctor();
        d.setId(rs.getInt("id"));
        d.setFullName(rs.getString("full_name"));
        d.setDob(rs.getString("dob"));
        d.setQualification(rs.getString("qualification"));
        d.setEmail(rs.getString("email"));
        d.setSpec(rs.getString("specialist"));
        d.setMobno(rs.getString("mobno"));
        d.setPassword(rs.getString("password"));
        try { d.setStatus(rs.getString("status")); } catch (Exception ignored) {}
        try { d.setExperience(rs.getString("experience")); } catch (Exception ignored) {}
        try { d.setConsultationFee(rs.getString("consultation_fee")); } catch (Exception ignored) {}
        try { d.setBio(rs.getString("bio")); } catch (Exception ignored) {}
        try { d.setAvailability(rs.getString("availability")); } catch (Exception ignored) {}
        return d;
    }
}
