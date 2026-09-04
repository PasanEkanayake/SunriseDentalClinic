<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="WEB-INF/jspf/header.jspf" %>

<style>
    .register-card {
        border: 1px solid #e2e8f0;
        border-radius: 20px;
        background: #ffffff;
        box-shadow: 0 12px 32px rgba(10, 37, 64, 0.05);
        overflow: hidden;
    }

    .register-card-header {
        background: #f8fafc;
        border-bottom: 1px solid #e2e8f0;
        padding: 1.25rem 1.5rem;
    }

    .header-icon-box {
        width: 44px;
        height: 44px;
        background: linear-gradient(135deg, #e0f2fe 0%, #bae6fd 100%);
        color: #0284c7;
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .section-title-badge {
        display: inline-flex;
        align-items: center;
        gap: 0.5rem;
        background-color: #f1f5f9;
        color: #0f172a;
        font-weight: 700;
        font-size: 0.8rem;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        padding: 0.4rem 0.8rem;
        border-radius: 8px;
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

    .btn-register {
        background: linear-gradient(135deg, #0284c7 0%, #0369a1 100%);
        color: #ffffff;
        font-weight: 600;
        padding: 0.75rem 1.75rem;
        border-radius: 10px;
        border: none;
        box-shadow: 0 4px 12px rgba(2, 132, 199, 0.2);
        transition: all 0.2s ease;
    }

    .btn-register:hover {
        background: linear-gradient(135deg, #0369a1 0%, #075985 100%);
        color: #ffffff;
        transform: translateY(-1px);
        box-shadow: 0 6px 16px rgba(2, 132, 199, 0.3);
    }
</style>

<!-- Top Title Bar -->
<div class="d-flex align-items-center justify-content-between mb-4">
    <div class="d-flex align-items-center gap-3">
        <div class="header-icon-box fs-4">
            <i class="bi bi-calendar-plus-fill"></i>
        </div>
        <div>
            <h4 class="fw-bold text-dark mb-0">Register New Appointment</h4>
            <p class="text-muted small mb-0">Book a patient consultation and assign clinical resources</p>
        </div>
    </div>
    <a href="<%=request.getContextPath()%>/DashboardServlet" class="btn btn-light border fw-semibold text-secondary px-3 py-2">
        <i class="bi bi-arrow-left me-1"></i> Dashboard
    </a>
</div>

<div class="row justify-content-center">
    <div class="col-lg-8 col-xl-7">
        <div class="card register-card">
            <!-- Header -->
            <div class="register-card-header d-flex align-items-center gap-2">
                <i class="bi bi-calendar-event text-primary fs-5"></i>
                <h5 class="fw-bold text-dark mb-0">Appointment Booking Form</h5>
            </div>

            <!-- Body -->
            <div class="card-body p-4 p-sm-5">
                <form method="post" action="<%=request.getContextPath()%>/RegisterAppointmentServlet">

                    <!-- Section: Patient Details -->
                    <div class="mb-4">
                        <div class="section-title-badge mb-3">
                            <i class="bi bi-person-vcard text-primary"></i>
                            <span>Patient Details</span>
                        </div>
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label"><i class="bi bi-person me-1"></i> Patient Name *</label>
                                <input type="text" name="patientName" class="form-control" required
                                       value="${f_patientName}" placeholder="e.g. Amara Jayasuriya">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label"><i class="bi bi-telephone me-1"></i> Contact Number *</label>
                                <input type="text" name="contactNumber" class="form-control" required
                                       value="${f_contactNumber}" placeholder="e.g. 0771234567">
                            </div>
                            <div class="col-12">
                                <label class="form-label"><i class="bi bi-geo-alt me-1"></i> Address</label>
                                <input type="text" name="address" class="form-control"
                                       value="${f_address}" placeholder="e.g. 45 Galle Road, Colombo 03">
                            </div>
                        </div>
                    </div>

                    <hr class="my-4 text-border opacity-25">

                    <!-- Section: Appointment Details -->
                    <div class="mb-4">
                        <div class="section-title-badge mb-3">
                            <i class="bi bi-clock-history text-primary"></i>
                            <span>Appointment Details</span>
                        </div>
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label"><i class="bi bi-person-badge me-1"></i> Dentist *</label>
                                <select name="dentistId" class="form-select" required>
                                    <option value="">-- Select Dentist --</option>
                                    <c:forEach var="d" items="${dentists}">
                                        <option value="${d.dentistId}" ${f_dentistId == d.dentistId ? 'selected' : ''}>
                                            <c:out value="${d.dentistName}"/> <c:if test="${not empty d.specialization}">(<c:out value="${d.specialization}"/>)</c:if>
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label"><i class="bi bi-clipboard2-pulse me-1"></i> Treatment Type *</label>
                                <select name="treatmentId" class="form-select" required>
                                    <option value="">-- Select Treatment --</option>
                                    <c:forEach var="t" items="${treatments}">
                                        <option value="${t.treatmentId}" ${f_treatmentId == t.treatmentId ? 'selected' : ''}>
                                            <c:out value="${t.treatmentName}"/> (Rs. <fmt:formatNumber value="${t.cost}" pattern="#,##0.00"/>)
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label"><i class="bi bi-calendar3 me-1"></i> Appointment Date *</label>
                                <input type="date" name="appointmentDate" class="form-control" required value="${f_date}">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label"><i class="bi bi-clock me-1"></i> Appointment Time *</label>
                                <input type="time" name="appointmentTime" class="form-control" required value="${f_time}">
                            </div>
                        </div>
                    </div>

                    <!-- Footer Action Buttons -->
                    <div class="d-flex align-items-center justify-content-between pt-3 border-top mt-4">
                        <a href="<%=request.getContextPath()%>/DashboardServlet" class="btn btn-light border fw-semibold text-secondary px-4 py-2">
                            Cancel
                        </a>
                        <button type="submit" class="btn btn-register d-inline-flex align-items-center gap-2">
                            <i class="bi bi-check-lg"></i>
                            <span>Register Appointment</span>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<%@ include file="WEB-INF/jspf/footer.jspf" %>