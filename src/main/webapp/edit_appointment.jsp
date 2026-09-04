<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="WEB-INF/jspf/header.jspf" %>

<style>
    .edit-card {
        border: 1px solid #e2e8f0;
        border-radius: 20px;
        background: #ffffff;
        box-shadow: 0 12px 32px rgba(10, 37, 64, 0.05);
        overflow: hidden;
    }

    .edit-card-header {
        background: #f8fafc;
        border-bottom: 1px solid #e2e8f0;
        padding: 1.25rem 1.75rem;
    }

    .appt-no-badge {
        font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, monospace;
        font-weight: 700;
        color: #0369a1;
        background: #f0f9ff;
        padding: 0.35rem 0.75rem;
        border-radius: 8px;
        border: 1px solid #bae6fd;
        font-size: 0.9rem;
    }

    .patient-info-box {
        background-color: #f8fafc;
        border: 1px solid #e2e8f0;
        border-radius: 14px;
        padding: 1.25rem;
    }

    .form-label {
        font-weight: 600;
        font-size: 0.85rem;
        color: #475569;
        margin-bottom: 0.4rem;
    }

    .form-control, .form-select {
        border-color: #cbd5e1;
        padding: 0.7rem 0.9rem;
        border-radius: 10px;
        font-size: 0.95rem;
    }

    .form-control:focus, .form-select:focus {
        border-color: #0284c7;
        box-shadow: 0 0 0 4px rgba(2, 132, 199, 0.15);
    }

    .btn-save {
        background: linear-gradient(135deg, #0284c7 0%, #0369a1 100%);
        color: #ffffff;
        font-weight: 600;
        padding: 0.75rem 1.5rem;
        border-radius: 10px;
        border: none;
        box-shadow: 0 4px 12px rgba(2, 132, 199, 0.2);
        transition: all 0.2s ease;
    }

    .btn-save:hover {
        background: linear-gradient(135deg, #0369a1 0%, #075985 100%);
        color: #ffffff;
        transform: translateY(-1px);
        box-shadow: 0 6px 16px rgba(2, 132, 199, 0.3);
    }
</style>

<div class="row justify-content-center my-3">
    <div class="col-lg-8 col-xl-7">
        <div class="card edit-card">
            <!-- Header -->
            <div class="edit-card-header d-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center gap-2">
                    <i class="bi bi-pencil-square text-primary fs-5"></i>
                    <h5 class="fw-bold mb-0 text-dark">Edit Appointment</h5>
                </div>
                <span class="appt-no-badge">#<c:out value="${appointment.appointmentNo}"/></span>
            </div>

            <div class="card-body p-4 p-sm-5">
                <!-- Patient Context Summary -->
                <div class="patient-info-box mb-4">
                    <div class="d-flex align-items-center gap-2 text-dark fw-semibold mb-1">
                        <i class="bi bi-person-circle text-primary fs-5"></i>
                        <span><c:out value="${appointment.patientName}"/></span>
                        <span class="text-muted fs-6 font-monospace ms-auto"><i class="bi bi-telephone me-1"></i><c:out value="${appointment.contactNumber}"/></span>
                    </div>
                    <div class="small text-muted mt-2 d-flex align-items-start gap-2 pt-2 border-top">
                        <i class="bi bi-info-circle text-info fs-6"></i>
                        <span>To update patient demographics (e.g. name or contact number), register a new appointment. This form updates scheduling and treatment details only.</span>
                    </div>
                </div>

                <!-- Edit Form -->
                <form method="post" action="<%=request.getContextPath()%>/EditAppointmentServlet">
                    <input type="hidden" name="appointmentId" value="${appointment.appointmentId}">

                    <div class="row g-3 mb-4">
                        <!-- Dentist Selection -->
                        <div class="col-md-6">
                            <label class="form-label"><i class="bi bi-person-badge me-1"></i> Dentist *</label>
                            <select name="dentistId" class="form-select" required>
                                <c:forEach var="d" items="${dentists}">
                                    <option value="${d.dentistId}" ${d.dentistId == appointment.dentistId ? 'selected' : ''}>
                                        <c:out value="${d.dentistName}"/><c:if test="${!d.active}"> (Inactive)</c:if>
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <!-- Treatment Selection -->
                        <div class="col-md-6">
                            <label class="form-label"><i class="bi bi-clipboard2-pulse me-1"></i> Treatment Type *</label>
                            <select name="treatmentId" class="form-select" required>
                                <c:forEach var="t" items="${treatments}">
                                    <option value="${t.treatmentId}" ${t.treatmentId == appointment.treatmentId ? 'selected' : ''}>
                                        <c:out value="${t.treatmentName}"/> (Rs. <fmt:formatNumber value="${t.cost}" pattern="#,##0.00"/>)<c:if test="${!t.active}"> (Inactive)</c:if>
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <!-- Appointment Date -->
                        <div class="col-md-4">
                            <label class="form-label"><i class="bi bi-calendar3 me-1"></i> Date *</label>
                            <input type="date" name="appointmentDate" class="form-control" required
                                   value="<fmt:formatDate value="${appointment.appointmentDate}" pattern="yyyy-MM-dd"/>">
                        </div>

                        <!-- Appointment Time -->
                        <div class="col-md-4">
                            <label class="form-label"><i class="bi bi-clock me-1"></i> Time *</label>
                            <input type="time" name="appointmentTime" class="form-control" required
                                   value="<fmt:formatDate value="${appointment.appointmentTime}" pattern="HH:mm"/>">
                        </div>

                        <!-- Appointment Status -->
                        <div class="col-md-4">
                            <label class="form-label"><i class="bi bi-flag me-1"></i> Status *</label>
                            <select name="status" class="form-select" required>
                                <option value="SCHEDULED" ${appointment.status == 'SCHEDULED' ? 'selected' : ''}>Scheduled</option>
                                <option value="COMPLETED" ${appointment.status == 'COMPLETED' ? 'selected' : ''}>Completed</option>
                                <option value="CANCELLED" ${appointment.status == 'CANCELLED' ? 'selected' : ''}>Cancelled</option>
                            </select>
                        </div>
                    </div>

                    <!-- Action Bar -->
                    <div class="d-flex align-items-center justify-content-between pt-3 border-top">
                        <a href="<%=request.getContextPath()%>/AppointmentListServlet" class="btn btn-light border fw-semibold text-secondary px-3 py-2">
                            <i class="bi bi-x-lg me-1"></i> Cancel
                        </a>
                        <button type="submit" class="btn btn-save d-inline-flex align-items-center gap-2">
                            <i class="bi bi-check-lg"></i>
                            <span>Save Changes</span>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<%@ include file="WEB-INF/jspf/footer.jspf" %>