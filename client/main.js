import { createForestalZone } from './forestalservice.js';

async function main() {
  const newZone = {
    name: 'Reserva Cuyabeno',
    description: 'Área de protección ambiental y biodiversidad',
    area: 459.67,
    image: 'base64-encoded-image-here',
    registerDate: '2025-05-24 14:30:00',
    mapJson: '{"type":"FeatureCollection","features":[]}'
  };

  const result = await createForestalZone(newZone);
  console.log('Zone created:', result);
}

main();
