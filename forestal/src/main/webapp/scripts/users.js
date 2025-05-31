document.addEventListener("DOMContentLoaded", () => {
    const table = document.querySelector("#usersTable");
    new simpleDatatables.DataTable(table, {
        perPage: 5,
        perPageSelect: [5, 10, 25, 50],
        searchable: true,
        sortable: true,
    });
});

const onUpdate = (uuid) => {
    let isValid = true;
    const name = document.getElementById('name-' + uuid);
    const lastname = document.getElementById('lastname-' + uuid);
    const email = document.getElementById('email-' + uuid);
    const phone = document.getElementById('phone-' + uuid);
    const role = document.getElementById('role-' + uuid);

    // Validaciones simples
    [name, lastname, email, phone].forEach(field => {
        if (field.value.trim() === "") {
            isValid = false;
            field.classList.add('border-red-500');
        } else {
            field.classList.remove('border-red-500');
        }
    });

    if (!isValid) {
        onWarningToast("Please fill in all required fields.");
        return;
    }

    console.log("Updating user with data:");
    console.log("UUID:", uuid);
    console.log("Name:", name.value);
    console.log("Lastname:", lastname.value);
    console.log("Email:", email.value);
    console.log("Phone:", phone.value);
    console.log("Role:", role.value);


    Swal.fire({
        title: "Are you sure?",
        text: "You won't be able to revert this!",
        icon: "warning",
        showCancelButton: true,
        confirmButtonText: "Yes, update it!"
    }).then((result) => {
        if (result.isConfirmed) {
            document.getElementById('uuidUpdate').value = uuid;
            document.getElementById('nameUpdate').value = name.value;
            document.getElementById('lastnameUpdate').value = lastname.value;
            document.getElementById('emailUpdate').value = email.value;
            document.getElementById('phoneUpdate').value = phone.value;
            document.getElementById('roleUpdate').value = role.value;
            document.getElementById('updateForm').submit();
        }
    });
};

const makeEditable = (uuid) => {
    const inputs = document.querySelectorAll("#user-info-" + uuid + " input");
    const saveBtn = document.querySelector("#btn-save-" + uuid);
    saveBtn.classList.toggle("hidden");

    if (inputs.length > 0) {
        inputs.forEach((input, index) => {
            if (index !== inputs.length - 1) {
                input.toggleAttribute("readonly");
                input.classList.toggle("text-gray-400");
            }
        });
        inputs[0].focus();
    } else {
        console.log("error xd");
    }
};

const makeReadOnly = (uuid) => {
    const inputs = document.querySelectorAll("#user-info-" + uuid + " input");
    const saveBtn = document.querySelector("#btn-save-" + uuid);
    saveBtn.classList.toggle("hidden");
    if (inputs) {
        inputs.forEach(input => {
            if (!input.hasAttribute("readonly")) {
                input.setAttribute("readonly", "");
                input.classList.toggle("text-gray-400");
                input.focus();
            }
        });
        inputs[0].focus();
    } else {
        console.log("error xd");
    }
};



const onDelete = (uuid) => {
    console.log("UUID to delete:", uuid);
    Swal.fire({
        title: "Are you sure?",
        text: "You won't be able to revert this!",
        icon: "warning",
        showCancelButton: true,
        confirmButtonText: "Yes, delete it!"
    }).then((result) => {
        if (result.isConfirmed) {
            document.getElementById('uuid').value = uuid;
            document.getElementById('deleteForm').submit();
        }
    });
}

function viewUserModal(uuid) {
    const modal = document.getElementById('modal-' + uuid);
    if (modal) {
        modal.classList.remove('hidden');
    }
}

document.addEventListener("DOMContentLoaded", () => {
    const modals = document.querySelectorAll("[id^='modal-']");
    modals.forEach((modal) => {
        new Modal(modal);
    });
});

document.getElementById('userForm').addEventListener('submit', (e) => {
    e.preventDefault();

    let isValid = true;
    const form = e.target;

    const firstName = form.first_name_users.value.trim();
    const lastName = form.last_name_users.value.trim();
    const email = form.email_users.value.trim();
    const phone = form.phone_users.value.trim();
    const role = form.role_users.value.trim();
    const password = form.password_users.value.trim();

    // Expresiones regulares
    const nameRegex = /^[a-zA-ZÁÉÍÓÚáéíóúñÑ\s]+$/;
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    const phoneRegex = /^[0-9]{7,15}$/;
    const passwordRegex = /^[a-zA-Z0-9@#$_\-\.]+$/;

    [...form.elements].forEach(el => el.classList.remove('border-red-500'));

    if (!nameRegex.test(firstName)) {
        isValid = false;
        form.first_name_users.classList.add('border-red-500');
        onWarningToast("Nombre inválido.");
    }

    if (!nameRegex.test(lastName)) {
        isValid = false;
        form.last_name_users.classList.add('border-red-500');
        onWarningToast("Apellido inválido.");
    }

    if (!emailRegex.test(email)) {
        isValid = false;
        form.email_users.classList.add('border-red-500');
        onWarningToast("Correo inválido.");
    }

    if (existingEmails.includes(email)) {
        isValid = false;
        form.email_users.classList.add('border-red-500');
        onErrorToast("El correo ya existe en el sistema.");
    }

    if (!phoneRegex.test(phone)) {
        isValid = false;
        form.phone_users.classList.add('border-red-500');
        onWarningToast("Teléfono inválido.");
    }

    if (!passwordRegex.test(password)) {
        isValid = false;
        form.password_users.classList.add('border-red-500');
        onWarningToast("Contraseña con caracteres no permitidos.");
    }

    if (!isValid) return;

    form.submit();
});

