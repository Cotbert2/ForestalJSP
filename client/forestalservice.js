import soap from 'soap';

const wsdlUrl = 'http://localhost:8080/forestal/ForestalSOAP?wsdl';


export const   getForestalZones = async () => {
  try {
    const client = await soap.createClientAsync(wsdlUrl);

    client.ForestalSOAP.ForestalServicePort.getForestalZones({}, function(err, result) {
        if (err) {
          console.error('Error while geting zones', err);
        } else {
          const zones = Array.isArray(result.return)
            ? result.return
            : result.return
              ? [result.return]
              : [];

            console.log('Zones:', zones);
          return zones;
        }
      });
      
  } catch (error) {
    console.error('Error:', error);
    return [];
  }
}


export function getTreeSpecies() {
    return new Promise((resolve, reject) => {
      soap.createClient(wsdlUrl, (err, client) => {
        if (err) {
          console.error('Failed to create SOAP client:', err);
          return reject([]);
        }
  
        if (
          client.ForestalSOAP &&
          client.ForestalSOAP.ForestalServicePort &&
          typeof client.ForestalSOAP.ForestalServicePort.getTreeeSpecies === 'function'
        ) {
          client.ForestalSOAP.ForestalServicePort.getTreeeSpecies({}, (err, result) => {
            if (err) {
              console.error('Error fetching tree species:', err);
              return reject([]);
            }
  
            const species = Array.isArray(result.return)
              ? result.return
              : result.return
                ? [result.return]
                : [];
  
            resolve(species);
          });
        } else {
          console.error('Method getTreeeSpecies not found in SOAP client.');
          reject([]);
        }
      });
    });
  }

  export function deleteTreeSpecies(uuid) {
    return new Promise((resolve, reject) => {
      soap.createClient(wsdlUrl, (err, client) => {
        if (err) {
          console.error('Failed to create SOAP client:', err);
          return reject(false);
        }
  
        if (
          client.ForestalSOAP &&
          client.ForestalSOAP.ForestalServicePort &&
          typeof client.ForestalSOAP.ForestalServicePort.deleteTreeSpecie === 'function'
        ) {
          const args = { uuid: uuid };
  
          client.ForestalSOAP.ForestalServicePort.deleteTreeSpecie(args, (err, result) => {
            if (err) {
              console.error('Error deleting tree species:', err);
              return reject(false);
            }
  
            resolve(result);
          });
        } else {
          console.error('Method deleteTreeSpecie not found in SOAP client.');
          reject(false);
        }
      });
    });
  }
  

  export function createForestalZone({ name, description, area, image, registerDate, mapJson }) {
    return new Promise((resolve, reject) => {
      soap.createClient(wsdlUrl, (err, client) => {
        if (err) {
          console.error('Failed to create SOAP client:', err);
          return reject(false);
        }
  
        if (
          client.ForestalSOAP &&
          client.ForestalSOAP.ForestalServicePort &&
          typeof client.ForestalSOAP.ForestalServicePort.createForestalZone === 'function'
        ) {
          const args = {
            name,
            description,
            area,
            image,
            registerDate,
            mapJson
          };
  
          client.ForestalSOAP.ForestalServicePort.createForestalZone(args, (err, result) => {
            if (err) {
              console.error('Error creating forestal zone:', err);
              return reject(false);
            }
  
            resolve(result);
          });
        } else {
          console.error('Method createForestalZone not found in SOAP client.');
          reject(false);
        }
      });
    });
  }
  