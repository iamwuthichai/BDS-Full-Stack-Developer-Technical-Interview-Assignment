<template>
  <MainLayout :headerTitle="'เลือกที่อยู่ส่งด่วน'">
    <div class="m-2">
      <!-- Search Input -->
      <label class="relative block">
        <span class="sr-only">Search</span>
        <span class="absolute inset-y-0 left-0 flex items-center pl-2">
          <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
            <path stroke-linecap="round" stroke-linejoin="round" d="m21 21-5.197-5.197m0 0A7.5 7.5 0 1 0 5.196 5.196a7.5 7.5 0 0 0 10.607 10.607Z" />
          </svg>
        </span>
        <input
          class="placeholder:italic placeholder:text-slate-400 block bg-white w-full border border-slate-300 py-2 pl-9 pr-3 shadow-sm focus:outline-none focus:border-sky-500 focus:ring-sky-500 focus:ring-1 sm:text-sm rounded-full text-black"
          placeholder="ค้นหาที่อยู่จัดส่งสินค้า"
          type="text"
          name="search"
          v-model="searchQuery"
          @input="filterLocations"
        />
      </label>

      <!-- Dropdown List -->
      <ul
        v-if="filteredLocations.length"
        class="absolute bg-white border border-gray-300 mt-2 w-full max-h-48 overflow-y-auto shadow-lg rounded-md z-10"
      >
        <li
          v-for="location in filteredLocations"
          :key="location.id"
          @click="selectLocation(location)"
          class="px-4 py-2 text-black hover:bg-blue-100 cursor-pointer"
        >
          {{ location.site_name }} (เวลาเปิดปิดร้าน: {{ location.site_open_time }} - {{ location.site_close_time }})
        </li>
      </ul>
    </div>

    <!-- Use Component -->
    <MapInfo
      v-model:address="address"
      :btnDisabled="btnDisabled"
      :searchQuery="searchQuery"
      :searchlocationName="searchlocationName"
      :initialPosition="initialPosition"
    />

  </MainLayout>
</template>

<script setup lang="ts">
import { ref, onMounted } from "vue";
import MainLayout from "@/components/layouts/MainLayout.vue";
import MapInfo from "../components/MapInfo.vue";

import { fetchSites } from "@/services/siteService";
import type { SiteInterface } from "@/services/types/Site";

// State
const btnDisabled = ref(false);
const address = ref<string | null>(null);
const searchQuery = ref<string>("");
const searchlocationName = ref<string>("");
const initialPosition = ref<object>({});
const sites = ref<SiteInterface[]>([]); // ข้อมูลที่ได้จาก API
const filteredLocations = ref<SiteInterface[]>([]);
const loading = ref<boolean>(true);
const error = ref<string | null>(null);

// Methods
const loadSites = async () => {
  loading.value = true;
  try {
    sites.value = await fetchSites(); // แทน locationData ด้วยข้อมูล API
    error.value = null;
  } catch (err) {
    console.error(err);
    error.value = "ไม่สามารถโหลดข้อมูลได้";
  } finally {
    loading.value = false;
  }
};

const filterLocations = () => {
  // ใช้ข้อมูลจาก `sites` แทนข้อมูล Mockup
  if (searchQuery.value.length >= 1) {
    filteredLocations.value = sites.value.filter((location) =>
      location.site_name.includes(searchQuery.value)
    );
  } else {
    filteredLocations.value = [];
  }
};

const selectLocation = (locationName: any) => {
  const locationInfo = locationName.site_name + ' | ' + locationName.site_address;
  // console.log(locationInfo);
  searchlocationName.value = locationName.site_name;
  searchQuery.value = locationInfo;
  address.value = locationInfo;
  filteredLocations.value = [];
  searchQuery.value = "";

  // Set Position
  initialPosition.value = {
    lat: parseFloat(locationName.latitude),
    lng: parseFloat(locationName.longitude)
  };
  console.log(initialPosition.value);
};

// Lifecycle Hook
onMounted(() => {
  loadSites(); // โหลดข้อมูลเมื่อ component ถูก mount
});
</script>

<style scoped>
/* เพิ่ม style ให้ dropdown responsive */
</style>
