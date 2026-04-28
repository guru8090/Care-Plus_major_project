package com.dao;

import java.sql.*;
import java.util.*;
import com.entity.Specialist;

public class SpecialistDao {
    private Connection conn;

    public SpecialistDao(Connection conn) { this.conn = conn; }

    public boolean addSpecialist(Specialist s) {
        try {
            PreparedStatement pst = conn.prepareStatement("INSERT INTO specialist(spec_name) VALUES(?)");
            pst.setString(1, s.getSpecName());
            return pst.executeUpdate() == 1;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    public List<Specialist> getAllSpecialist() {
        List<Specialist> list = new ArrayList<>();
        try {
            ResultSet rs = conn.prepareStatement("SELECT * FROM specialist ORDER BY spec_name").executeQuery();
            while (rs.next()) {
                Specialist s = new Specialist();
                s.setId(rs.getInt("id"));
                s.setSpecName(rs.getString("spec_name"));
                list.add(s);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public boolean deleteSpecialist(int id) {
        try {
            PreparedStatement pst = conn.prepareStatement("DELETE FROM specialist WHERE id=?");
            pst.setInt(1, id);
            return pst.executeUpdate() == 1;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }
}
