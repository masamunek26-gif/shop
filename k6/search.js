import http from 'k6/http';
import { check, sleep } from 'k6';

const BASE = __ENV.BASE_URL || 'http://localhost:8080';
const WORDS = ['Смартфон', 'Наушники', 'Ноутбук', 'Книга', 'Кроссовки', 'Кофе', 'Рюкзак', 'Часы'];

export const options = {
  stages: [
    { duration: '10s', target: 40 },
    { duration: '30s', target: 40 },
    { duration: '5s', target: 0 },
  ],
  thresholds: {
    http_req_failed: ['rate<0.01'],
    http_req_duration: ['p(95)<200'],
  },
};

export default function () {
  const q = WORDS[Math.floor(Math.random() * WORDS.length)];
  const res = http.get(`${BASE}/products/search?q=${encodeURIComponent(q)}`);
  check(res, { '200 OK': (r) => r.status === 200 });
  sleep(0.05);
}
