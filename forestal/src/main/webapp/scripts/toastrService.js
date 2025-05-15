const notyf = new Notyf({
    duration: 3000,
    position: {
    x: 'right',
    y: 'top'
    }
});

window.onSuccessToast = (message)  => {
    notyf.success(message);
}


window.onErrorToast = (message) => {
    notyf.error(message);
}


window.onWarningToast = (message) => {
    notyf.error(message);
}


window.onInfoToast = (message) => {
    notyf.error(message);
}


