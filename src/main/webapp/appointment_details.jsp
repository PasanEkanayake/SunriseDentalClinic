<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="WEB-INF/jspf/header.jspf" %>

<style>
    .details-card {
        border: 1px solid #e2e8f0;
        border-radius: 20px;
        background: #ffffff;
        box-shadow: 0 12px 32px rgba(10, 37, 64, 0.05);
        overflow: hidden;
    }

    .details-card-header {
        background: #f8fafc;
        border-bottom: 1px solid #e2e8f0;
        padding: 1.25rem 1.75rem;
    }

    .appt-number-banner {
        background: linear-gradient(135deg, #f0f9ff 0%, #e0f2fe 100%);
        border: 1px solid #bae6fd;
        border-radius: 14px;
        padding: 1.25rem;
    }

    .appt-number-highlight {
        font-size: 2rem;
        font-weight: 800;
        color: #0369a1;
        letter-spacing: -0.5px;
    }

    .info-section-card {
        background: #f8fafc;
        border: 1px solid #e2e8f0;
        border-radius: 14px;
        padding: 1.25rem;
        height: 100%;
    }

    .info-section-title {
        font-size: 0.8rem;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        color: #64748b;
        margin-bottom: 1rem;
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }

    .info-item {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 0.6rem 0;
        border-bottom: 1px dashed #e2e8f0;
    }

    .info-item:last-child {
        border-bottom: none;
    }

    .info-label {
        color: #64748b;
        font-size: 0.9rem;
    }

    .info-value {
        color: #0f172a;
        font-weight: 600;
        font-size: 0.925rem;
        text-align: right;
    }

    .btn-action-primary {
        background: linear-gradient(135deg, #0284c7 0%, #0369a1 100%);
        color: #ffffff;
        font-weight: 600;
        padding: 0.75rem 1.5rem;
        border-radius: 10px;
        border: none;
        box-shadow: 0 4px 12px rgba(2, 132, 199, 0.2);
        transition: all 0.2s ease;
    }

    .btn-action-primary:hover {
        background: linear-gradient(135deg, #0369a1 0%, #075985 100%);
        color: #ffffff;
        transform: translateY(-1px);
        box-shadow: 0 6px 16px rgba(2, 132, 199, 0.3);
    }

    /* Custom Status Badges */
    .badge-status-CONFIRMED, .badge-status-SCHEDULED {
        background-color: #e0f2fe;
        color: #0369a1;
        border: 1px solid #bae6fd;
    }

    .badge-status-COMPLETED {
        background-color: #dcfce7;
        color: #15803d;
        border: 1px solid #bbf7d0;
    }

    .badge-status-CANCELLED {
        background-color: #fee2e2;
        color: #b91c1c;
        border: 1px solid #fecaca;
    }
</style>

<div class="row justify-content-center my-2">
    <div class="col-lg-8 col-xl-7">
        <div class="card details-card">
            <!-- Header -->
            <div class="details-card-header d-flex justify-content-between align-items-center">
                <div class="d-flex align-items-center gap-2">
                    <i class="bi bi-file-earmark-text text-primary fs-5"></i>
                    <h5 class="fw-bold mb-0 text-dark">Appointment Details</h5>
                </div>
                <span class="badge rounded-pill px-3 py-2 badge-status-${appointment.status}">
                    <c:out value="${appointment.status}"/>
                </span>
            </div>

            <!-- Body -->
            <div class="card-body p-4">
                <!-- Appointment Number Highlight Banner -->
                <div class="appt-number-banner text-center mb-4">
                    <div class="text-muted small fw-semibold text-uppercase tracking-wide mb-1">Appointment Reference</div>
                    <div class="appt-number-highlight">
                        #<c:out value="${appointment.appointmentNo}"/>
                    </div>
                </div>

                <!-- Info Grid -->
                <div class="row g-3 mb-4">
                    <!-- Patient Information Card -->
                    <div class="col-md-6">
                        <div class="info-section-card">
                            <div class="info-section-title">
                                <i class="bi bi-person-circle text-primary"></i>
                                <span>Patient Information</span>
                            </div>
                            <div class="info-item">
                                <span class="info-label"><i class="bi bi-person me-1"></i> Name</span>
                                <span class="info-value"><c:out value="${appointment.patientName}"/></span>
                            </div>
                            <div class="info-item">
                                <span class="info-label"><i class="bi bi-telephone me-1"></i> Contact</span>
                                <span class="info-value"><c:out value="${appointment.contactNumber}"/></span>
                            </div>
                            <div class="info-item">
                                <span class="info-label"><i class="bi bi-geo-alt me-1"></i> Address</span>
                                <span class="info-value"><c:out value="${appointment.address}"/></span>
                            </div>
                        </div>
                    </div>

                    <!-- Visit Details Card -->
                    <div class="col-md-6">
                        <div class="info-section-card">
                            <div class="info-section-title">
                                <i class="bi bi-calendar-check text-primary"></i>
                                <span>Visit Information</span>
                            </div>
                            <div class="info-item">
                                <span class="info-label"><i class="bi bi-person-badge me-1"></i> Dentist</span>
                                <span class="info-value"><c:out value="${appointment.dentistName}"/></span>
                            </div>
                            <div class="info-item">
                                <span class="info-label"><i class="bi bi-clipboard2-pulse me-1"></i> Treatment</span>
                                <span class="info-value"><c:out value="${appointment.treatmentName}"/></span>
                            </div>
                            <div class="info-item">
                                <span class="info-label"><i class="bi bi-calendar3 me-1"></i> Date</span>
                                <span class="info-value"><fmt:formatDate value="${appointment.appointmentDate}" pattern="dd MMM yyyy"/></span>
                            </div>
                            <div class="info-item">
                                <span class="info-label"><i class="bi bi-clock me-1"></i> Time</span>
                                <span class="info-value"><fmt:formatDate value="${appointment.appointmentTime}" pattern="hh:mm a"/></span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Action Button Group -->
                <div class="d-flex flex-wrap align-items-center justify-content-between gap-2 pt-3 border-top">
                    <a href="<%=request.getContextPath()%>/SearchAppointmentServlet" class="btn btn-light border fw-semibold text-secondary px-3 py-2">
                        <i class="bi bi-arrow-left me-1"></i> New Search
                    </a>
                    <div class="d-flex flex-wrap gap-2">
                        <a href="<%=request.getContextPath()%>/EditAppointmentServlet?id=${appointment.appointmentId}" class="btn btn-outline-secondary fw-semibold px-3 py-2">
                            <i class="bi bi-pencil-square me-1"></i> Edit / Reschedule
                        </a>
                        <a href="<%=request.getContextPath()%>/BillServlet?appointmentNo=${appointment.appointmentNo}" class="btn btn-action-primary text-decoration-none d-inline-flex align-items-center gap-2">
                            <i class="bi bi-receipt"></i>
                            <span>Calculate &amp; Print Bill</span>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="WEB-INF/jspf/footer.jspf" %>