<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ page import="com.dao.DoctorDao,com.dao.SpecialistDao,com.Db.DBConnection,com.entity.Doctor,com.entity.Specialist,java.util.List" %>
<c:if test="${empty adminObj}"><c:redirect url="../admin_login.jsp"/></c:if>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>Care+ | View Doctors</title>
<%@include file="../component/allcss.jsp"%>
<style>
body{background:#f4f8fb;}
.table th{font-size:.82rem;color:#888;font-weight:600;border:none;background:#f8f9fa;}
.table td{font-size:.85rem;vertical-align:middle;}
.form-control,.form-select{border-radius:10px;border:2px solid #e9ecef;padding:8px 12px;font-family:'Poppins',sans-serif;}
.form-control:focus,.form-select:focus{border-color:#019ADE;box-shadow:none;}
/* Fix flicker: single modal, no per-row instances */
.modal-dialog{transform:translateZ(0);will-change:transform;}
.modal.fade .modal-dialog{transition:none !important;}
.modal-backdrop{transition:none !important;}
.modal{overflow-y:auto !important;}
</style>
</head>
<body>
<%@include file="navbar.jsp"%>

<%
  DoctorDao dDao = new DoctorDao(DBConnection.getConnection());
  SpecialistDao sDao = new SpecialistDao(DBConnection.getConnection());
  List<Doctor> doctors = dDao.getAllDoctor();
  List<Specialist> specs = sDao.getAllSpecialist();

  // Build specialist options HTML once — reused in the single modal
  StringBuilder specOptions = new StringBuilder();
  for(Specialist sp : specs){
    specOptions.append("<option value=\"")
               .append(sp.getSpecName()).append("\">")
               .append(sp.getSpecName()).append("</option>");
  }
%>

<div class="container-fluid px-4 py-4">
  <div class="d-flex align-items-center justify-content-between mb-4 flex-wrap gap-2">
    <div>
      <h4 class="fw-800 mb-0">All Doctors</h4>
      <p class="text-muted small mb-0"><%=doctors.size()%> doctors registered</p>
    </div>
    <a href="doctor.jsp" class="btn btn-primary-custom">
      <i class="fa-solid fa-user-plus me-2"></i>Add Doctor
    </a>
  </div>

  <c:if test="${not empty succMag}">
    <div class="alert alert-success rounded-3 py-2">${succMag}</div>
    <c:remove var="succMag" scope="session"/>
  </c:if>
  <c:if test="${not empty errorMsg}">
    <div class="alert alert-danger rounded-3 py-2">${errorMsg}</div>
    <c:remove var="errorMsg" scope="session"/>
  </c:if>

  <div class="card">
    <div class="card-body p-0">
      <div class="table-responsive">
        <table class="table table-hover mb-0">
          <thead>
            <tr>
              <th class="ps-4">#</th>
              <th>Name</th>
              <th>Specialist</th>
              <th>Qualification</th>
              <th>Mobile</th>
              <th>Experience</th>
              <th>Fee</th>
              <th>Status</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
          <% int sn=1; for(Doctor d : doctors){ %>
          <tr>
            <td class="ps-4 text-muted fw-600"><%=sn++%></td>
            <td>
              <div class="d-flex align-items-center gap-2">
                <div style="width:38px;height:38px;border-radius:50%;background:linear-gradient(135deg,#019ADE,#00d4aa);display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                  <i class="fa-solid fa-user-doctor text-white" style="font-size:.85rem;"></i>
                </div>
                <div>
                  <div class="fw-600">Dr. <%=d.getFullName()%></div>
                  <div class="text-muted" style="font-size:.75rem;"><%=d.getEmail()%></div>
                </div>
              </div>
            </td>
            <td>
              <span class="badge" style="background:#e8f6fd;color:#019ADE;border-radius:20px;padding:5px 12px;">
                <%=d.getSpec()%>
              </span>
            </td>
            <td><%=d.getQualification()%></td>
            <td><%=d.getMobno()%></td>
            <td><%=d.getExperience()!=null?d.getExperience()+"y":"—"%></td>
            <td><%=d.getConsultationFee()!=null?"₹"+d.getConsultationFee():"—"%></td>
            <td>
              <span class="badge" style="background:<%="Active".equals(d.getStatus())?"#d1e7dd":"#f8d7da"%>;color:<%="Active".equals(d.getStatus())?"#0f5132":"#842029"%>;border-radius:20px;">
                <%=d.getStatus()!=null?d.getStatus():"Active"%>
              </span>
            </td>
            <td>
              <%-- Edit button: stores all data as data-* attributes, opens ONE shared modal --%>
              <button type="button"
                      class="btn btn-sm me-1"
                      style="background:#fff3e0;color:#ff9800;border-radius:8px;"
                      data-bs-toggle="modal"
                      data-bs-target="#editDoctorModal"
                      data-id="<%=d.getId()%>"
                      data-name="<%=d.getFullName().replace("\"","&quot;")%>"
                      data-dob="<%=d.getDob()!=null?d.getDob():""%>"
                      data-qual="<%=d.getQualification().replace("\"","&quot;")%>"
                      data-email="<%=d.getEmail()%>"
                      data-spec="<%=d.getSpec()%>"
                      data-mobno="<%=d.getMobno()%>"
                      data-password="<%=d.getPassword()%>"
                      data-status="<%=d.getStatus()!=null?d.getStatus():"Active"%>"
                      data-exp="<%=d.getExperience()!=null?d.getExperience():""%>"
                      data-fee="<%=d.getConsultationFee()!=null?d.getConsultationFee():""%>"
                      data-avail="<%=d.getAvailability()!=null?d.getAvailability().replace("\"","&quot;"):""%>"
                      data-bio="<%=d.getBio()!=null?d.getBio().replace("\"","&quot;").replace("\n"," "):""%>">
                <i class="fa-solid fa-pen"></i>
              </button>
              <a href="../DeleteDoctor?id=<%=d.getId()%>"
                 class="btn btn-sm"
                 style="background:#ffebee;color:#f44336;border-radius:8px;"
                 onclick="return confirm('Delete Dr. <%=d.getFullName()%>? This cannot be undone.')">
                <i class="fa-solid fa-trash"></i>
              </a>
            </td>
          </tr>
          <% } %>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>

<%-- ONE shared edit modal — populated via JS on show.bs.modal event --%>
<div class="modal fade" id="editDoctorModal" tabindex="-1" aria-labelledby="editDoctorModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content rounded-4 border-0 shadow">
      <div class="modal-header border-0 pb-0">
        <h5 class="modal-title fw-700" id="editDoctorModalLabel">
          <i class="fa-solid fa-user-pen me-2" style="color:#019ADE;"></i>
          Edit Doctor — <span id="modalDoctorName"></span>
        </h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body p-4">
        <form action="../UpdateDoctor" method="post">
          <input type="hidden" name="id" id="editId">
          <div class="row g-3">
            <div class="col-md-6">
              <label class="form-label fw-600 small">Full Name</label>
              <input type="text" name="fullname" id="editName" class="form-control" required>
            </div>
            <div class="col-md-6">
              <label class="form-label fw-600 small">Email</label>
              <input type="email" name="email" id="editEmail" class="form-control" required>
            </div>
            <div class="col-md-6">
              <label class="form-label fw-600 small">Date of Birth</label>
              <input type="date" name="dob" id="editDob" class="form-control">
            </div>
            <div class="col-md-6">
              <label class="form-label fw-600 small">Mobile</label>
              <input type="tel" name="mobno" id="editMobno" class="form-control">
            </div>
            <div class="col-md-6">
              <label class="form-label fw-600 small">Qualification</label>
              <input type="text" name="qualification" id="editQual" class="form-control">
            </div>
            <div class="col-md-6">
              <label class="form-label fw-600 small">Specialist</label>
              <select name="specialist" id="editSpec" class="form-select">
                <%=specOptions.toString()%>
              </select>
            </div>
            <div class="col-md-4">
              <label class="form-label fw-600 small">Password</label>
              <input type="text" name="password" id="editPassword" class="form-control">
            </div>
            <div class="col-md-4">
              <label class="form-label fw-600 small">Experience (yrs)</label>
              <input type="number" name="experience" id="editExp" class="form-control">
            </div>
            <div class="col-md-4">
              <label class="form-label fw-600 small">Fee (₹)</label>
              <input type="number" name="consultationFee" id="editFee" class="form-control">
            </div>
            <div class="col-md-6">
              <label class="form-label fw-600 small">Status</label>
              <select name="status" id="editStatus" class="form-select">
                <option value="Active">Active</option>
                <option value="Inactive">Inactive</option>
              </select>
            </div>
            <div class="col-md-6">
              <label class="form-label fw-600 small">Availability</label>
              <input type="text" name="availability" id="editAvail" class="form-control" placeholder="e.g. Mon-Sat">
            </div>
            <div class="col-12">
              <label class="form-label fw-600 small">Bio</label>
              <textarea name="bio" id="editBio" class="form-control" rows="2"></textarea>
            </div>
            <div class="col-12">
              <button type="submit" class="btn btn-primary-custom w-100 py-2 fw-700">
                <i class="fa-solid fa-floppy-disk me-2"></i>Update Doctor
              </button>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>

<script>
/* Populate the single shared modal from data-* attributes on the clicked button.
   This fires BEFORE the modal becomes visible so there is no flicker.          */
document.getElementById('editDoctorModal').addEventListener('show.bs.modal', function(event) {
  var btn = event.relatedTarget;

  document.getElementById('editId').value           = btn.getAttribute('data-id');
  document.getElementById('editName').value         = btn.getAttribute('data-name');
  document.getElementById('editEmail').value        = btn.getAttribute('data-email');
  document.getElementById('editDob').value          = btn.getAttribute('data-dob');
  document.getElementById('editMobno').value        = btn.getAttribute('data-mobno');
  document.getElementById('editQual').value         = btn.getAttribute('data-qual');
  document.getElementById('editPassword').value     = btn.getAttribute('data-password');
  document.getElementById('editExp').value          = btn.getAttribute('data-exp');
  document.getElementById('editFee').value          = btn.getAttribute('data-fee');
  document.getElementById('editAvail').value        = btn.getAttribute('data-avail');
  document.getElementById('editBio').value          = btn.getAttribute('data-bio');
  document.getElementById('editStatus').value       = btn.getAttribute('data-status');
  document.getElementById('modalDoctorName').textContent = btn.getAttribute('data-name');

  // Set specialist dropdown to correct value
  var specSel = document.getElementById('editSpec');
  var specVal = btn.getAttribute('data-spec');
  for (var i = 0; i < specSel.options.length; i++) {
    if (specSel.options[i].value === specVal) {
      specSel.selectedIndex = i;
      break;
    }
  }
});
</script>

</body>
</html>