<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="WEB-INF/jspf/header.jspf" %>

<style>
    .receipt-card {
        border: 1px solid #e2e8f0;
        border-radius: 20px;
        background: #ffffff;
        box-shadow: 0 15px 35px rgba(10, 37, 64, 0.06);
        overflow: hidden;
    }

    .receipt-header-logo {
        width: 64px;
        height: 64px;
        background: linear-gradient(135deg, #e0f2fe 0%, #bae6fd 100%);
        border-radius: 16px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        box-shadow: 0 6px 16px rgba(2, 132, 199, 0.15);
    }

    .receipt-meta-box {
        background-color: #f8fafc;
        border: 1px solid #e2e8f0;
        border-radius: 14px;
        padding: 1.25rem;
    }

    .receipt-label {
        color: #64748b;
        font-size: 0.825rem;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        font-weight: 600;
    }

    .receipt-value {
        color: #0f172a;
        font-weight: 600;
        font-size: 0.95rem;
    }

    .table-receipt th {
        color: #64748b;
        font-size: 0.8rem;
        letter-spacing: 0.5px;
    }

    .table-receipt td, .table-receipt th {
        padding: 0.9rem 0.5rem;
    }

    .total-amount-box {
        background: linear-gradient(135deg, #f0f9ff 0%, #e0f2fe 100%);
        border: 1px solid #bae6fd;
        border-radius: 14px;
        padding: 1.25rem;
    }

    .total-amount-text {
        color: #0369a1;
        font-size: 1.65rem;
        font-weight: 800;
        letter-spacing: -0.5px;
    }

    .btn-print {
        background: linear-gradient(135deg, #0284c7 0%, #0369a1 100%);
        color: #ffffff;
        font-weight: 600;
        padding: 0.75rem 1.5rem;
        border-radius: 10px;
        border: none;
        box-shadow: 0 4px 12px rgba(2, 132, 199, 0.2);
        transition: all 0.2s ease;
    }

    .btn-print:hover {
        background: linear-gradient(135deg, #0369a1 0%, #075985 100%);
        color: #ffffff;
        transform: translateY(-1px);
        box-shadow: 0 6px 16px rgba(2, 132, 199, 0.3);
    }

    @media print {
        body {
            background: #ffffff !important;
            padding: 0 !important;
        }
        .no-print, header, footer, .navbar, .border-top {
            display: none !important;
        }
        .container, .row, .col-lg-7, .col-xl-6 {
            width: 100% !important;
            max-width: 100% !important;
            padding: 0 !important;
            margin: 0 !important;
        }
        .receipt-card {
            border: 1px solid #cbd5e1 !important;
            box-shadow: none !important;
            border-radius: 0 !important;
        }
        #printableBill {
            display: block !important;
        }
    }
</style>

<div class="row justify-content-center my-3">
    <div class="col-lg-7 col-xl-6">
        <!-- Printable Bill/Receipt Card -->
        <div class="card receipt-card" id="printableBill">
            <div class="card-body p-4 p-sm-5">
                <!-- Receipt Header -->
                <div class="text-center mb-4">
                    <div class="receipt-header-logo mb-3">
                        <img src="<%=request.getContextPath()%>/images/logo.svg" alt="Sunrise Dental Clinic logo" width="40" height="40">
                    </div>
                    <h4 class="fw-bold text-dark mb-1">Sunrise Dental Clinic</h4>
                    <p class="text-muted small mb-1">245 Galle Road, Colombo 03, Sri Lanka</p>
                    <span class="badge bg-primary-subtle text-primary border border-primary-subtle px-3 py-1 rounded-pill fw-semibold">
                        <i class="bi bi-receipt me-1"></i> Patient Bill &amp; Receipt
                    </span>
                </div>

                <!-- Receipt Metadata Grid -->
                <div class="receipt-meta-box mb-4">
                    <div class="row g-2">
                        <div class="col-6">
                            <span class="receipt-label d-block mb-1">Bill Number</span>
                            <span class="receipt-value text-primary">#<c:out value="${bill.billId}"/></span>
                        </div>
                        <div class="col-6 text-end">
                            <span class="receipt-label d-block mb-1">Appt Ref</span>
                            <span class="receipt-value">#<c:out value="${bill.appointmentNo}"/></span>
                        </div>
                        <div class="col-12"><hr class="my-2 text-muted opacity-25"></div>
                        <div class="col-6">
                            <span class="receipt-label d-block mb-1">Date Issued</span>
                            <span class="receipt-value"><fmt:formatDate value="${bill.generatedAt}" pattern="dd MMM yyyy, hh:mm a"/></span>
                        </div>
                        <div class="col-6 text-end">
                            <span class="receipt-label d-block mb-1">Patient Name</span>
                            <span class="receipt-value"><c:out value="${bill.patientName}"/></span>
                        </div>
                        <div class="col-6 mt-2">
                            <span class="receipt-label d-block mb-1">Attending Dentist</span>
                            <span class="receipt-value"><c:out value="${bill.dentistName}"/></span>
                        </div>
                        <div class="col-6 text-end mt-2">
                            <span class="receipt-label d-block mb-1">Treatment</span>
                            <span class="receipt-value"><c:out value="${bill.treatmentName}"/></span>
                        </div>
                    </div>
                </div>

                <!-- Financial Table -->
                <div class="table-responsive mb-4">
                    <table class="table table-borderless table-receipt align-middle mb-0">
                        <thead>
                        <tr class="border-bottom text-muted uppercase">
                            <th scope="col" class="ps-0">Service Description</th>
                            <th scope="col" class="text-end pe-0">Amount</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr class="border-bottom">
                            <td class="ps-0">
                                <div class="fw-semibold text-dark">Consultation Fee</div>
                                <div class="small text-muted">Standard clinical examination</div>
                            </td>
                            <td class="text-end pe-0 fw-semibold text-dark">
                                Rs. <fmt:formatNumber value="${bill.consultationFee}" pattern="#,##0.00"/>
                            </td>
                        </tr>
                        <tr class="border-bottom">
                            <td class="ps-0">
                                <div class="fw-semibold text-dark">Treatment Procedure</div>
                                <div class="small text-muted"><c:out value="${bill.treatmentName}"/></div>
                            </td>
                            <td class="text-end pe-0 fw-semibold text-dark">
                                Rs. <fmt:formatNumber value="${bill.treatmentCost}" pattern="#,##0.00"/>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>

                <!-- Total Summary Banner -->
                <div class="total-amount-box d-flex align-items-center justify-content-between mb-4">
                    <div>
                        <span class="text-uppercase fw-bold text-secondary small d-block">Total Amount Payable</span>
                        <span class="small text-muted">All fees included</span>
                    </div>
                    <div class="total-amount-text">
                        Rs. <fmt:formatNumber value="${bill.totalAmount}" pattern="#,##0.00"/>
                    </div>
                </div>

                <!-- Footer Note -->
                <div class="text-center text-muted small pt-2">
                    <i class="bi bi-heart-fill text-danger opacity-75 me-1"></i>
                    <span>Thank you for visiting Sunrise Dental Clinic. Wishing you a healthy smile!</span>
                </div>
            </div>
        </div>

        <!-- On-Screen Navigation & Print Controls -->
        <div class="d-flex flex-wrap align-items-center justify-content-between gap-2 mt-4 no-print">
            <a href="<%=request.getContextPath()%>/SearchAppointmentServlet?appointmentNo=${bill.appointmentNo}" class="btn btn-light border fw-semibold text-secondary px-3 py-2">
                <i class="bi bi-arrow-left me-1"></i> Back to Appointment
            </a>
            <button onclick="window.print()" class="btn btn-print d-inline-flex align-items-center gap-2">
                <i class="bi bi-printer"></i>
                <span>Print Bill / Receipt</span>
            </button>
        </div>
    </div>
</div>

<%@ include file="WEB-INF/jspf/footer.jspf" %>