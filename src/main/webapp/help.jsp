<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="WEB-INF/jspf/header.jspf" %>

<style>
    .help-card {
        border: 1px solid #e2e8f0;
        border-radius: 20px;
        background: #ffffff;
        box-shadow: 0 12px 32px rgba(10, 37, 64, 0.05);
        overflow: hidden;
    }

    .help-header-icon {
        width: 48px;
        height: 48px;
        background: linear-gradient(135deg, #e0f2fe 0%, #bae6fd 100%);
        color: #0284c7;
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .accordion-item {
        border: 1px solid #e2e8f0;
        border-radius: 12px !important;
        margin-bottom: 0.75rem;
        overflow: hidden;
    }

    .accordion-button {
        padding: 1.1rem 1.25rem;
        font-weight: 600;
        color: #1e293b;
        background-color: #ffffff;
        box-shadow: none !important;
    }

    .accordion-button:not(.collapsed) {
        background-color: #f0f9ff;
        color: #0369a1;
        border-bottom: 1px solid #bae6fd;
    }

    .step-badge {
        width: 32px;
        height: 32px;
        border-radius: 8px;
        background-color: #f1f5f9;
        color: #64748b;
        font-weight: 700;
        font-size: 0.85rem;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        margin-right: 0.85rem;
        flex-shrink: 0;
        transition: all 0.2s ease;
    }

    .accordion-button:not(.collapsed) .step-badge {
        background-color: #0284c7;
        color: #ffffff;
    }

    .accordion-body {
        padding: 1.5rem;
        color: #334155;
        line-height: 1.6;
    }

    .accordion-body ol {
        padding-left: 1.25rem;
        margin-bottom: 0;
    }

    .accordion-body li {
        margin-bottom: 0.75rem;
    }

    .accordion-body li:last-child {
        margin-bottom: 0;
    }

    .tip-box {
        background-color: #f8fafc;
        border-left: 4px solid #0284c7;
        border-radius: 0 10px 10px 0;
        padding: 0.85rem 1.1rem;
        font-size: 0.9rem;
    }

    .tip-box-admin {
        border-left-color: #ef4444;
        background-color: #fef2f2;
    }
</style>

<!-- Header Title -->
<div class="d-flex align-items-center gap-3 mb-4">
    <div class="help-header-icon fs-4">
        <i class="bi bi-journal-bookmark-fill"></i>
    </div>
    <div>
        <h4 class="fw-bold text-dark mb-0">System Help &amp; User Guide</h4>
        <p class="text-muted small mb-0">Step-by-step instructions for clinical workflows and administration</p>
    </div>
</div>

<div class="row justify-content-center">
    <div class="col-lg-10 col-xl-9">
        <div class="card help-card">
            <div class="card-body p-4 p-sm-5">
                <p class="text-secondary mb-4">New to the Sunrise Dental Clinic Management System? Expand any section below to learn how to perform routine daily tasks.</p>

                <div class="accordion" id="helpAccordion">

                    <!-- Section 1 -->
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#h1" aria-expanded="true">
                                <span class="step-badge">01</span>
                                <i class="bi bi-box-arrow-in-right me-2 opacity-75"></i> Logging In
                            </button>
                        </h2>
                        <div id="h1" class="accordion-collapse collapse show" data-bs-parent="#helpAccordion">
                            <div class="accordion-body">
                                <ol>
                                    <li>Open the system in your web browser to automatically reach the <strong>Login Page</strong>.</li>
                                    <li>Enter your assigned <strong>Username</strong> and <strong>Password</strong> provided by your administrator.</li>
                                    <li>Click <strong>Log In</strong>. If credentials are incorrect, a red alert banner will indicate the issue.</li>
                                    <li>Your session remains active during use. For security, inactive sessions expire after <strong>30 minutes</strong>.</li>
                                </ol>
                            </div>
                        </div>
                    </div>

                    <!-- Section 2 -->
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#h2">
                                <span class="step-badge">02</span>
                                <i class="bi bi-calendar-plus me-2 opacity-75"></i> Registering a New Appointment
                            </button>
                        </h2>
                        <div id="h2" class="accordion-collapse collapse" data-bs-parent="#helpAccordion">
                            <div class="accordion-body">
                                <ol>
                                    <li>From the Dashboard or main navigation, click <strong>New Appointment</strong>.</li>
                                    <li>Fill in the patient's full name, contact number, and residential address.</li>
                                    <li>Select the assigned <strong>Dentist</strong>, <strong>Treatment Type</strong>, date, and time slot.</li>
                                    <li>Click <strong>Register Appointment</strong>. The system verifies schedule availability automatically to prevent double-booking.</li>
                                    <li>Upon completion, the generated <strong>Appointment Number</strong> (e.g. <code>APT-000015</code>) will be displayed. Note this reference down for patient lookup.</li>
                                </ol>
                                <div class="tip-box mt-3">
                                    <i class="bi bi-info-circle-fill text-primary me-1"></i>
                                    <strong>Returning Patients:</strong> Entering an existing patient's matching name and contact number automatically links the visit to their historical record.
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Section 3 -->
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#h3">
                                <span class="step-badge">03</span>
                                <i class="bi bi-search me-2 opacity-75"></i> Searching for an Appointment
                            </button>
                        </h2>
                        <div id="h3" class="accordion-collapse collapse" data-bs-parent="#helpAccordion">
                            <div class="accordion-body">
                                <ol>
                                    <li>Click <strong>Search</strong> in the top navigation bar.</li>
                                    <li>Enter the exact appointment reference number (e.g., <code>APT-000015</code>) and click <strong>Search</strong>.</li>
                                    <li>The detail view will display patient records, appointment status, billing actions, and reschedule options.</li>
                                    <li>If you do not have the reference number, navigate to <strong>All Appointments</strong> to filter by dentist name or appointment status.</li>
                                </ol>
                            </div>
                        </div>
                    </div>

                    <!-- Section 4 -->
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#h4">
                                <span class="step-badge">04</span>
                                <i class="bi bi-receipt me-2 opacity-75"></i> Generating &amp; Printing a Bill
                            </button>
                        </h2>
                        <div id="h4" class="accordion-collapse collapse" data-bs-parent="#helpAccordion">
                            <div class="accordion-body">
                                <ol>
                                    <li>Locate the appointment via search or the appointment list and click <strong>Calculate &amp; Print Bill</strong>.</li>
                                    <li>The system calculates the total by adding the base <strong>Consultation Fee</strong> to the specific <strong>Treatment Fee</strong>.</li>
                                    <li>Click <strong>Print Bill / Receipt</strong> to launch the printer dialog for a formatted physical receipt.</li>
                                    <li>Re-accessing a previously generated bill displays the original calculated ledger state without duplications.</li>
                                </ol>
                            </div>
                        </div>
                    </div>

                    <!-- Section 5 -->
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#h5">
                                <span class="step-badge">05</span>
                                <i class="bi bi-pencil-square me-2 opacity-75"></i> Editing or Cancelling an Appointment
                            </button>
                        </h2>
                        <div id="h5" class="accordion-collapse collapse" data-bs-parent="#helpAccordion">
                            <div class="accordion-body">
                                <ol>
                                    <li>Open <strong>All Appointments</strong> to locate the target appointment entry.</li>
                                    <li>Click the <strong>Edit</strong> (pencil) icon to modify dentist assignments, procedure type, scheduled timing, or status.</li>
                                    <li>Appointment cancellations (using the <strong>Cancel</strong> icon) are restricted to <strong>Administrator</strong> accounts. Cancelled records are preserved in audit history.</li>
                                </ol>
                            </div>
                        </div>
                    </div>

                    <!-- Section 6 -->
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#h6">
                                <span class="step-badge">06</span>
                                <i class="bi bi-door-open me-2 opacity-75"></i> Logging Out / Exiting System
                            </button>
                        </h2>
                        <div id="h6" class="accordion-collapse collapse" data-bs-parent="#helpAccordion">
                            <div class="accordion-body">
                                <p class="mb-0">Select <strong>Logout</strong> in the top navigation bar when stepping away from your station. This invalidates the active server session to prevent unauthorized account access.</p>
                            </div>
                        </div>
                    </div>

                    <!-- Section 7 -->
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#h7">
                                <span class="step-badge">07</span>
                                <i class="bi bi-shield-lock me-2 opacity-75"></i> Admin Control Panel (Administrators Only)
                            </button>
                        </h2>
                        <div id="h7" class="accordion-collapse collapse" data-bs-parent="#helpAccordion">
                            <div class="accordion-body">
                                <p>Users assigned the <strong>ADMIN</strong> role have access to privileged clinic management tools:</p>
                                <ol>
                                    <li><strong>Manage Staff:</strong> Add staff accounts (Admin/Receptionist) and toggle active account statuses.</li>
                                    <li><strong>Manage Dentists:</strong> Register practitioner profiles or retire active dentists from future scheduling.</li>
                                    <li><strong>Manage Treatments:</strong> Configure available clinical procedures and set standard pricing.</li>
                                    <li><strong>Clinic Settings:</strong> Adjust clinic-wide parameters such as the default base consultation fee.</li>
                                </ol>
                                <div class="tip-box tip-box-admin mt-3">
                                    <i class="bi bi-shield-exclamation text-danger me-1"></i>
                                    <strong>Access Control:</strong> Receptionist accounts cannot access admin routes. Direct URL navigation to administration servlets is automatically blocked by access filters.
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="WEB-INF/jspf/footer.jspf" %>