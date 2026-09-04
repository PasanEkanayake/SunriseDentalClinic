<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="WEB-INF/jspf/header.jspf" %>

<style>
    .page-title-icon {
        width: 48px;
        height: 48px;
        background: linear-gradient(135deg, #e0f2fe 0%, #bae6fd 100%);
        color: #0284c7;
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .main-card {
        border: 1px solid #e2e8f0;
        border-radius: 18px;
        background: #ffffff;
        box-shadow: 0 10px 30px rgba(10, 37, 64, 0.04);
        overflow: hidden;
    }

    .filter-card {
        background-color: #f8fafc;
        border: 1px solid #e2e8f0;
        border-radius: 12px;
        padding: 1rem;
    }

    .appt-no-badge {
        font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, monospace;
        font-weight: 700;
        color: #0369a1;
        background: #f0f9ff;
        padding: 0.3rem 0.6rem;
        border-radius: 8px;
        border: 1px solid #bae6fd;
        font-size: 0.85rem;
    }

    .table > :not(caption) > * > * {
        padding: 0.9rem 1rem;
        vertical-align: middle;
    }

    .btn-action-icon {
        width: 34px;
        height: 34px;
        padding: 0;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        border-radius: 8px;
        transition: all 0.2s ease;
    }

    .btn-action-icon:hover {
        transform: translateY(-1px);
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

    .custom-alert {
        border: none;
        border-radius: 12px;
        padding: 0.85rem 1.25rem;
    }

    .btn-primary-gradient {
        background: linear-gradient(135deg, #0284c7 0%, #0369a1 100%);
        color: #ffffff;
        font-weight: 600;
        border: none;
        border-radius: 10px;
        padding: 0.6rem 1.2rem;
        box-shadow: 0 4px 12px rgba(2, 132, 199, 0.2);
        transition: all 0.2s ease;
    }

    .btn-primary-gradient:hover {
        background: linear-gradient(135deg, #0369a1 0%, #075985 100%);
        color: #ffffff;
        transform: translateY(-1px);
        box-shadow: 0 6px 16px rgba(2, 132, 199, 0.3);
    }
</style>

<!-- Feedback Alerts -->
<c:if test="${param.updated == '1'}">
    <div class="alert custom-alert alert-success bg-success-subtle text-success border border-success-subtle d-flex align-items-center gap-2 mb-4" role="alert">
        <i class="bi bi-check-circle-fill fs-5"></i>
        <div>Appointment updated successfully.</div>
    </div>
</c:if>
<c:if test="${param.cancelled == '1'}">
    <div class="alert custom-alert alert-success bg-success-subtle text-success border border-success-subtle d-flex align-items-center gap-2 mb-4" role="alert">
        <i class="bi bi-check-circle-fill fs-5"></i>
        <div>Appointment cancelled successfully.</div>
    </div>
</c:if>

<!-- Page Header & Action Bar -->
<div class="d-flex flex-wrap align-items-center justify-content-between gap-3 mb-4">
    <div class="d-flex align-items-center gap-3">
        <div class="page-title-icon fs-4">
            <i class="bi bi-calendar2-week"></i>
        </div>
        <div>
            <h4 class="fw-bold text-dark mb-0">Appointments Directory</h4>
            <p class="text-muted small mb-0">View, search, and manage patient appointments</p>
        </div>
    </div>
    <a href="<%=request.getContextPath()%>/RegisterAppointmentServlet" class="btn btn-primary-gradient d-inline-flex align-items-center gap-2 text-decoration-none">
        <i class="bi bi-plus-lg"></i>
        <span>New Appointment</span>
    </a>
</div>

<!-- Main Table Container -->
<div class="card main-card">
    <div class="card-body p-4">
        
        <!-- Filter Controls -->
        <div class="filter-card mb-4">
            <form method="get" class="row g-3 align-items-center">
                <div class="col-md-5 col-lg-4">
                    <label class="form-label small fw-semibold text-secondary mb-1">
                        <i class="bi bi-person-badge me-1"></i> Filter by Dentist
                    </label>
                    <select name="dentist" class="form-select form-select-sm" onchange="this.form.submit()">
                        <option value="">-- All Dentists --</option>
                        <c:forEach var="name" items="${dentistNames}">
                            <option value="${name}" ${dentistFilter == name ? 'selected' : ''}><c:out value="${name}"/></option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-5 col-lg-4">
                    <label class="form-label small fw-semibold text-secondary mb-1">
                        <i class="bi bi-funnel me-1"></i> Filter by Status
                    </label>
                    <select name="status" class="form-select form-select-sm" onchange="this.form.submit()">
                        <option value="">-- All Statuses --</option>
                        <option value="SCHEDULED" ${statusFilter == 'SCHEDULED' ? 'selected' : ''}>Scheduled</option>
                        <option value="COMPLETED" ${statusFilter == 'COMPLETED' ? 'selected' : ''}>Completed</option>
                        <option value="CANCELLED" ${statusFilter == 'CANCELLED' ? 'selected' : ''}>Cancelled</option>
                    </select>
                </div>
                <c:if test="${not empty dentistFilter or not empty statusFilter}">
                    <div class="col-md-2 col-lg-4 d-flex align-items-end">
                        <a href="<%=request.getContextPath()%>/ViewAppointmentsServlet" class="btn btn-sm btn-link text-decoration-none text-muted mb-1">
                            <i class="bi bi-x-circle me-1"></i> Clear Filters
                        </a>
                    </div>
                </c:if>
            </form>
        </div>

        <!-- Appointments Table -->
        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
                <thead class="table-light text-secondary small text-uppercase">
                <tr>
                    <th scope="col" style="min-width: 110px;">Appt No.</th>
                    <th scope="col">Patient Name</th>
                    <th scope="col">Dentist</th>
                    <th scope="col">Treatment</th>
                    <th scope="col">Date</th>
                    <th scope="col">Time</th>
                    <th scope="col">Status</th>
                    <th scope="col" class="text-end" style="min-width: 160px;">Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${empty appointments}">
                        <tr>
                            <td colspan="8" class="text-center py-5 text-muted">
                                <i class="bi bi-calendar-x fs-1 opacity-50 d-block mb-2"></i>
                                <span>No appointments match your filter criteria.</span>
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="a" items="${appointments}">
                            <tr>
                                <td>
                                    <span class="appt-no-badge">#<c:out value="${a.appointmentNo}"/></span>
                                </td>
                                <td>
                                    <span class="fw-semibold text-dark"><c:out value="${a.patientName}"/></span>
                                </td>
                                <td><c:out value="${a.dentistName}"/></td>
                                <td><c:out value="${a.treatmentName}"/></td>
                                <td class="text-nowrap">
                                    <i class="bi bi-calendar3 text-muted me-1 small"></i>
                                    <fmt:formatDate value="${a.appointmentDate}" pattern="dd MMM yyyy"/>
                                </td>
                                <td class="text-nowrap">
                                    <i class="bi bi-clock text-muted me-1 small"></i>
                                    <fmt:formatDate value="${a.appointmentTime}" pattern="hh:mm a"/>
                                </td>
                                <td>
                                    <span class="badge rounded-pill badge-status-${a.status} px-2.5 py-1">
                                        <c:out value="${a.status}"/>
                                    </span>
                                </td>
                                <td class="text-end">
                                    <div class="d-inline-flex gap-1">
                                        <a class="btn btn-sm btn-outline-primary btn-action-icon" data-bs-toggle="tooltip" title="View Details"
                                           href="<%=request.getContextPath()%>/SearchAppointmentServlet?appointmentNo=${a.appointmentNo}">
                                            <i class="bi bi-eye"></i>
                                        </a>
                                        <a class="btn btn-sm btn-outline-secondary btn-action-icon" data-bs-toggle="tooltip" title="Edit Appointment"
                                           href="<%=request.getContextPath()%>/EditAppointmentServlet?id=${a.appointmentId}">
                                            <i class="bi bi-pencil"></i>
                                        </a>
                                        <a class="btn btn-sm btn-outline-success btn-action-icon" data-bs-toggle="tooltip" title="Generate Bill"
                                           href="<%=request.getContextPath()%>/BillServlet?appointmentNo=${a.appointmentNo}">
                                            <i class="bi bi-receipt"></i>
                                        </a>
                                        <c:if test="${a.status != 'CANCELLED' and sessionScope.staffRole == 'ADMIN'}">
                                            <form method="post" action="<%=request.getContextPath()%>/CancelAppointmentServlet" class="d-inline"
                                                  onsubmit="return confirm('Are you sure you want to cancel appointment #${a.appointmentNo}?');">
                                                <input type="hidden" name="appointmentId" value="${a.appointmentId}">
                                                <button type="submit" class="btn btn-sm btn-outline-danger btn-action-icon" data-bs-toggle="tooltip" title="Cancel Appointment">
                                                    <i class="bi bi-x-lg"></i>
                                                </button>
                                            </form>
                                        </c:if>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@ include file="WEB-INF/jspf/footer.jspf" %>