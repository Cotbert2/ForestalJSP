
const downloadCSVFileFromTable = (tableId, filename) => {

    let csvContent = "data:text/csv;charset=utf-8,";
    /*Set header for csv file */

    console.log('headddd', document.querySelectorAll(`#${tableId}`));

    document.querySelectorAll(`#${tableId} thead`).forEach(header => {
        console.log('header', header);

        let dataRow = [];
        header.querySelectorAll('th').forEach(cell => {
            dataRow.push(cell.innerText);
        });
        csvContent += dataRow.join(',') + '\n';
    });



    document.querySelectorAll(`#${tableId} tbody tr`).forEach(row => {
        console.log(row);
        let dataRow = [];
        row.querySelectorAll('td').forEach(cell => {
            console.log(cell);
            dataRow.push(cell.innerText);
        });
        csvContent += dataRow.join(',') + '\n';

    });

    let encodedUri = encodeURI(csvContent);
    let link = document.createElement("a");
    link.setAttribute("href", encodedUri);
    link.setAttribute("download", `${filename}.csv`);
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
}