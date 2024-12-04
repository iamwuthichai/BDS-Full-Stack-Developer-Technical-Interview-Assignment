export interface SiteInterface {
  id: number;
  site_name: string;
  site_desc: string;
  site_address: string;
  site_tel?: string | null;
  site_open_time?: string | null;
  site_close_time?: string | null;
  location_type?: string | null;
  latitude?: number | null;
  longitude?: number | null;
  created_at: string;
  updated_at: string;
}
