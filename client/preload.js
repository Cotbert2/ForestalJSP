const { contextBridge } = require('electron');
const soapService = require('./forestalservice.js');

contextBridge.exposeInMainWorld('api', {
  getForestalZones: soapService.getForestalZones,
  getTreeSpecies: soapService.getTreeSpecies,
  deleteTreeSpecies: soapService.deleteTreeSpecies,
  createForestalZone: soapService.createForestalZone
});
