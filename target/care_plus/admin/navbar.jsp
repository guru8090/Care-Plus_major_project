<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<nav class="navbar navbar-expand-lg sticky-top" style="background:linear-gradient(90deg,#0f3460,#019ADE);box-shadow:0 2px 20px rgba(0,0,0,0.25);">
  <div class="container-fluid px-4">
    <div class="d-flex align-items-center gap-2">
      <div style="width:42px;height:42px;background:rgba(255,255,255,0.15);border-radius:50%;display:flex;align-items:center;justify-content:center;">
        <i class="fa-solid fa-heart-pulse text-white"></i>
      </div>
      <a class="navbar-brand fw-bold text-white" href="../index.jsp" style="font-size:1.3rem;letter-spacing:1px;">
        Care <span style="color:#ffe066;">+</span>
        <span style="font-size:.7rem;opacity:.7;margin-left:6px;">ADMIN</span>
      </a>
    </div>
    <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#adminNav">
      <i class="fa-solid fa-bars text-white"></i>
    </button>
    <div class="collapse navbar-collapse" id="adminNav">
      <ul class="navbar-nav mx-auto align-items-center gap-1">
        <li class="nav-item">
          <a class="nav-link px-3 py-2 rounded-pill text-white fw-500" href="index.jsp">
            <i class="fa-solid fa-gauge me-1"></i>DASHBOARD
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link px-3 py-2 rounded-pill text-white fw-500" href="doctor.jsp">
            <i class="fa-solid fa-user-doctor me-1"></i>ADD DOCTOR
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link px-3 py-2 rounded-pill text-white fw-500" href="view_doctor.jsp">
            <i class="fa-solid fa-list me-1"></i>VIEW DOCTORS
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link px-3 py-2 rounded-pill text-white fw-500" href="patientInAdmin.jsp">
            <i class="fa-solid fa-users me-1"></i>PATIENTS
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link px-3 py-2 rounded-pill text-white fw-500" href="all_appointments.jsp">
            <i class="fa-solid fa-calendar-alt me-1"></i>APPOINTMENTS
          </a>
        </li>
      </ul>
      <ul class="navbar-nav ms-auto">
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle d-flex align-items-center gap-2 px-3 py-2 rounded-pill"
             href="#" role="button" data-bs-toggle="dropdown"
             style="background:rgba(255,255,255,0.15);color:#fff;">
            <div style="width:32px;height:32px;background:#ffe066;border-radius:50%;display:flex;align-items:center;justify-content:center;">
              <i class="fa-solid fa-user-shield" style="color:#019ADE;font-size:.85rem;"></i>
            </div>
            ADMIN
          </a>
          <ul class="dropdown-menu dropdown-menu-end rounded-3 shadow border-0">
            <li><a class="dropdown-item py-2 text-danger" href="../adminLogout"><i class="fa-solid fa-right-from-bracket me-2"></i>Logout</a></li>
          </ul>
        </li>
      </ul>
    </div>
  </div>
</nav>
