import http from 'k6/http';
import { sleep } from 'k6';
import { login } from '../lib/helper.js';

const URL_BASE = __ENV.URL_BASE || 'http://app:3000';

export const options = {
  scenarios: {
    steady_load: {
      executor: 'constant-vus',
      vus: 10,           // Number of virtual users
      duration: '1m',    // How long to run
      exec: 'mainFlow',   // Function to execute
      gracefulStop: '30s', // Time to wait for iterations to finish
    },
  },
};

export function mainFlow() {
  http.get('{URL_BASE}/');
  sleep(1);
}
