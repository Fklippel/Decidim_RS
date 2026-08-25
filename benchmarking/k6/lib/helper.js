import { check } from 'k6';
import http from 'k6/http';
const URL_BASE = __ENV.URL_BASE || 'http://app:3000'
export function login(email, password) { 
	const loginPage = http.get(`${URL_BASE}/users/sign_in`);
	check(loginPage, {'login page loaded': (r) => r.status === 200,}); 
	const token = loginPage // procurando o token CSRF na página
	.html()
	.find('input[name="authenticity_token"]')
	.first()
	.attr('value');
	if (!token) { console.error(`CSRF token not found for ${email}`) } // registrando o erro
        const res = http.post(
		`${URL_BASE}/users/sign_in`,
		{ 
			'user[email]': email,
			'user[password]': password,
			authenticity_token: token,
		},
		{
			redirects: 5,
		} 
	);
       const success = check(res, {'login succeeded': (r) => r.status === 200,
	       'not redirected back to sign_in': (r) => !r.url.includes('/users/sign_in'),});
       if (!success) { console.error(`login failed ${email}. Status: ${res.status}`) } return res; }
       export function getCsrfToken(res) {
	       return res
	       .html()
	       .find('input[name="authenticity_token"], meta[name="csrf-token"]')
	       .first()
	       .attr('value') ||
	       res.html().find('meta[name="csrf-token"]').first().attr('content');
       }
