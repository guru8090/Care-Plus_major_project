<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ page import="com.dao.AppointmentDao,com.Db.DBConnection,com.entity.Appointment,com.entity.Doctor,java.util.List" %>
<c:if test="${empty doctorObj}"><c:redirect url="../doctor_login.jsp"/></c:if>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>Care+ | My Patients</title>
<%@include file="../component/allcss.jsp"%>
<style>
body{background:#f4f8fb;}
.table th{font-size:.82rem;color:#888;font-weight:600;border:none;background:#f8f9fa;}
.table td{font-size:.85rem;vertical-align:middle;}
.form-control,.form-select{border-radius:10px;border:2px solid #e9ecef;font-family:'Poppins',sans-serif;padding:8px 12px;}
.form-control:focus,.form-select:focus{border-color:#019ADE;box-shadow:none;}

/* ── FIX 1: modal flicker fix ─────────────────────────────────────
   Root cause: Bootstrap modal uses display:none <-> display:block
   toggling which forces layout reflow every frame when CSS transitions
   fight each other. We disable the built-in fade on the backdrop
   and force GPU compositing on the dialog so no repaint occurs.      */
.modal-dialog{transform:translateZ(0);will-change:transform;}
.modal.fade .modal-dialog{transition:none !important;}
.modal-backdrop{transition:none !important;}
.modal{overflow-y:auto !important;}          /* prevent scroll-lock flicker */
</style>
</head>
<body>
<%@include file="navbar.jsp"%>

<%
  Doctor docObj = (Doctor) session.getAttribute("doctorObj");
  AppointmentDao aDao = new AppointmentDao(DBConnection.getConnection());
  List<Appointment> aps = aDao.getAllAppointmentByDoctor(docObj.getId());
%>

<div class="container-fluid px-4 py-4">
  <div class="d-flex align-items-center justify-content-between mb-4 flex-wrap gap-2">
    <div>
      <h4 class="fw-800 mb-0">My Patients</h4>
      <p class="text-muted small mb-0">Total: <%=aps.size()%> appointments</p>
    </div>
  </div>

  <c:if test="${not empty succMsg}">
    <div class="alert alert-success rounded-3 py-2"><i class="fa-solid fa-circle-check me-2"></i>${succMsg}</div>
    <c:remove var="succMsg" scope="session"/>
  </c:if>
  <c:if test="${not empty errorMsg}">
    <div class="alert alert-danger rounded-3 py-2"><i class="fa-solid fa-circle-exclamation me-2"></i>${errorMsg}</div>
    <c:remove var="errorMsg" scope="session"/>
  </c:if>

  <% if(aps.isEmpty()){ %>
  <div class="card p-5 text-center">
    <i class="fa-solid fa-users fa-3x text-muted mb-3"></i>
    <h5 class="text-muted">No patients assigned yet</h5>
  </div>
  <% } else { %>

  <div class="card">
    <div class="card-body p-0">
      <div class="table-responsive">
        <table class="table table-hover mb-0">
          <thead>
            <tr>
              <th class="ps-4">#</th>
              <th>Patient</th>
              <th>Age / Gender</th>
              <th>Date &amp; Time</th>
              <th>Disease</th>
              <th>Priority</th>
              <th>Status</th>
              <th>Action</th>
            </tr>
          </thead>
          <tbody>
          <% int sn = 1;
             for(Appointment ap : aps){ %>
          <tr>
            <td class="ps-4 text-muted fw-600"><%=sn++%></td>
            <td>
              <div class="fw-600"><%=ap.getFullName()%></div>
              <div class="text-muted" style="font-size:.75rem;"><%=ap.getEmail()%></div>
            </td>
            <td><span class="text-muted"><%=ap.getAge()%> yrs, <%=ap.getGender()%></span></td>
            <td>
              <div class="fw-600" style="font-size:.85rem;"><%=ap.getAppointmentDate()%></div>
              <div class="text-muted" style="font-size:.75rem;">
                <%=ap.getAppointmentTime()!=null?ap.getAppointmentTime():""%>
              </div>
            </td>
            <td style="max-width:130px;" title="<%=ap.getDiseases()%>">
              <%=ap.getDiseases()!=null && ap.getDiseases().length()>22
                  ? ap.getDiseases().substring(0,22)+"..." : ap.getDiseases()%>
            </td>
            <td>
              <% String pri = ap.getPriority()!=null?ap.getPriority():"Normal";
                 String priColor = "Emergency".equals(pri)?"#f44336":"Urgent".equals(pri)?"#ff9800":"#4caf50"; %>
              <span style="font-size:.8rem;font-weight:700;color:<%=priColor%>;"><%=pri%></span>
            </td>
            <td>
              <% String st = ap.getStatus();
                 String stBg  = "Pending".equals(st)?"#fff3cd":"Confirmed".equals(st)?"#d1e7dd":"Completed".equals(st)?"#cfe2ff":"#f8d7da";
                 String stCol = "Pending".equals(st)?"#856404":"Confirmed".equals(st)?"#0f5132":"Completed".equals(st)?"#084298":"#842029"; %>
              <span class="badge rounded-pill px-3 py-2"
                    style="background:<%=stBg%>;color:<%=stCol%>;"><%=st%></span>
            </td>
            <td>
              <%-- Trigger button — sets data attrs, no href, no page reload --%>
              <button type="button"
                      class="btn btn-sm"
                      style="background:#e8f6fd;color:#019ADE;border-radius:8px;font-size:.78rem;"
                      data-bs-toggle="modal"
                      data-bs-target="#updateModal"
                      data-apid="<%=ap.getId()%>"
                      data-name="<%=ap.getFullName().replace("\"","&quot;")%>"
                      data-date="<%=ap.getAppointmentDate()%>"
                      data-time="<%=ap.getAppointmentTime()!=null?ap.getAppointmentTime():""%>"
                      data-disease="<%=ap.getDiseases()!=null?ap.getDiseases().replace("\"","&quot;"):""%>"
                      data-status="<%=ap.getStatus()%>"
                      data-notes="<%=ap.getNotes()!=null?ap.getNotes().replace("\"","&quot;").replace("\n"," "):""%>">
                <i class="fa-solid fa-pen me-1"></i>Update
              </button>
            </td>
          </tr>
          <% } %>
          </tbody>
        </table>
      </div>
    </div>
  </div>
  <% } %>
</div>

<%-- ── FIX 1: ONE shared modal (not one per row) ──────────────────────
     Having N modals in the DOM each with their own Bootstrap JS instance
     causes rapid show/hide conflicts → flicker.
     Solution: single modal, populate via JS on 'show.bs.modal' event.  --%>
<div class="modal fade" id="updateModal" tabindex="-1" aria-labelledby="updateModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content rounded-4 border-0 shadow">
      <div class="modal-header border-0"
           style="background:linear-gradient(135deg,#019ADE,#00d4aa);border-radius:16px 16px 0 0;">
        <h5 class="modal-title text-white fw-700" id="updateModalLabel">
          <i class="fa-solid fa-clipboard-user me-2"></i>
          Update — <span id="modalPatientName"></span>
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body p-4">
        <div id="modalInfoBox"
             class="alert mb-3"
             style="background:#f0f8ff;border:1px solid #cce9f9;border-radius:12px;font-size:.85rem;">
        </div>
        <form action="../UpdateStatus" method="post">
          <input type="hidden" name="apId" id="modalApId">
          <div class="mb-3">
            <label class="form-label fw-600 small">Update Status</label>
            <select name="status" id="modalStatus" class="form-select">
              <option value="Pending">Pending</option>
              <option value="Confirmed">Confirmed</option>
              <option value="Completed">Completed</option>
              <option value="Cancelled">Cancelled</option>
            </select>
          </div>
          <div class="mb-3">
            <label class="form-label fw-600 small">Doctor Notes / Prescription</label>
            <textarea name="notes" id="modalNotes" class="form-control" rows="3"
                      placeholder="Add notes, prescription, or advice..."></textarea>
          </div>
          <button type="submit" class="btn btn-primary-custom w-100 py-2 fw-700">
            <i class="fa-solid fa-floppy-disk me-2"></i>Save Changes
          </button>
        </form>
      </div>
    </div>
  </div>
</div>

<script>
/* Populate single modal with row data — no per-row Bootstrap instances */
document.getElementById('updateModal').addEventListener('show.bs.modal', function(event){
  var btn = event.relatedTarget;
  document.getElementById('modalApId').value        = btn.getAttribute('data-apid');
  document.getElementById('modalPatientName').textContent = btn.getAttribute('data-name');
  document.getElementById('modalNotes').value       = btn.getAttribute('data-notes');

  var sel = document.getElementById('modalStatus');
  sel.value = btn.getAttribute('data-status');

  document.getElementById('modalInfoBox').innerHTML =
    '<strong>Symptoms:</strong> ' + btn.getAttribute('data-disease') +
    '<br><strong>Date:</strong> ' + btn.getAttribute('data-date') +
    (btn.getAttribute('data-time') ? ' at ' + btn.getAttribute('data-time') : '');
});
</script>

</body>
</html>
