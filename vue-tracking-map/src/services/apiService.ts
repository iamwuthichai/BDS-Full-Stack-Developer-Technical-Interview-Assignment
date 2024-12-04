import axios, { type AxiosInstance, type AxiosResponse } from 'axios';
import { API_BASE_URL } from '@/config';

class ApiService {
  private http: AxiosInstance;

  constructor() {
    this.http = axios.create({
      baseURL: API_BASE_URL, // URL ของ API ที่ใช้บ่อย
      timeout: 10000, // กำหนด timeout
      headers: {
        'Content-Type': 'application/json',
      },
    });

    // Interceptors (กรณีต้องการจัดการ Token, Header)
    this.http.interceptors.request.use(
      (config) => {
        // เพิ่ม Header หรือ Token ได้ที่นี่
        config.headers['Authorization'] = `Bearer your-token-here`;
        return config;
      },
      (error) => Promise.reject(error)
    );

    this.http.interceptors.response.use(
      (response) => response,
      (error) => {
        // Handle error เช่น ตรวจสอบ status code
        console.error('API Error:', error);
        return Promise.reject(error);
      }
    );
  }

  // ตัวอย่างการเรียก GET
  async get<T>(url: string, params?: Record<string, any>): Promise<T> {
    const response: AxiosResponse<T> = await this.http.get(url, { params });
    return response.data;
  }

  // ตัวอย่างการเรียก POST
  async post<T>(url: string, data: any): Promise<T> {
    const response: AxiosResponse<T> = await this.http.post(url, data);
    return response.data;
  }

  // PUT, DELETE ฯลฯ
}

export const apiService = new ApiService();
