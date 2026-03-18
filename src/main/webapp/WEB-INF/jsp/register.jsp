<%@ include file="layout/header.jsp" %>
<style>
.register-container {
    max-width: 500px;
    margin: 40px auto;
    position: relative;
}

.register-header {
    text-align: center;
    margin-bottom: 35px;
}

.register-header h2 {
    color: #1e3a8a;
    font-size: 2rem;
    font-weight: 700;
    margin-bottom: 10px;
}

.register-header p {
    color: #64748b;
    font-size: 1rem;
    margin: 0;
}

.form-group {
    margin-bottom: 20px;
    position: relative;
}

.form-group label {
    display: block;
    font-weight: 600;
    color: #374151;
    margin-bottom: 8px;
    font-size: 0.95rem;
}

.form-group input,
.form-group select {
    width: 100%;
    padding: 14px 16px;
    border: 2px solid #e5e7eb;
    border-radius: 12px;
    font-size: 0.95rem;
    transition: all 0.3s ease;
    background: #ffffff;
}

.form-group input:focus,
.form-group select:focus {
    outline: none;
    border-color: #3b82f6;
    box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.1);
}

.password-strength {
    margin-top: 8px;
    height: 6px;
    background: #e5e7eb;
    border-radius: 3px;
    overflow: hidden;
}

.password-strength-bar {
    height: 100%;
    transition: all 0.3s ease;
    border-radius: 3px;
}

.strength-weak { background: #ef4444; width: 33%; }
.strength-medium { background: #f59e0b; width: 66%; }
.strength-strong { background: #10b981; width: 100%; }

.password-strength-text {
    font-size: 0.85rem;
    margin-top: 4px;
    font-weight: 500;
}

.role-cards {
    display: grid;
    gap: 12px;
    margin-top: 12px;
}

.role-card {
    padding: 16px;
    border: 2px solid #e5e7eb;
    border-radius: 12px;
    cursor: pointer;
    transition: all 0.3s ease;
    position: relative;
}

.role-card:hover {
    border-color: #3b82f6;
    background: #f8fafc;
}

.role-card.selected {
    border-color: #3b82f6;
    background: #eff6ff;
}

.role-card input[type="radio"] {
    position: absolute;
    opacity: 0;
}

.role-title {
    font-weight: 600;
    color: #1f2937;
    margin-bottom: 4px;
}

.role-description {
    font-size: 0.85rem;
    color: #6b7280;
    line-height: 1.4;
}

.checkbox-group {
    display: flex;
    align-items: flex-start;
    gap: 12px;
    margin: 24px 0;
}

.checkbox-group input[type="checkbox"] {
    width: 18px;
    height: 18px;
    margin-top: 2px;
    accent-color: #3b82f6;
}

.checkbox-group label {
    font-size: 0.9rem;
    color: #6b7280;
    line-height: 1.5;
    cursor: pointer;
}

.checkbox-group a {
    color: #3b82f6;
    text-decoration: none;
    font-weight: 500;
}

.checkbox-group a:hover {
    text-decoration: underline;
}

.error-message {
    background: linear-gradient(135deg, #fef2f2, #fee2e2);
    border: 1px solid #fecaca;
    color: #991b1b;
    padding: 16px;
    border-radius: 12px;
    margin-bottom: 24px;
    font-weight: 500;
    display: flex;
    align-items: center;
    gap: 12px;
}

.error-message::before {
    content: "⚠️";
    font-size: 1.2rem;
}

.success-message {
    background: linear-gradient(135deg, #f0fdf4, #dcfce7);
    border: 1px solid #bbf7d0;
    color: #166534;
    padding: 16px;
    border-radius: 12px;
    margin-bottom: 24px;
    font-weight: 500;
    display: flex;
    align-items: center;
    gap: 12px;
}

.success-message::before {
    content: "✅";
    font-size: 1.2rem;
}

.register-btn {
    width: 100%;
    padding: 16px;
    background: linear-gradient(135deg, #1e3a8a, #3b82f6);
    color: white;
    border: none;
    border-radius: 12px;
    font-size: 1rem;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s ease;
    margin-top: 12px;
    position: relative;
    overflow: hidden;
}

.register-btn:hover {
    background: linear-gradient(135deg, #1e40af, #2563eb);
    transform: translateY(-2px);
    box-shadow: 0 10px 25px rgba(59, 130, 246, 0.3);
}

.register-btn:active {
    transform: translateY(0);
}

.register-btn:disabled {
    opacity: 0.6;
    cursor: not-allowed;
    transform: none;
}

.divider {
    text-align: center;
    margin: 30px 0;
    position: relative;
}

.divider::before {
    content: '';
    position: absolute;
    top: 50%;
    left: 0;
    right: 0;
    height: 1px;
    background: #e5e7eb;
}

.divider span {
    background: white;
    padding: 0 16px;
    color: #6b7280;
    font-size: 0.9rem;
    position: relative;
}

.social-login {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 12px;
    margin-top: 20px;
}

.social-btn {
    padding: 12px;
    border: 2px solid #e5e7eb;
    background: white;
    border-radius: 12px;
    cursor: pointer;
    transition: all 0.3s ease;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
    font-weight: 500;
    color: #374151;
}

.social-btn:hover {
    border-color: #d1d5db;
    background: #f9fafb;
    transform: translateY(-1px);
}

.login-link {
    text-align: center;
    margin-top: 24px;
    padding-top: 24px;
    border-top: 1px solid #e5e7eb;
    color: #6b7280;
    font-size: 0.95rem;
}

.login-link a {
    color: #3b82f6;
    text-decoration: none;
    font-weight: 600;
}

.login-link a:hover {
    text-decoration: underline;
}

.input-icon {
    position: relative;
}

.input-icon input {
    padding-left: 45px;
}

.input-icon::before {
    content: "";
    position: absolute;
    left: 16px;
    top: 50%;
    transform: translateY(-50%);
    font-size: 1.1rem;
    z-index: 1;
}

.input-icon.email::before { content: "📧"; }
.input-icon.password::before { content: "🔒"; }
.input-icon.name::before { content: "👤"; }

@media (max-width: 640px) {
    .register-container {
        margin: 20px;
        max-width: none;
    }
    
    .social-login {
        grid-template-columns: 1fr;
    }
}
</style>

<div class="register-container">
    <div class="card">
        <div class="register-header">
            <h2>Create Your Account</h2>
            <p>Join CoursePulse and start participating in course surveys</p>
        </div>

        <c:if test="${error != null}">
            <div class="error-message">${error}</div>
        </c:if>
        
        <c:if test="${success != null}">
            <div class="success-message">${success}</div>
        </c:if>

        <form action="/register" method="post" id="registerForm">
            <div class="form-group input-icon email">
                <label for="username">Email Address</label>
                <input type="email" id="username" name="username" required placeholder="your.email@example.com" />
            </div>
            
            <div class="form-group input-icon password">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required placeholder="Create a strong password" oninput="checkPasswordStrength()" />
                <div class="password-strength">
                    <div class="password-strength-bar" id="strengthBar"></div>
                </div>
                <div class="password-strength-text" id="strengthText"></div>
            </div>
            
            <div class="form-group input-icon name">
                <label for="fullName">Full Name</label>
                <input type="text" id="fullName" name="fullName" required placeholder="John Doe" />
            </div>
            
            <div class="form-group">
                <label>Select Your Role</label>
                <div class="role-cards">
                    <div class="role-card" onclick="selectRole('RESPONDENT', this)">
                        <input type="radio" name="role" value="RESPONDENT" id="role-respondent" checked>
                        <div class="role-title">🎓 Student Participant</div>
                        <div class="role-description">Participate in course surveys and provide feedback to improve the learning experience</div>
                    </div>
                    
                    <div class="role-card" onclick="selectRole('TEACHER', this)">
                        <input type="radio" name="role" value="TEACHER" id="role-teacher">
                        <div class="role-title">👨‍🏫 Course Teacher</div>
                        <div class="role-description">Create and manage surveys for your courses (Requires admin approval)</div>
                    </div>
                    
                    <div class="role-card" onclick="selectRole('INITIATOR', this)">
                        <input type="radio" name="role" value="INITIATOR" id="role-initiator">
                        <div class="role-title">📊 Survey Initiator</div>
                        <div class="role-description">Design comprehensive surveys and analyze results across multiple courses</div>
                    </div>
                </div>
            </div>
            
            <div class="checkbox-group">
                <input type="checkbox" id="terms" name="terms" required>
                <label for="terms">
                    I agree to the <a href="/terms" target="_blank">Terms of Service</a> and <a href="/privacy" target="_blank">Privacy Policy</a>
                </label>
            </div>
            
            <button type="submit" class="register-btn" id="submitBtn">
                Complete Registration
            </button>
        </form>

        <div class="divider">
            <span>OR</span>
        </div>

        <div class="social-login">
            <button type="button" class="social-btn" onclick="alert('Google sign-in coming soon!')">
                🚀 Sign in with Google
            </button>
            <button type="button" class="social-btn" onclick="alert('Microsoft sign-in coming soon!')">
                💼 Sign in with Microsoft
            </button>
        </div>

        <div class="login-link">
            Already have an account? <a href="/login">Sign in here</a>
        </div>
    </div>
</div>

<script>
function selectRole(role, element) {
    document.querySelectorAll('.role-card').forEach(card => {
        card.classList.remove('selected');
    });
    element.classList.add('selected');
    document.getElementById('role-' + role.toLowerCase()).checked = true;
}

function checkPasswordStrength() {
    const password = document.getElementById('password').value;
    const strengthBar = document.getElementById('strengthBar');
    const strengthText = document.getElementById('strengthText');
    
    let strength = 0;
    
    if (password.length >= 8) strength++;
    if (password.match(/[a-z]/) && password.match(/[A-Z]/)) strength++;
    if (password.match(/[0-9]/)) strength++;
    if (password.match(/[^a-zA-Z0-9]/)) strength++;
    
    strengthBar.className = 'password-strength-bar';
    
    if (password.length === 0) {
        strengthBar.style.width = '0';
        strengthText.textContent = '';
        strengthText.style.color = '';
    } else if (strength <= 1) {
        strengthBar.classList.add('strength-weak');
        strengthText.textContent = 'Weak password - add more characters';
        strengthText.style.color = '#ef4444';
    } else if (strength === 2) {
        strengthBar.classList.add('strength-medium');
        strengthText.textContent = 'Medium strength - could be stronger';
        strengthText.style.color = '#f59e0b';
    } else {
        strengthBar.classList.add('strength-strong');
        strengthText.textContent = 'Strong password! 🔒';
        strengthText.style.color = '#10b981';
    }
}

document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('registerForm');
    const submitBtn = document.getElementById('submitBtn');
    
    form.addEventListener('submit', function(e) {
        if (!document.getElementById('terms').checked) {
            e.preventDefault();
            alert('Please accept the Terms of Service and Privacy Policy to continue.');
            return;
        }
        
        submitBtn.disabled = true;
        submitBtn.textContent = 'Creating Account...';
    });
});
</script>

<%@ include file="layout/footer.jsp" %>
