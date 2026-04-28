<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<nav class="navbar navbar-expand-lg sticky-top" style="background:linear-gradient(90deg,#019ADE,#00a8c6);box-shadow:0 2px 20px rgba(1,154,222,0.25);">
  <div class="container">
    <div class="d-flex align-items-center">
      <div class="navbar-brand-logo me-2" style="width:42px;height:42px;background:rgba(255,255,255,0.2);border-radius:50%;display:flex;align-items:center;justify-content:center;">
        <i class="fa-solid fa-heart-pulse" style="color:#fff;font-size:1.2rem;"></i>
      </div>
      <a class="navbar-brand fw-bold" href="index.jsp" style="color:#fff;font-size:1.4rem;letter-spacing:1px;">
        Care <span style="color:#ffe066;">+</span>
      </a>
    </div>
    <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" style="color:#fff;">
      <i class="fa-solid fa-bars" style="color:#fff;"></i>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto align-items-center gap-1">

        <c:if test="${empty userObj}">
          <li class="nav-item">
            <a class="nav-link px-3 py-2 rounded-pill text-white fw-500" href="index.jsp">
              <i class="fa-solid fa-house me-1"></i>HOME
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link px-3 py-2 rounded-pill text-white fw-500" href="admin_login.jsp">
              <i class="fa-solid fa-shield-halved me-1"></i>ADMIN
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link px-3 py-2 rounded-pill text-white fw-500" href="doctor_login.jsp">
              <i class="fa-solid fa-user-doctor me-1"></i>DOCTOR
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link px-3 py-2 rounded-pill text-white fw-500" href="user_appointment.jsp">
              <i class="fa-solid fa-calendar-check me-1"></i>APPOINTMENT
            </a>
          </li>
          <li class="nav-item ms-2">
            <a class="btn btn-light fw-600 rounded-pill px-4" href="user_login.jsp" style="color:#019ADE;">
              <i class="fa-solid fa-right-to-bracket me-1"></i>LOGIN
            </a>
          </li>
        </c:if>

        <c:if test="${not empty userObj}">
          <li class="nav-item">
            <a class="nav-link px-3 py-2 rounded-pill text-white fw-500" href="index.jsp">
              <i class="fa-solid fa-house me-1"></i>HOME
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link px-3 py-2 rounded-pill text-white fw-500" href="user_appointment.jsp">
              <i class="fa-solid fa-calendar-plus me-1"></i>BOOK
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link px-3 py-2 rounded-pill text-white fw-500" href="view_appointment.jsp">
              <i class="fa-solid fa-list-check me-1"></i>MY APPOINTMENTS
            </a>
          </li>
          <li class="nav-item dropdown ms-2">
            <a class="nav-link dropdown-toggle d-flex align-items-center gap-2 px-3 py-2 rounded-pill"
               href="#" role="button" data-bs-toggle="dropdown"
               style="background:rgba(255,255,255,0.2);color:#fff;">
              <div style="width:32px;height:32px;background:#ffe066;border-radius:50%;display:flex;align-items:center;justify-content:center;">
                <i class="fa-solid fa-user" style="color:#019ADE;font-size:.85rem;"></i>
              </div>
              <span>${userObj.fullname}</span>
            </a>
            <ul class="dropdown-menu dropdown-menu-end rounded-3 shadow border-0" style="min-width:200px;">
              <li><h6 class="dropdown-header text-primary">My Account</h6></li>
              <li><a class="dropdown-item py-2" href="change_password.jsp"><i class="fa-solid fa-key me-2 text-primary"></i>Change Password</a></li>
              <li><hr class="dropdown-divider"></li>
              <li><a class="dropdown-item py-2 text-danger" href="UserLogout"><i class="fa-solid fa-right-from-bracket me-2"></i>Logout</a></li>
            </ul>
          </li>
        </c:if>

      </ul>
    </div>
  </div>
</nav>
