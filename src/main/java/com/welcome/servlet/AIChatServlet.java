package com.welcome.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import com.google.gson.*;

@WebServlet("/AIChatServlet")
public class AIChatServlet extends HttpServlet {

    // Simple rule-based AI for hospital context (no external API key needed)
    // Can be upgraded to OpenAI/Gemini API by replacing the logic below

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        StringBuilder sb = new StringBuilder();
        String line;
        try (BufferedReader reader = request.getReader()) {
            while ((line = reader.readLine()) != null) sb.append(line);
        }

        JsonObject json = JsonParser.parseString(sb.toString()).getAsJsonObject();
        String userMsg = json.get("message").getAsString().toLowerCase().trim();

        String reply = generateReply(userMsg);

        JsonObject out = new JsonObject();
        out.addProperty("reply", reply);
        response.getWriter().write(out.toString());
    }

    private String generateReply(String msg) {
        // Appointment related
        if (msg.contains("book") || msg.contains("appointment") || msg.contains("schedule")) {
            return "📅 To book an appointment:<br>1. <a href='user_login.jsp'>Login</a> to your account<br>2. Click <b>Book Appointment</b><br>3. Select your specialist & preferred doctor<br>4. Choose date, time & priority<br><br>Need help finding the right specialist?";
        }
        // Diabetes
        if (msg.contains("diabetes") || msg.contains("sugar") || msg.contains("blood sugar")) {
            return "🩺 <b>Diabetes Symptoms:</b><br>• Frequent urination<br>• Excessive thirst<br>• Unexplained weight loss<br>• Blurred vision<br>• Fatigue<br>• Slow-healing wounds<br><br>👉 I recommend consulting our <b>Endocrinologist</b>. <a href='user_appointment.jsp'>Book now</a>";
        }
        // Fever
        if (msg.contains("fever") || msg.contains("temperature") || msg.contains("chills")) {
            return "🌡️ <b>For Fever:</b><br>• Rest and stay hydrated<br>• Take paracetamol if temp > 38°C<br>• If fever lasts >3 days or exceeds 40°C — seek emergency care<br><br>👉 Book with our <b>General Physician</b>. <a href='user_appointment.jsp'>Book now</a>";
        }
        // Headache
        if (msg.contains("headache") || msg.contains("migraine") || msg.contains("head pain")) {
            return "🧠 <b>Headache Relief Tips:</b><br>• Rest in a quiet, dark room<br>• Stay hydrated — drink water<br>• Apply cold/warm compress<br>• Avoid screens for a while<br><br>⚠️ If severe or recurring, see a <b>Neurologist</b>. <a href='user_appointment.jsp'>Book now</a>";
        }
        // Heart
        if (msg.contains("heart") || msg.contains("chest pain") || msg.contains("cardiac") || msg.contains("palpitation")) {
            return "❤️ <b>Important:</b> Chest pain could be serious.<br>• If sudden & severe — call emergency: <b>112</b><br>• Symptoms: chest pressure, left arm pain, shortness of breath<br><br>👉 Book with our <b>Cardiologist</b> immediately. <a href='user_appointment.jsp'>Book now</a>";
        }
        // Skin
        if (msg.contains("skin") || msg.contains("rash") || msg.contains("acne") || msg.contains("itching")) {
            return "🩹 <b>Skin Concerns:</b><br>• Keep affected area clean and dry<br>• Avoid scratching<br>• Use mild, unscented soap<br>• Stay out of direct sun<br><br>👉 Book with our <b>Dermatologist</b> for proper diagnosis. <a href='user_appointment.jsp'>Book now</a>";
        }
        // Eye
        if (msg.contains("eye") || msg.contains("vision") || msg.contains("blur")) {
            return "👁️ <b>Eye Health Tips:</b><br>• Follow 20-20-20 rule (every 20 min, look 20 feet away for 20 sec)<br>• Avoid rubbing eyes<br>• Wear UV-protective sunglasses<br><br>👉 Book with our <b>Ophthalmologist</b>. <a href='user_appointment.jsp'>Book now</a>";
        }
        // Bone/joint
        if (msg.contains("bone") || msg.contains("joint") || msg.contains("knee") || msg.contains("back pain") || msg.contains("arthritis")) {
            return "🦴 <b>Joint/Bone Pain:</b><br>• Apply ice (first 48 hrs) then heat<br>• Gentle stretching helps<br>• Avoid strenuous activity<br>• Maintain healthy weight<br><br>👉 Book with our <b>Orthopedist</b>. <a href='user_appointment.jsp'>Book now</a>";
        }
        // Mental health
        if (msg.contains("anxiety") || msg.contains("stress") || msg.contains("depression") || msg.contains("mental")) {
            return "🧘 <b>Mental Wellness Tips:</b><br>• Practice deep breathing / meditation<br>• Maintain regular sleep schedule<br>• Stay connected with loved ones<br>• Exercise regularly<br><br>💙 You're not alone. Book with our <b>Psychiatrist</b>. <a href='user_appointment.jsp'>Book now</a>";
        }
        // Emergency
        if (msg.contains("emergency") || msg.contains("urgent") || msg.contains("critical")) {
            return "🚨 <b>EMERGENCY:</b><br>• Call: <b>112</b> (Emergency)<br>• Ambulance: <b>108</b><br>• Our 24/7 helpline: <b>+91 98765 43210</b><br><br>If it's not life-threatening, <a href='user_appointment.jsp'>book a priority appointment</a>.";
        }
        // Greeting
        if (msg.contains("hello") || msg.contains("hi") || msg.contains("hey") || msg.contains("namaste")) {
            return "👋 Hello! Welcome to <b>Care+ AI Assistant</b>!<br><br>I can help you with:<br>• 🩺 Symptom information<br>• 📅 Booking appointments<br>• 👨‍⚕️ Finding specialists<br>• 💊 Health tips<br><br>What would you like to know?";
        }
        // Doctor info
        if (msg.contains("doctor") || msg.contains("specialist") || msg.contains("which doctor")) {
            return "👨‍⚕️ <b>Our Specialists include:</b><br>• Cardiologist (Heart)<br>• Neurologist (Brain/Nerves)<br>• Dermatologist (Skin)<br>• Orthopedist (Bones)<br>• Ophthalmologist (Eyes)<br>• General Physician<br><br>👉 <a href='user_appointment.jsp'>Book with any specialist</a>";
        }
        // Default
        return "🤖 I understand you need help with: <i>\"" + msg + "\"</i><br><br>For personalized medical advice, please consult one of our qualified doctors.<br>👉 <a href='user_appointment.jsp'>Book an appointment</a> or call us at <b>+91 98765 43210</b>";
    }
}
