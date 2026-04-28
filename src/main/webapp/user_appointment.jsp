<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ page import="com.dao.DoctorDao,com.dao.SpecialistDao,com.Db.DBConnection,com.entity.Doctor,com.entity.Specialist,java.util.List,com.entity.User" %>
<c:if test="${empty userObj}"><c:redirect url="user_login.jsp"/></c:if>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Care+ | Book Appointment</title>
  <%@include file="component/allcss.jsp"%>
  <style>
    body{background:#f4f8fb;}
    .form-control,.form-select{border-radius:12px;border:2px solid #e9ecef;padding:11px 16px;font-family:'Poppins',sans-serif;}
    .form-control:focus,.form-select:focus{border-color:#019ADE;box-shadow:0 0 0 3px rgba(1,154,222,.1);}
    .priority-btn{border:2px solid #e9ecef;border-radius:12px;padding:12px;text-align:center;cursor:pointer;transition:all .3s;}
    .priority-btn.selected-normal   {border-color:#4caf50;background:#e8f5e9;}
    .priority-btn.selected-urgent   {border-color:#ff9800;background:#fff3e0;}
    .priority-btn.selected-emergency{border-color:#f44336;background:#ffebee;}
    /* highlight when no doctor chosen yet */
    #doctorSelect.is-invalid{border-color:#f44336;}
  </style>
</head>
<body>
<%@include file="component/navbar.jsp"%>

<%
  /* ── FIX 2: build doctor JSON on the SERVER so names are 100% correct ── */
  DoctorDao   dDao  = new DoctorDao(DBConnection.getConnection());
  SpecialistDao sDao = new SpecialistDao(DBConnection.getConnection());
  List<Doctor>     allDocs = dDao.getAllDoctor();
  List<Specialist> specs   = sDao.getAllSpecialist();

  /* Build a safe JSON string — escape apostrophes / quotes in names */
  StringBuilder docJson = new StringBuilder("[");
  for(int i=0;i<allDocs.size();i++){
    Doctor d = allDocs.get(i);
    String safeName = d.getFullName() != null
                      ? d.getFullName().replace("\\","\\\\").replace("\"","\\\"") : "";
    String safeQual = d.getQualification() != null
                      ? d.getQualification().replace("\\","\\\\").replace("\"","\\\"") : "";
    String safeSpec = d.getSpec() != null
                      ? d.getSpec().replace("\\","\\\\").replace("\"","\\\"") : "";
    docJson.append("{")
           .append("\"id\":").append(d.getId()).append(",")
           .append("\"name\":\"").append(safeName).append("\",")
           .append("\"spec\":\"").append(safeSpec).append("\",")
           .append("\"qual\":\"").append(safeQual).append("\"")
           .append("}");
    if(i < allDocs.size()-1) docJson.append(",");
  }
  docJson.append("]");
%>

<div class="container py-5">
  <div class="row justify-content-center">
    <div class="col-lg-8">

      <div class="text-center mb-4">
        <h2 class="fw-700" style="color:#019ADE;">
          <i class="fa-solid fa-calendar-plus me-2"></i>Book an Appointment
        </h2>
        <p class="text-muted">Fill in the details below to schedule your consultation</p>
      </div>

      <c:if test="${not empty succMsg}">
        <div class="alert alert-success rounded-3">
          <i class="fa-solid fa-circle-check me-2"></i>${succMsg}
        </div>
        <c:remove var="succMsg" scope="session"/>
      </c:if>
      <c:if test="${not empty errorMsg}">
        <div class="alert alert-danger rounded-3">
          <i class="fa-solid fa-circle-exclamation me-2"></i>${errorMsg}
        </div>
        <c:remove var="errorMsg" scope="session"/>
      </c:if>

      <div class="card p-4 p-md-5">
        <form action="AppointmentServlet" method="post" onsubmit="return validateForm()">

          <!-- Step 1: Personal Info -->
          <h5 class="fw-700 mb-3" style="color:#019ADE;">
            <span class="badge me-2" style="background:#019ADE;">1</span>Personal Information
          </h5>
          <div class="row g-3 mb-4">
            <div class="col-md-6">
              <label class="form-label fw-600 small">Full Name *</label>
              <input type="text" name="fullname" class="form-control"
                     value="${userObj.fullname}" required>
            </div>
            <div class="col-md-6">
              <label class="form-label fw-600 small">Email *</label>
              <input type="email" name="email" class="form-control"
                     value="${userObj.email}" required>
            </div>
            <div class="col-md-4">
              <label class="form-label fw-600 small">Age *</label>
              <input type="number" name="age" class="form-control"
                     placeholder="Your age" required min="1" max="120">
            </div>
            <div class="col-md-4">
              <label class="form-label fw-600 small">Gender *</label>
              <select name="gender" class="form-select" required>
                <option value="">Select</option>
                <option>Male</option>
                <option>Female</option>
                <option>Other</option>
              </select>
            </div>
            <div class="col-md-4">
              <label class="form-label fw-600 small">Phone *</label>
              <input type="tel" name="phno" class="form-control"
                     placeholder="+91 XXXXX XXXXX" required>
            </div>
            <div class="col-12">
              <label class="form-label fw-600 small">Address</label>
              <input type="text" name="address" class="form-control"
                     placeholder="Your address">
            </div>
          </div>

          <hr>

          <!-- Step 2: Medical -->
          <h5 class="fw-700 mb-3" style="color:#019ADE;">
            <span class="badge me-2" style="background:#019ADE;">2</span>Medical Details
          </h5>
          <div class="row g-3 mb-4">
            <div class="col-12">
              <label class="form-label fw-600 small">Symptoms / Diseases *</label>
              <textarea name="diseases" class="form-control" rows="3"
                        placeholder="Describe your symptoms..." required></textarea>
            </div>
            <div class="col-12">
              <label class="form-label fw-600 small">Priority Level *</label>
              <div class="row g-2">
                <div class="col-4">
                  <div class="priority-btn selected-normal" id="normalBtn"
                       onclick="setPriority('Normal')">
                    <i class="fa-solid fa-circle-check fa-lg mb-1"
                       style="color:#4caf50;"></i>
                    <div class="fw-600 small">Normal</div>
                    <div style="font-size:.72rem;color:#888;">Regular visit</div>
                  </div>
                </div>
                <div class="col-4">
                  <div class="priority-btn" id="urgentBtn"
                       onclick="setPriority('Urgent')">
                    <i class="fa-solid fa-triangle-exclamation fa-lg mb-1"
                       style="color:#ff9800;"></i>
                    <div class="fw-600 small">Urgent</div>
                    <div style="font-size:.72rem;color:#888;">Needs attention soon</div>
                  </div>
                </div>
                <div class="col-4">
                  <div class="priority-btn" id="emergencyBtn"
                       onclick="setPriority('Emergency')">
                    <i class="fa-solid fa-circle-radiation fa-lg mb-1"
                       style="color:#f44336;"></i>
                    <div class="fw-600 small">Emergency</div>
                    <div style="font-size:.72rem;color:#888;">Immediate care</div>
                  </div>
                </div>
              </div>
              <input type="hidden" name="priority" id="priorityInput" value="Normal">
            </div>
          </div>

          <hr>

          <!-- Step 3: Specialist + Doctor -->
          <h5 class="fw-700 mb-3" style="color:#019ADE;">
            <span class="badge me-2" style="background:#019ADE;">3</span>Choose Specialist &amp; Doctor
          </h5>
          <div class="row g-3 mb-4">
            <div class="col-md-6">
              <label class="form-label fw-600 small">Specialist *</label>
              <%-- ── FIX 2: name="specialist" is display-only,
                           doctorId carries the real value to servlet --%>
              <select id="specialistSelect" class="form-select"
                      onchange="filterDoctors(this.value)" required>
                <option value="">-- Select Specialist --</option>
                <% for(Specialist sp : specs){ %>
                <option value="<%=sp.getSpecName()%>"><%=sp.getSpecName()%></option>
                <% } %>
              </select>
            </div>
            <div class="col-md-6">
              <label class="form-label fw-600 small">Doctor *</label>
              <%-- ── FIX 2 + FIX 3: name="doctorId" — servlet reads this --%>
              <select name="doctorId" id="doctorSelect" class="form-select" required>
                <option value="">-- Select Specialist First --</option>
              </select>
              <div id="doctorHelp" class="form-text text-danger d-none">
                Please select a doctor.
              </div>
            </div>
          </div>

          <hr>

          <!-- Step 4: Date & Time -->
          <h5 class="fw-700 mb-3" style="color:#019ADE;">
            <span class="badge me-2" style="background:#019ADE;">4</span>Date &amp; Time
          </h5>
          <div class="row g-3 mb-4">
            <div class="col-md-6">
              <label class="form-label fw-600 small">Appointment Date *</label>
              <input type="date" name="appointmentDate" class="form-control" required
                     min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>">
            </div>
            <div class="col-md-6">
              <label class="form-label fw-600 small">Preferred Time *</label>
              <select name="appointmentTime" class="form-select" required>
                <option value="09:00">09:00 AM</option>
                <option value="09:30">09:30 AM</option>
                <option value="10:00">10:00 AM</option>
                <option value="10:30">10:30 AM</option>
                <option value="11:00">11:00 AM</option>
                <option value="11:30">11:30 AM</option>
                <option value="14:00">02:00 PM</option>
                <option value="14:30">02:30 PM</option>
                <option value="15:00">03:00 PM</option>
                <option value="15:30">03:30 PM</option>
                <option value="16:00">04:00 PM</option>
                <option value="16:30">04:30 PM</option>
                <option value="17:00">05:00 PM</option>
              </select>
            </div>
          </div>

          <button type="submit" class="btn-primary-custom btn w-100 py-3 fw-700 mt-2">
            <i class="fa-solid fa-calendar-check me-2"></i>Confirm Appointment
          </button>
        </form>
      </div><!-- /card -->
    </div>
  </div>
</div>

<%@include file="component/footer.jsp"%>

<script>
/*
 * ── FIX 2: Doctor JSON is written by the server (safe, correct names).
 *    filterDoctors() reads it and populates the select with real names.
 *    The option value is the doctor's numeric id — that's what the
 *    servlet receives as "doctorId".
 */
var ALL_DOCTORS = <%=docJson.toString()%>;

function filterDoctors(spec) {
  var sel = document.getElementById('doctorSelect');
  sel.innerHTML = '';                         // clear previous options

  if (!spec) {
    sel.innerHTML = '<option value="">-- Select Specialist First --</option>';
    return;
  }

  var matches = ALL_DOCTORS.filter(function(d){ return d.spec === spec; });

  if (matches.length === 0) {
    sel.innerHTML = '<option value="">No doctors available for this specialist</option>';
    return;
  }

  // first blank/placeholder option
  var blank = document.createElement('option');
  blank.value = '';
  blank.text  = '-- Select Doctor --';
  sel.appendChild(blank);

  matches.forEach(function(d){
    var opt = document.createElement('option');
    opt.value = d.id;                         // numeric id → servlet
    // ── FIX 2: "Dr. <fullName> (<qualification>)" — correct field names
    opt.text  = 'Dr. ' + d.name + (d.qual ? ' (' + d.qual + ')' : '');
    sel.appendChild(opt);
  });
}

function setPriority(level) {
  document.getElementById('priorityInput').value = level;
  ['normalBtn','urgentBtn','emergencyBtn'].forEach(function(id){
    document.getElementById(id).className = 'priority-btn';
  });
  var map = {Normal:'selected-normal', Urgent:'selected-urgent', Emergency:'selected-emergency'};
  var idMap = {Normal:'normalBtn', Urgent:'urgentBtn', Emergency:'emergencyBtn'};
  document.getElementById(idMap[level]).classList.add(map[level]);
}

/* ── FIX 3: client-side guard: block submit if no doctor chosen */
function validateForm() {
  var sel = document.getElementById('doctorSelect');
  if (!sel.value) {
    sel.classList.add('is-invalid');
    document.getElementById('doctorHelp').classList.remove('d-none');
    sel.scrollIntoView({behavior:'smooth', block:'center'});
    return false;   // prevent form submission
  }
  return true;
}

// initialise priority highlight
setPriority('Normal');
</script>
</body>
</html>
