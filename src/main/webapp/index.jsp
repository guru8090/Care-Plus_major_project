<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ page import="com.dao.DoctorDao,com.dao.SpecialistDao,com.Db.DBConnection,com.entity.Doctor,com.entity.Specialist,java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Care+ | Advanced Hospital Management</title>
  <%@include file="component/allcss.jsp"%>
  <style>
    .hero-section {
      background: linear-gradient(135deg,#0f3460 0%,#019ADE 60%,#00d4aa 100%);
      min-height: 88vh; display:flex; align-items:center; position:relative; overflow:hidden;
    }
    .hero-section::before {
      content:''; position:absolute; top:-50%; right:-10%;
      width:600px; height:600px; background:rgba(255,255,255,0.05);
      border-radius:50%; pointer-events:none;
    }
    .hero-section::after {
      content:''; position:absolute; bottom:-30%; left:-5%;
      width:400px; height:400px; background:rgba(0,212,170,0.08);
      border-radius:50%; pointer-events:none;
    }
    .hero-badge { background:rgba(255,255,255,0.15); color:#fff; border-radius:30px; padding:6px 18px; font-size:.85rem; display:inline-block; margin-bottom:16px; backdrop-filter:blur(10px); border:1px solid rgba(255,255,255,0.2); }
    .hero-title { font-size:3.2rem; font-weight:800; color:#fff; line-height:1.2; }
    .hero-sub   { color:rgba(255,255,255,0.85); font-size:1.1rem; max-width:520px; }
    .stat-pill { background:rgba(255,255,255,0.15); border-radius:12px; padding:14px 20px; text-align:center; backdrop-filter:blur(10px); border:1px solid rgba(255,255,255,0.2); }
    .stat-pill h3 { color:#fff; font-weight:800; margin:0; font-size:1.8rem; }
    .stat-pill p  { color:rgba(255,255,255,0.75); margin:0; font-size:.85rem; }
    .search-bar { background:#fff; border-radius:20px; padding:8px 8px 8px 24px; box-shadow:0 8px 40px rgba(0,0,0,0.15); display:flex; align-items:center; gap:12px; }
    .search-bar input { border:none; outline:none; flex:1; font-size:1rem; font-family:'Poppins',sans-serif; }
    .feature-icon { width:60px;height:60px;border-radius:16px;display:flex;align-items:center;justify-content:center;font-size:1.5rem;margin-bottom:16px; }
    .doctor-card { border-radius:20px; overflow:hidden; }
    .doctor-avatar { width:80px;height:80px;border-radius:50%;background:linear-gradient(135deg,#019ADE,#00d4aa);display:flex;align-items:center;justify-content:center;font-size:2rem;color:#fff;margin:0 auto 12px; }

    /* Chatbot */
    #chatWidget { position:fixed; bottom:24px; right:24px; z-index:9999; }
    #chatBox { width:340px; background:#fff; border-radius:20px; box-shadow:0 16px 48px rgba(0,0,0,0.18); overflow:hidden; margin-bottom:10px; display:none; flex-direction:column; }
    @keyframes dotBounce {
      0%,60%,100% { transform:translateY(0); }
      30%          { transform:translateY(-7px); }
    }
  </style>
</head>
<body>

<%@include file="component/navbar.jsp"%>

<!-- HERO -->
<section class="hero-section">
  <div class="container position-relative" style="z-index:2;">
    <div class="row align-items-center g-5">
      <div class="col-lg-6">
        <div class="hero-badge animate__animated animate__fadeInDown">
          <i class="fa-solid fa-sparkles me-2" style="color:#ffe066;"></i>AI-Powered Hospital Management
        </div>
        <h1 class="hero-title animate__animated animate__fadeInLeft">
          Your Health,<br>Our <span style="color:#ffe066;">Priority</span>
        </h1>
        <p class="hero-sub mt-3 mb-4 animate__animated animate__fadeInLeft" style="animation-delay:.2s;">
          Experience next-generation healthcare with smart appointment booking, AI health assistant, and real-time doctor availability.
        </p>
        <div class="search-bar mb-4 animate__animated animate__fadeInUp" style="animation-delay:.3s;">
          <i class="fa-solid fa-magnifying-glass" style="color:#019ADE;"></i>
          <input type="text" id="specialistSearch" placeholder="Search specialist, disease, doctor..." oninput="filterDoctors(this.value)">
          <a href="user_appointment.jsp" class="btn-primary-custom btn" style="border-radius:12px;padding:10px 22px;">Book Now</a>
        </div>
        <div class="row g-3 animate__animated animate__fadeInUp" style="animation-delay:.4s;">
          <%
            DoctorDao heroDao = new DoctorDao(DBConnection.getConnection());
          %>
          <div class="col-4">
            <div class="stat-pill">
              <h3><%=heroDao.countDoctor()%>+</h3>
              <p>Doctors</p>
            </div>
          </div>
          <div class="col-4">
            <div class="stat-pill">
              <h3><%=heroDao.countUser()%>+</h3>
              <p>Patients</p>
            </div>
          </div>
          <div class="col-4">
            <div class="stat-pill">
              <h3><%=heroDao.countAppointment()%>+</h3>
              <p>Appointments</p>
            </div>
          </div>
        </div>
      </div>
      <div class="col-lg-6 text-center d-none d-lg-block">
        <div style="position:relative;display:inline-block;">
          <div style="width:380px;height:380px;border-radius:50%;background:rgba(255,255,255,0.1);display:flex;align-items:center;justify-content:center;margin:auto;border:2px solid rgba(255,255,255,0.2);">
            <div style="width:300px;height:300px;border-radius:50%;background:rgba(255,255,255,0.15);display:flex;align-items:center;justify-content:center;">
              <i class="fa-solid fa-hospital-user" style="font-size:8rem;color:rgba(255,255,255,0.8);"></i>
            </div>
          </div>
          <div style="position:absolute;top:20px;left:-20px;background:#fff;border-radius:14px;padding:12px 18px;box-shadow:0 8px 24px rgba(0,0,0,0.12);">
            <div class="d-flex align-items-center gap-2">
              <div style="width:36px;height:36px;background:#e8f6fd;border-radius:10px;display:flex;align-items:center;justify-content:center;">
                <i class="fa-solid fa-robot" style="color:#019ADE;"></i>
              </div>
              <div><div style="font-size:.75rem;color:#888;">AI Assistant</div><div style="font-weight:700;font-size:.9rem;color:#019ADE;">Online 24/7</div></div>
            </div>
          </div>
          <div style="position:absolute;bottom:40px;right:-30px;background:#fff;border-radius:14px;padding:12px 18px;box-shadow:0 8px 24px rgba(0,0,0,0.12);">
            <div class="d-flex align-items-center gap-2">
              <div style="width:36px;height:36px;background:#e8fff9;border-radius:10px;display:flex;align-items:center;justify-content:center;">
                <i class="fa-solid fa-calendar-check" style="color:#00d4aa;"></i>
              </div>
              <div><div style="font-size:.75rem;color:#888;">Next Slot</div><div style="font-weight:700;font-size:.9rem;color:#00d4aa;">Today 10 AM</div></div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- FEATURES -->
<section class="py-5" style="background:#fff;">
  <div class="container">
    <div class="text-center mb-5">
      <div class="hero-badge" style="background:#e8f6fd;color:#019ADE;border-color:#cce9f9;">Why Choose Care+</div>
      <h2 class="section-title mx-auto mt-3" style="display:inline-block;">Advanced Features</h2>
    </div>
    <div class="row g-4">
      <div class="col-md-4">
        <div class="card p-4 h-100">
          <div class="feature-icon" style="background:#e8f6fd;"><i class="fa-solid fa-robot" style="color:#019ADE;"></i></div>
          <h5 class="fw-700">AI Health Assistant</h5>
          <p class="text-muted">Chat with our AI to get instant symptom checks, health tips, and doctor recommendations 24/7.</p>
        </div>
      </div>
      <div class="col-md-4">
        <div class="card p-4 h-100">
          <div class="feature-icon" style="background:#e8fff9;"><i class="fa-solid fa-calendar-check" style="color:#00d4aa;"></i></div>
          <h5 class="fw-700">Smart Appointments</h5>
          <p class="text-muted">Book, track, and manage appointments in real-time with priority queuing and time-slot selection.</p>
        </div>
      </div>
      <div class="col-md-4">
        <div class="card p-4 h-100">
          <div class="feature-icon" style="background:#fff3e0;"><i class="fa-solid fa-shield-heart" style="color:#ff9800;"></i></div>
          <h5 class="fw-700">Secure Patient Records</h5>
          <p class="text-muted">All your medical data is securely stored with complete appointment history and doctor notes.</p>
        </div>
      </div>
      <div class="col-md-4">
        <div class="card p-4 h-100">
          <div class="feature-icon" style="background:#fce4ec;"><i class="fa-solid fa-user-doctor" style="color:#e91e63;"></i></div>
          <h5 class="fw-700">Expert Doctors</h5>
          <p class="text-muted">Connect with qualified specialists across all medical fields with verified credentials and reviews.</p>
        </div>
      </div>
      <div class="col-md-4">
        <div class="card p-4 h-100">
          <div class="feature-icon" style="background:#ede7f6;"><i class="fa-solid fa-chart-line" style="color:#673ab7;"></i></div>
          <h5 class="fw-700">Admin Analytics</h5>
          <p class="text-muted">Real-time dashboard with appointment stats, doctor performance, and patient insights.</p>
        </div>
      </div>
      <div class="col-md-4">
        <div class="card p-4 h-100">
          <div class="feature-icon" style="background:#e8f5e9;"><i class="fa-solid fa-bell" style="color:#4caf50;"></i></div>
          <h5 class="fw-700">Live Status Tracking</h5>
          <p class="text-muted">Track your appointment status in real-time — Pending, Confirmed, or Completed.</p>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- OUR DOCTORS -->
<section class="py-5" style="background:#f4f8fb;">
  <div class="container">
    <div class="text-center mb-5">
      <h2 class="section-title mx-auto" style="display:inline-block;">Our Expert Doctors</h2>
      <p class="text-muted mt-3">Meet our team of qualified medical professionals</p>
    </div>
    <div class="row g-4" id="doctorGrid">
      <%
        DoctorDao dDao = new DoctorDao(DBConnection.getConnection());
        List<Doctor> doctors = dDao.getAllDoctor();
        String[] icons = {"fa-stethoscope","fa-heart","fa-brain","fa-bone","fa-eye","fa-tooth","fa-lungs","fa-user-doctor"};
        String[] colors = {"#019ADE","#e91e63","#673ab7","#ff9800","#4caf50","#f44336","#00bcd4","#795548"};
        String[] bgs    = {"#e8f6fd","#fce4ec","#ede7f6","#fff3e0","#e8f5e9","#ffebee","#e0f7fa","#efebe9"};
        int di = 0;
        for(Doctor doc : doctors) {
          String ic = icons[di % icons.length];
          String cl = colors[di % colors.length];
          String bg = bgs[di % bgs.length];
          di++;
      %>
      <div class="col-md-3 col-6 doctor-item" data-spec="<%=doc.getSpec()%>">
        <div class="card p-4 text-center h-100">
          <div class="doctor-avatar mx-auto" style="background:<%=bg%>;">
            <i class="fa-solid <%=ic%>" style="color:<%=cl%>;font-size:2rem;"></i>
          </div>
          <h6 class="fw-700 mb-1">Dr. <%=doc.getFullName()%></h6>
          <span class="badge mb-2" style="background:<%=bg%>;color:<%=cl%>;font-size:.78rem;"><%=doc.getSpec()%></span>
          <div class="text-muted" style="font-size:.82rem;">
            <%=doc.getQualification()%>
            <% if(doc.getExperience()!=null && !doc.getExperience().isEmpty()){ %>
            <br><i class="fa-solid fa-clock me-1" style="color:#019ADE;"></i><%=doc.getExperience()%> yrs exp
            <% } %>
          </div>
          <% if(doc.getConsultationFee()!=null && !doc.getConsultationFee().isEmpty()){ %>
          <div class="mt-2" style="font-size:.82rem;color:#00d4aa;font-weight:600;">₹<%=doc.getConsultationFee()%> / visit</div>
          <% } %>
          <a href="user_appointment.jsp" class="btn btn-sm mt-3" style="background:linear-gradient(135deg,#019ADE,#00d4aa);color:#fff;border-radius:20px;">Book Slot</a>
        </div>
      </div>
      <% } %>
      <% if(doctors.isEmpty()){ %>
      <div class="col-12 text-center py-5">
        <i class="fa-solid fa-user-doctor fa-3x text-muted mb-3"></i>
        <p class="text-muted">No doctors registered yet. <a href="admin_login.jsp">Admin Login</a> to add doctors.</p>
      </div>
      <% } %>
    </div>
  </div>
</section>

<!-- HOW IT WORKS -->
<section class="py-5" style="background:#fff;">
  <div class="container">
    <div class="text-center mb-5">
      <h2 class="section-title mx-auto" style="display:inline-block;">How It Works</h2>
    </div>
    <div class="row g-4 text-center">
      <div class="col-md-3">
        <div style="width:64px;height:64px;background:linear-gradient(135deg,#019ADE,#00d4aa);border-radius:50%;display:flex;align-items:center;justify-content:center;margin:0 auto 16px;font-size:1.5rem;color:#fff;font-weight:800;">1</div>
        <h6 class="fw-700">Register / Login</h6>
        <p class="text-muted small">Create your patient account in seconds</p>
      </div>
      <div class="col-md-3">
        <div style="width:64px;height:64px;background:linear-gradient(135deg,#019ADE,#00d4aa);border-radius:50%;display:flex;align-items:center;justify-content:center;margin:0 auto 16px;font-size:1.5rem;color:#fff;font-weight:800;">2</div>
        <h6 class="fw-700">Choose Doctor</h6>
        <p class="text-muted small">Browse specialists and select your preferred doctor</p>
      </div>
      <div class="col-md-3">
        <div style="width:64px;height:64px;background:linear-gradient(135deg,#019ADE,#00d4aa);border-radius:50%;display:flex;align-items:center;justify-content:center;margin:0 auto 16px;font-size:1.5rem;color:#fff;font-weight:800;">3</div>
        <h6 class="fw-700">Book Slot</h6>
        <p class="text-muted small">Pick your date, time and priority level</p>
      </div>
      <div class="col-md-3">
        <div style="width:64px;height:64px;background:linear-gradient(135deg,#019ADE,#00d4aa);border-radius:50%;display:flex;align-items:center;justify-content:center;margin:0 auto 16px;font-size:1.5rem;color:#fff;font-weight:800;">4</div>
        <h6 class="fw-700">Get Consultation</h6>
        <p class="text-muted small">Visit the doctor and track your health journey</p>
      </div>
    </div>
  </div>
</section>

<!-- CTA -->
<section style="background:linear-gradient(135deg,#019ADE,#00d4aa);padding:60px 0;">
  <div class="container text-center text-white">
    <h2 class="fw-800 mb-3">Ready to Take Control of Your Health?</h2>
    <p class="mb-4" style="opacity:.9;">Join thousands of patients who trust Care+ for their healthcare needs.</p>
    <a href="signup.jsp" class="btn btn-light fw-700 rounded-pill px-5 py-3 me-3" style="color:#019ADE;">Get Started Free</a>
    <a href="user_appointment.jsp" class="btn btn-outline-light fw-600 rounded-pill px-5 py-3">Book Appointment</a>
  </div>
</section>

<%@include file="component/footer.jsp"%>

<!-- AI CHATBOT WIDGET -->
<div id="chatWidget">

  <div id="chatBox">
    <!-- Header -->
    <div style="background:linear-gradient(135deg,#019ADE,#00d4aa);padding:14px 16px;display:flex;align-items:center;justify-content:space-between;">
      <div class="d-flex align-items-center gap-2">
        <div style="width:36px;height:36px;background:rgba(255,255,255,0.2);border-radius:50%;display:flex;align-items:center;justify-content:center;flex-shrink:0;">
          <i class="fa-solid fa-robot" style="color:#fff;font-size:1rem;"></i>
        </div>
        <div>
          <div style="color:#fff;font-weight:700;font-size:.9rem;line-height:1.2;">Care+ AI Assistant</div>
          <div style="color:rgba(255,255,255,0.85);font-size:.72rem;">
            <span style="display:inline-block;width:7px;height:7px;background:#4caf50;border-radius:50%;margin-right:4px;"></span>Online
          </div>
        </div>
      </div>
      <button onclick="toggleChat()" style="background:rgba(255,255,255,0.15);border:none;color:#fff;width:28px;height:28px;border-radius:50%;cursor:pointer;font-size:.9rem;display:flex;align-items:center;justify-content:center;">
        <i class="fa-solid fa-xmark"></i>
      </button>
    </div>

    <!-- Messages -->
    <div id="chatMessages" style="height:300px;overflow-y:auto;padding:14px;display:flex;flex-direction:column;gap:10px;background:#fafcff;"></div>

    <!-- Input -->
    <div style="padding:10px 12px;border-top:1px solid #eee;background:#fff;display:flex;gap:8px;align-items:center;">
      <input type="text" id="chatInput" autocomplete="off"
             placeholder="Ask me anything..."
             style="flex:1;border:1.5px solid #e0eefa;border-radius:20px;padding:9px 14px;font-size:.85rem;font-family:'Poppins',sans-serif;outline:none;"
             onfocus="this.style.borderColor='#019ADE'" onblur="this.style.borderColor='#e0eefa'">
      <button onclick="sendChat()"
              style="width:38px;height:38px;border-radius:50%;background:linear-gradient(135deg,#019ADE,#00d4aa);border:none;color:#fff;cursor:pointer;flex-shrink:0;display:flex;align-items:center;justify-content:center;">
        <i class="fa-solid fa-paper-plane" style="font-size:.8rem;"></i>
      </button>
    </div>

    <!-- Quick chips -->
    <div style="padding:6px 12px 10px;background:#fff;display:flex;gap:6px;flex-wrap:wrap;">
      <button onclick="quickMsg('diabetes symptoms')" style="background:#f0f8ff;border:1px solid #cce9f9;border-radius:20px;padding:4px 11px;font-size:.75rem;cursor:pointer;color:#019ADE;font-family:'Poppins',sans-serif;">Diabetes</button>
      <button onclick="quickMsg('I have headache')" style="background:#f0f8ff;border:1px solid #cce9f9;border-radius:20px;padding:4px 11px;font-size:.75rem;cursor:pointer;color:#019ADE;font-family:'Poppins',sans-serif;">Headache</button>
      <button onclick="quickMsg('how to book appointment')" style="background:#f0f8ff;border:1px solid #cce9f9;border-radius:20px;padding:4px 11px;font-size:.75rem;cursor:pointer;color:#019ADE;font-family:'Poppins',sans-serif;">Book appointment</button>
      <button onclick="quickMsg('fever treatment')" style="background:#f0f8ff;border:1px solid #cce9f9;border-radius:20px;padding:4px 11px;font-size:.75rem;cursor:pointer;color:#019ADE;font-family:'Poppins',sans-serif;">Fever</button>
    </div>
  </div>

  <!-- Floating button -->
  <div style="text-align:right;">
    <button onclick="toggleChat()" title="Chat with AI Assistant"
            style="width:56px;height:56px;border-radius:50%;background:linear-gradient(135deg,#019ADE,#00d4aa);border:none;color:#fff;font-size:1.3rem;box-shadow:0 6px 20px rgba(1,154,222,0.45);cursor:pointer;display:flex;align-items:center;justify-content:center;margin-left:auto;">
      <i class="fa-solid fa-robot"></i>
    </button>
    <div style="font-size:.68rem;color:#888;margin-top:3px;text-align:center;">AI Assistant</div>
  </div>

</div><!-- end #chatWidget -->

<script>
var chatOpen = false;

function toggleChat() {
  chatOpen = !chatOpen;
  var box = document.getElementById('chatBox');
  box.style.display = chatOpen ? 'flex' : 'none';
  if (chatOpen) {
    var msgs = document.getElementById('chatMessages');
    if (msgs.children.length === 0) {
      appendBot("👋 Hi! I'm <strong>Care+ AI Assistant</strong>.<br>I can help you with:<br>• Symptom information<br>• Finding the right specialist<br>• Appointment booking guidance<br>• General health tips<br><br>What can I help you with today?");
    }
    setTimeout(function(){ document.getElementById('chatInput').focus(); }, 100);
  }
}

function quickMsg(text) {
  document.getElementById('chatInput').value = text;
  sendChat();
}

function sendChat() {
  var input = document.getElementById('chatInput');
  var msg   = input.value.trim();
  if (!msg) return;
  input.value = '';
  appendUser(msg);
  var typingId = 'typing_' + Date.now();
  appendTyping(typingId);
  setTimeout(function() {
    removeTyping(typingId);
    appendBot(getReply(msg.toLowerCase()));
  }, 700);
}

function appendUser(text) {
  var div = document.createElement('div');
  div.style.cssText = 'background:linear-gradient(135deg,#019ADE,#00d4aa);color:#fff;border-radius:14px 14px 4px 14px;padding:10px 14px;max-width:80%;font-size:.85rem;margin-left:auto;line-height:1.5;word-break:break-word;';
  div.textContent = text;
  var msgs = document.getElementById('chatMessages');
  msgs.appendChild(div);
  msgs.scrollTop = msgs.scrollHeight;
}

function appendBot(html) {
  var div = document.createElement('div');
  div.style.cssText = 'background:#fff;border:1px solid #e0eefa;border-radius:14px 14px 14px 4px;padding:10px 14px;max-width:85%;font-size:.85rem;line-height:1.6;color:#222;word-break:break-word;box-shadow:0 1px 4px rgba(1,154,222,.08);';
  div.innerHTML = html;
  var msgs = document.getElementById('chatMessages');
  msgs.appendChild(div);
  msgs.scrollTop = msgs.scrollHeight;
}

function appendTyping(id) {
  var div = document.createElement('div');
  div.id = id;
  div.style.cssText = 'background:#fff;border:1px solid #e0eefa;border-radius:14px 14px 14px 4px;padding:10px 14px;max-width:60px;display:flex;gap:4px;align-items:center;';
  for (var i = 0; i < 3; i++) {
    var dot = document.createElement('span');
    dot.style.cssText = 'width:7px;height:7px;border-radius:50%;background:#019ADE;display:inline-block;animation:dotBounce .8s infinite;animation-delay:' + (i*0.2) + 's;';
    div.appendChild(dot);
  }
  var msgs = document.getElementById('chatMessages');
  msgs.appendChild(div);
  msgs.scrollTop = msgs.scrollHeight;
}

function removeTyping(id) {
  var el = document.getElementById(id);
  if (el) el.remove();
}

function getReply(msg) {
  if (/^(hi|hello|hey|namaste|hii|good morning|good evening)/.test(msg))
    return "👋 Hello! Welcome to <strong>Care+ AI Assistant</strong>!<br><br>I can help you with symptoms, finding doctors, or booking appointments. What would you like to know?";
  if (msg.includes('book') || msg.includes('appointment') || msg.includes('schedule') || msg.includes('slot'))
    return "📅 <strong>How to book an appointment:</strong><br>1. Click <strong>Login</strong> on the navbar<br>2. Go to <strong>Book Appointment</strong><br>3. Select specialist &amp; doctor<br>4. Pick date &amp; time<br><br>👉 <a href='user_appointment.jsp' style='color:#019ADE;'>Book Now</a>";
  if (msg.includes('diabet') || msg.includes('blood sugar') || msg.includes('sugar level'))
    return "🩺 <strong>Diabetes Symptoms:</strong><br>• Frequent urination<br>• Excessive thirst<br>• Unexplained weight loss<br>• Blurred vision<br>• Fatigue<br><br>👉 Consult our <strong>Endocrinologist</strong>. <a href='user_appointment.jsp' style='color:#019ADE;'>Book Now</a>";
  if (msg.includes('fever') || msg.includes('temperature') || msg.includes('chills'))
    return "🌡️ <strong>For Fever:</strong><br>• Rest and stay hydrated<br>• Paracetamol if temp &gt; 38°C<br>• Wet cloth on forehead<br><br>⚠️ If fever &gt; 3 days → see a doctor immediately.<br>👉 <a href='user_appointment.jsp' style='color:#019ADE;'>Book General Physician</a>";
  if (msg.includes('headache') || msg.includes('migraine') || msg.includes('head pain'))
    return "🧠 <strong>Headache Relief:</strong><br>• Rest in a quiet dark room<br>• Drink plenty of water<br>• Apply cold/warm compress<br>• Avoid screen time<br><br>If recurring → see a <strong>Neurologist</strong>.<br>👉 <a href='user_appointment.jsp' style='color:#019ADE;'>Book Now</a>";
  if (msg.includes('heart') || msg.includes('chest pain') || msg.includes('cardiac') || msg.includes('palpitation'))
    return "❤️ <strong>Chest / Heart Issues:</strong><br>• Sudden severe chest pain → call <strong>112</strong><br>• Symptoms: pressure, left arm pain, breathlessness<br><br>👉 Book our <strong>Cardiologist</strong> now.<br><a href='user_appointment.jsp' style='color:#019ADE;'>Book Now</a>";
  if (msg.includes('skin') || msg.includes('rash') || msg.includes('acne') || msg.includes('itch'))
    return "🩹 <strong>Skin Issues:</strong><br>• Keep area clean and dry<br>• Avoid scratching<br>• Use mild soap<br><br>👉 Consult our <strong>Dermatologist</strong>.<br><a href='user_appointment.jsp' style='color:#019ADE;'>Book Now</a>";
  if (msg.includes('eye') || msg.includes('vision') || msg.includes('blur'))
    return "👁️ <strong>Eye Health:</strong><br>• 20-20-20 rule every 20 mins<br>• Avoid rubbing eyes<br>• Wear UV sunglasses<br><br>👉 Consult our <strong>Ophthalmologist</strong>.<br><a href='user_appointment.jsp' style='color:#019ADE;'>Book Now</a>";
  if (msg.includes('bone') || msg.includes('joint') || msg.includes('knee') || msg.includes('back pain') || msg.includes('arthritis'))
    return "🦴 <strong>Bone / Joint Pain:</strong><br>• Ice first 48hrs then heat<br>• Gentle stretching<br>• Avoid strenuous activity<br><br>👉 Consult our <strong>Orthopedist</strong>.<br><a href='user_appointment.jsp' style='color:#019ADE;'>Book Now</a>";
  if (msg.includes('anxiet') || msg.includes('stress') || msg.includes('depress') || msg.includes('mental') || msg.includes('sad'))
    return "🧘 <strong>Mental Wellness:</strong><br>• Deep breathing &amp; meditation<br>• Regular sleep schedule<br>• Stay connected with loved ones<br><br>💙 Talk to our <strong>Psychiatrist</strong>.<br><a href='user_appointment.jsp' style='color:#019ADE;'>Book Now</a>";
  if (msg.includes('cold') || msg.includes('cough') || msg.includes('flu') || msg.includes('sore throat'))
    return "🤧 <strong>Cold &amp; Cough:</strong><br>• Warm water and honey<br>• Steam inhalation<br>• Avoid cold drinks<br>• Rest well<br><br>If &gt; 5 days → <a href='user_appointment.jsp' style='color:#019ADE;'>Book General Physician</a>";
  if (msg.includes('stomach') || msg.includes('vomit') || msg.includes('diarrhea') || msg.includes('nausea'))
    return "🫁 <strong>Stomach Issues:</strong><br>• Stay hydrated (ORS if diarrhea)<br>• Eat light — rice, banana, toast<br>• Avoid oily/spicy food<br><br>👉 <a href='user_appointment.jsp' style='color:#019ADE;'>Book General Physician</a>";
  if (msg.includes('emergency') || msg.includes('urgent') || msg.includes('critical'))
    return "🚨 <strong>EMERGENCY:</strong><br>• Call: <strong>112</strong><br>• Ambulance: <strong>108</strong><br>• Helpline: <strong>+91 98765 43210</strong><br><br><a href='user_appointment.jsp' style='color:#019ADE;'>Book priority appointment</a>";
  if (msg.includes('doctor') || msg.includes('specialist'))
    return "👨‍⚕️ <strong>Our Specialists:</strong><br>• Cardiologist (Heart)<br>• Neurologist (Brain)<br>• Dermatologist (Skin)<br>• Orthopedist (Bones)<br>• Ophthalmologist (Eyes)<br>• General Physician<br>• Psychiatrist<br><br>👉 <a href='user_appointment.jsp' style='color:#019ADE;'>Book Now</a>";
  if (msg.includes('thank') || msg.includes('ok') || msg.includes('okay') || msg.includes('good'))
    return "😊 You're welcome! Stay healthy and take care. 💙";
  return "🤖 For personalised medical advice, please consult one of our qualified doctors.<br>👉 <a href='user_appointment.jsp' style='color:#019ADE;'>Book an appointment</a> or call <strong>+91 98765 43210</strong>";
}

document.addEventListener('DOMContentLoaded', function() {
  document.getElementById('chatInput').addEventListener('keydown', function(e) {
    if (e.key === 'Enter') { e.preventDefault(); sendChat(); }
  });
});

function filterDoctors(query) {
  var items = document.querySelectorAll('.doctor-item');
  var q = query.toLowerCase();
  items.forEach(function(item) {
    var spec = item.getAttribute('data-spec').toLowerCase();
    var name = item.innerText.toLowerCase();
    item.style.display = (spec.includes(q) || name.includes(q) || q === '') ? '' : 'none';
  });
}
</script>

</body>
</html>