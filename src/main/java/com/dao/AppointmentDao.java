package com.dao;

import java.sql.*;
import java.util.*;
import com.entity.Appointment;

public class AppointmentDao {
    private Connection conn;

    public AppointmentDao(Connection conn) {
        this.conn = conn;
    }

    // ── FIX 3: check if this user already has a PENDING or CONFIRMED
    //           appointment with the same doctor on the same date.
    public boolean isDuplicateAppointment(int userId, int doctorId, String date) {
        try {
            String sql = "SELECT COUNT(*) FROM appointment " +
                         "WHERE user_id=? AND doctor_id=? AND appointment_date=? " +
                         "AND status IN ('Pending','Confirmed')";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, userId);
            pst.setInt(2, doctorId);
            pst.setString(3, date);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) return rs.getInt(1) > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    public boolean addAppointment(Appointment ap) {
        try {
            String query = "INSERT INTO appointment(user_id,fullname,gender,age," +
                           "appointment_date,appointment_time,email,phno,diseases," +
                           "doctor_id,address,status,priority,created_at) " +
                           "VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,NOW())";
            PreparedStatement pst = conn.prepareStatement(query);
            pst.setInt(1, ap.getUserId());
            pst.setString(2, ap.getFullName());
            pst.setString(3, ap.getGender());
            pst.setString(4, ap.getAge());
            pst.setString(5, ap.getAppointmentDate());
            pst.setString(6, ap.getAppointmentTime() != null ? ap.getAppointmentTime() : "09:00");
            pst.setString(7, ap.getEmail());
            pst.setString(8, ap.getPhNo());
            pst.setString(9, ap.getDiseases());
            pst.setInt(10, ap.getDoctorId());
            pst.setString(11, ap.getAddress());
            pst.setString(12, "Pending");
            pst.setString(13, ap.getPriority() != null ? ap.getPriority() : "Normal");
            return pst.executeUpdate() == 1;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    public List<Appointment> getAllAppointmentByLoginUser(int userId) {
        List<Appointment> list = new ArrayList<>();
        try {
            PreparedStatement pst = conn.prepareStatement(
                "SELECT * FROM appointment WHERE user_id=? ORDER BY appointment_date DESC");
            pst.setInt(1, userId);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) list.add(mapAppointment(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public List<Appointment> getAllAppointmentByDoctor(int doctorId) {
        List<Appointment> list = new ArrayList<>();
        try {
            PreparedStatement pst = conn.prepareStatement(
                "SELECT * FROM appointment WHERE doctor_id=? ORDER BY appointment_date DESC");
            pst.setInt(1, doctorId);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) list.add(mapAppointment(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public List<Appointment> getAllAppointment() {
        List<Appointment> list = new ArrayList<>();
        try {
            ResultSet rs = conn.prepareStatement(
                "SELECT * FROM appointment ORDER BY created_at DESC").executeQuery();
            while (rs.next()) list.add(mapAppointment(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public Appointment getAppointById(int id) {
        try {
            PreparedStatement pst = conn.prepareStatement(
                "SELECT * FROM appointment WHERE id=?");
            pst.setInt(1, id);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) return mapAppointment(rs);
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    public boolean updateStatus(int id, int doctorId, String status) {
        try {
            PreparedStatement pst = conn.prepareStatement(
                "UPDATE appointment SET status=? WHERE id=? AND doctor_id=?");
            pst.setString(1, status);
            pst.setInt(2, id);
            pst.setInt(3, doctorId);
            return pst.executeUpdate() == 1;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    public boolean addDoctorNotes(int id, int doctorId, String notes) {
        try {
            PreparedStatement pst = conn.prepareStatement(
                "UPDATE appointment SET notes=? WHERE id=? AND doctor_id=?");
            pst.setString(1, notes);
            pst.setInt(2, id);
            pst.setInt(3, doctorId);
            return pst.executeUpdate() == 1;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    public List<Appointment> getTodayAppointmentsByDoctor(int doctorId) {
        List<Appointment> list = new ArrayList<>();
        try {
            PreparedStatement pst = conn.prepareStatement(
                "SELECT * FROM appointment WHERE doctor_id=? AND appointment_date=CURDATE() " +
                "ORDER BY appointment_time");
            pst.setInt(1, doctorId);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) list.add(mapAppointment(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    private Appointment mapAppointment(ResultSet rs) throws SQLException {
        Appointment ap = new Appointment();
        ap.setId(rs.getInt("id"));
        ap.setUserId(rs.getInt("user_id"));
        ap.setFullName(rs.getString("fullname"));
        ap.setGender(rs.getString("gender"));
        ap.setAge(rs.getString("age"));
        ap.setAppointmentDate(rs.getString("appointment_date"));
        try { ap.setAppointmentTime(rs.getString("appointment_time")); } catch(Exception ignored){}
        ap.setEmail(rs.getString("email"));
        ap.setPhNo(rs.getString("phno"));
        ap.setDiseases(rs.getString("diseases"));
        ap.setDoctorId(rs.getInt("doctor_id"));
        ap.setAddress(rs.getString("address"));
        ap.setStatus(rs.getString("status"));
        try { ap.setNotes(rs.getString("notes")); } catch(Exception ignored){}
        try { ap.setPriority(rs.getString("priority")); } catch(Exception ignored){}
        try { ap.setCreatedAt(rs.getString("created_at")); } catch(Exception ignored){}
        return ap;
    }
}
