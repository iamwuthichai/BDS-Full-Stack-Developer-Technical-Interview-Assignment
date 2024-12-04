import { apiService } from "./apiService";
import type { AxiosResponse } from "axios";
import type { SiteInterface } from "./types/Site";

export const fetchSites = async (): Promise<SiteInterface[]> => {
  try {
    const response = await apiService.get<SiteInterface[]>('/sites');
    console.log("Raw API Response:", response);
    return response;
  } catch (error) {
    console.error("Error fetching sites:", error);
    throw new Error("Error fetching sites");
  }
};
